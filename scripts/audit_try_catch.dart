import 'dart:io';
import 'dart:convert';

// ==============================================================================
// CONFIGURAÇÃO E REGRAS
// ==============================================================================

enum RiskLevel { LOW, MEDIUM, HIGH }

class AuditRule {
  final String id;
  final String category;
  final RegExp pattern;
  final RiskLevel risk;
  final String? requiredProtection; // Ex: '.catchError', 'onError' (opcional)

  AuditRule({
    required this.id,
    required this.category,
    required this.pattern,
    required this.risk,
    this.requiredProtection,
  });
}

final List<AuditRule> rules = [
  // 1. FILE I/O
  AuditRule(
    id: 'FILE_READ',
    category: 'FILE_IO',
    pattern: RegExp(r'(File|Directory|Link)\s*\(.*?\)\.(read|write|create|delete|exists|stat)'),
    risk: RiskLevel.HIGH,
  ),
  AuditRule(
    id: 'FILE_SYNC',
    category: 'FILE_IO',
    pattern: RegExp(r'\.(read|write).*?Sync\('),
    risk: RiskLevel.MEDIUM,
  ),

  // 2. NETWORK
  AuditRule(
    id: 'HTTP_CALL',
    category: 'NETWORK',
    pattern: RegExp(r'(http|dio)\.(get|post|put|delete|patch|head)\('),
    risk: RiskLevel.HIGH,
  ),
  AuditRule(
    id: 'HTTP_CLIENT',
    category: 'NETWORK',
    pattern: RegExp(r'HttpClient\(\)\.open'),
    risk: RiskLevel.HIGH,
  ),

  // 3. PARSING
  AuditRule(
    id: 'JSON_DECODE',
    category: 'PARSING',
    pattern: RegExp(r'(jsonDecode|json\.decode|base64Decode|base64\.decode)'),
    risk: RiskLevel.MEDIUM,
  ),
  AuditRule(
    id: 'DATE_PARSE',
    category: 'PARSING',
    pattern: RegExp(r'DateTime\.parse\('),
    risk: RiskLevel.LOW,
  ),

  // 4. DATABASE / STORAGE
  AuditRule(
    id: 'DB_OPEN',
    category: 'DB',
    pattern: RegExp(r'(openDatabase|Hive\.openBox|SharedPreferences\.getInstance)'),
    risk: RiskLevel.HIGH,
  ),

  // 5. PLATFORM CHANNELS (Nativo)
  AuditRule(
    id: 'METHOD_CHANNEL',
    category: 'PLATFORM_CHANNEL',
    pattern: RegExp(r'MethodChannel\s*\(.*?\)\.invokeMethod'),
    risk: RiskLevel.HIGH,
  ),

  // 6. ASYNC / STREAMS
  AuditRule(
    id: 'STREAM_LISTEN',
    category: 'STREAM',
    pattern: RegExp(r'\.listen\('),
    risk: RiskLevel.MEDIUM,
    requiredProtection: 'onError', // listen DEVE ter onError se não estiver em try/catch (difícil checar aqui, mas serve de alerta)
  ),
  
  // 7. PERMISSIONS
  AuditRule(
    id: 'PERMISSION_REQ',
    category: 'PERMISSION',
    pattern: RegExp(r'Permission\..*?\.request\('),
    risk: RiskLevel.HIGH,
  ),
];

// ==============================================================================
// MODELOS DE DADOS
// ==============================================================================

class AuditIssue {
  final String filePath;
  final int lineNumber;
  final String lineContent;
  final String ruleId;
  final String category;
  final RiskLevel risk;
  final bool isProtected;
  final String protectionType; // 'TRY_CATCH', 'CATCH_ERROR', 'ON_ERROR', 'NONE'

  AuditIssue({
    required this.filePath,
    required this.lineNumber,
    required this.lineContent,
    required this.ruleId,
    required this.category,
    required this.risk,
    required this.isProtected,
    required this.protectionType,
  });

  Map<String, dynamic> toJson() => {
    'file': filePath,
    'line': lineNumber,
    'content': lineContent.trim(),
    'rule': ruleId,
    'category': category,
    'risk': risk.toString().split('.').last,
    'protected': isProtected,
    'protectionType': protectionType,
  };
}

class AuditStats {
  int totalFiles = 0;
  int totalIssues = 0;
  int protectedIssues = 0;
  int unprotectedIssues = 0;
  Map<String, int> byCategory = {};
  Map<String, int> byRisk = {};

  double get protectionRate => totalIssues == 0 ? 100.0 : (protectedIssues / totalIssues) * 100;
}

// ==============================================================================
// LÓGICA DE AUDITORIA
// ==============================================================================

void main(List<String> args) async {
  print('🔍 Iniciando Auditoria de Estabilidade (Try/Catch Guard)...');
  
  final targetDir = Directory('lib');
  if (!targetDir.existsSync()) {
    print('❌ Diretório lib/ não encontrado.');
    exit(1);
  }

  final files = targetDir
      .listSync(recursive: true)
      .where((e) => e is File && e.path.endsWith('.dart'))
      .cast<File>()
      .toList();

  final issues = <AuditIssue>[];
  final stats = AuditStats();
  stats.totalFiles = files.length;

  print('📂 Analisando ${files.length} arquivos Dart...');

  for (final file in files) {
    try {
      final fileIssues = analyzeFile(file);
      issues.addAll(fileIssues);
    } catch (e) {
      print('⚠️ Erro ao analisar ${file.path}: $e');
    }
  }

  // Processar Estatísticas
  stats.totalIssues = issues.length;
  stats.protectedIssues = issues.where((i) => i.isProtected).length;
  stats.unprotectedIssues = issues.where((i) => !i.isProtected).length;

  for (var issue in issues) {
    stats.byCategory[issue.category] = (stats.byCategory[issue.category] ?? 0) + 1;
    final riskName = issue.risk.toString().split('.').last;
    stats.byRisk[riskName] = (stats.byRisk[riskName] ?? 0) + 1;
  }

  // Gerar Relatórios
  await generateJsonReport(issues, stats);
  await generateMarkdownReport(issues, stats);

  print('\n✅ Auditoria concluída!');
  print('📊 Taxa de Proteção: ${stats.protectionRate.toStringAsFixed(1)}%');
  print('🔴 Ocorrências vulneráveis: ${stats.unprotectedIssues}');
  print('📄 Relatórios gerados: trycatch_audit_report.json, trycatch_audit_report.md');
  
  if (stats.unprotectedIssues > 0) {
    // exit(1); // Pode descomentar para falhar CI se houver vulnerabilidades
  }
}

List<AuditIssue> analyzeFile(File file) {
  final issues = <AuditIssue>[];
  final lines = file.readAsLinesSync();
  
  // Heurística de escopo simples (contagem de chaves)
  // tryDepth > 0 significa que estamos dentro de um bloco try
  int tryDepth = 0;
  
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trim();
    
    // Ignorar comentários
    if (trimmed.startsWith('//') || trimmed.startsWith('*')) continue;

    // Atualizar profundidade de try/catch
    // Detecção simplificada: "try {" aumenta profundidade
    // "catch" ou "finally" mantém (mas muda contexto), "}" fecha escopo
    // AST seria ideal, mas regex ajuda no nível básico.
    
    if (trimmed.contains(RegExp(r'\btry\s*\{'))) {
      tryDepth++;
    }
    
    // Detectar fechamento de escopo. Isso é frágil com regex linha a linha, 
    // mas assume formatação padrão Dart (indentação ou chaves balanceadas).
    // Para simplificar: apenas assumimos que se detectarmos um padrão de risco,
    // checamos e o tryDepth atual > 0.
    
    // Checagem se fechou bloco (aproximação grosseira para script simples)
    if (trimmed == '}' || (trimmed.startsWith('}') && !trimmed.contains('catch'))) {
       if (tryDepth > 0) {
         // Tentar inferir se esse } fecha um try. Difícil sem parser.
         // Vamos assumir uma abordagem conservadora: O script aponta POTENCIAIS riscos.
         // Se tryDepth estiver alto, consideramos protegido.
         // (Na prática, decrementamos em qualquer fecha chaves para balancear)
         // tryDepth--; // Muito arriscado assumir que qualquer } fecha o try.
       }
    }
    // Melhor abordagem para script linha a linha sem parser:
    // Não confiar cegamente no tryDepth global, mas olhar proximidade visual ou palavras chave na linha.
    // OU: Usar o package 'analyzer' no futuro. Por enquanto, vamos usar:
    // 1. catchError/onError na linha/próxima linha.
    // 2. tryDepth (com decremento em chaves).
    
    // Correção da lógica de chaves:
    // Contar { e } para saber se estamos dentro do try.
    // Precisaríamos rastrear onde o try começou. É complexo.
    // Vamos Simplificar: Apenas checar .catchError / onError E tryDepth simples.
    // Para tryDepth, contaremos apenas chaves simples.
    
    int openBraces = RegExp(r'\{').allMatches(line).length;
    int closeBraces = RegExp(r'\}').allMatches(line).length;
    
    // Se linha tem "try {", ela já conta +1 no openBraces, e logicamente entramos no try.
    // A chave "}" que fecha o try reduzirá o contador.
    // O problema é saber QUAL chave fecha o try.
    
    // -> Vamos usar uma abordagem de "Janela de Proteção".
    // Se 'try' apareceu recentemente e indentação sugere, ok.
    // Como esse é um script de auditoria "chato", melhor FALSO POSITIVO (acusar sem try) do que FALSO NEGATIVO.
    // Assumimos protected = false a menos que prova em contrário na linha (catchError) ou tryDepth > 0.
    
    // Ajuste simples de profundidade:
    if (line.contains('try {')) {
       // tryDepth já incrementado acima? Não, vamos controlar aqui.
    } else {
       // Se fechou chaves, e tryDepth > 0, decrementamos?
       // Como não sabemos se a chave fecha o try ou um if dentro do try...
       // Ignoramos o decremento preciso. O script vai errar para o lado da segurança (acusar falta de try se tiver dúvida).
    }

    // Verificar Regras
    for (final rule in rules) {
      if (rule.pattern.hasMatch(line)) {
        bool isProtected = false;
        String protectionType = 'NONE';

        // 1. Checa proteção inline (.catchError, onError)
        if (line.contains('.catchError') || line.contains('onError:')) {
          isProtected = true;
          protectionType = 'CATCH_ERROR/ON_ERROR';
        }
        
        // 2. Checa se estamos dentro de um try (Heurística: tryDepth > 0)
        // Como o rastreamento de tryDepth é falho aqui, vamos checar se a linha anterior e posteriores sugerem.
        // Melhor: Vamos apenas reportar e deixar o humano verificar se o script marcar como 'NONE'.
        // Mas podemos melhorar: Se a linha começa com muitos espaços e linhas acima tinham 'try {', ok.
        
        if (!isProtected && tryDepth > 0) {
            isProtected = true; 
            protectionType = 'TRY_CATCH (Inferred)';
        }

        issues.add(AuditIssue(
          filePath: file.path,
          lineNumber: i + 1,
          lineContent: line.trim(),
          ruleId: rule.id,
          category: rule.category,
          risk: rule.risk,
          isProtected: isProtected,
          protectionType: protectionType,
        ));
      }
    }
    
    // Pós-processamento de profundidade para próxima linha
    // Tenta manter contagem básica
    if (line.contains(RegExp(r'\btry\s*\{'))) {
      tryDepth++;
    }
    // Se encontrar catch/on/finally, não muda profundidade de BLOCO, mas indica fim do bloco try
    if (line.contains(RegExp(r'\}\s*catch')) || line.contains(RegExp(r'\}\s*on\s')) || line.contains(RegExp(r'\}\s*finally'))) {
       tryDepth--; 
       if (tryDepth < 0) tryDepth = 0;
    }
  }
  return issues;
}

Future<void> generateJsonReport(List<AuditIssue> issues, AuditStats stats) async {
  final jsonContent = JsonEncoder.withIndent('  ').convert({
    'timestamp': DateTime.now().toIso8601String(),
    'stats': {
      'totalFiles': stats.totalFiles,
      'totalIssues': stats.totalIssues,
      'protected': stats.protectedIssues,
      'vulnerable': stats.unprotectedIssues,
      'protectionRate': '${stats.protectionRate.toStringAsFixed(1)}%',
    },
    'issues': issues.map((i) => i.toJson()).toList(),
  });
  
  await File('trycatch_audit_report.json').writeAsString(jsonContent);
}

Future<void> generateMarkdownReport(List<AuditIssue> issues, AuditStats stats) async {
  final buffer = StringBuffer();
  buffer.writeln('# 🛡️ Relatório de Auditoria de Estabilidade (Try/Catch)');
  buffer.writeln('**Data:** ${DateTime.now().toString()}');
  buffer.writeln('');
  
  buffer.writeln('## 📊 Estatísticas Gerais');
  buffer.writeln('- **Arquivos Analisados:** ${stats.totalFiles}');
  buffer.writeln('- **Pontos Críticos Identificados:** ${stats.totalIssues}');
  buffer.writeln('- **Protegidos:** ✅ ${stats.protectedIssues}');
  buffer.writeln('- **Vulneráveis (Risco de Crash):** ❌ ${stats.unprotectedIssues}');
  buffer.writeln('- **Taxa de Proteção:** ${stats.protectionRate.toStringAsFixed(1)}%');
  buffer.writeln('');

  if (stats.unprotectedIssues == 0) {
    buffer.writeln('### 🎉 Parabéns! Nenhum ponto crítico vulnerável detectado (pela análise estática).');
  } else {
    buffer.writeln('## 🚨 Pontos de Atenção (Vulneráveis)');
    buffer.writeln('Abaixo estão listados os trechos de código que parecem **NÃO** estar protegidos por `try-catch` ou `.catchError`.');
    
    // Agrupar por arquivo para facilitar leitura
    final Map<String, List<AuditIssue>> byFile = {};
    for (var issue in issues.where((i) => !i.isProtected)) {
      byFile.putIfAbsent(issue.filePath, () => []).add(issue);
    }

    byFile.forEach((path, fileIssues) {
       buffer.writeln('\n### 📄 `${path}`');
       buffer.writeln('| Linha | Risco | Categoria | Código Detectado |');
       buffer.writeln('|-------|-------|-----------|------------------|');
       for (var issue in fileIssues) {
         final riskIcon = issue.risk == RiskLevel.HIGH ? '🔴' : (issue.risk == RiskLevel.MEDIUM ? '🟠' : '🟡');
         // Escape pipes in content
         final content = issue.lineContent.replaceAll('|', '\\|').substring(0, issue.lineContent.length > 50 ? 50 : issue.lineContent.length) + (issue.lineContent.length > 50 ? '...' : '');
         buffer.writeln('| ${issue.lineNumber} | $riskIcon ${issue.risk.toString().split('.').last} | ${issue.category} | `$content` |');
       }
    });

    buffer.writeln('\n---');
    buffer.writeln('## 🛡️ Pontos Protegidos (Para Referência)');
    buffer.writeln('Quantidade: ${stats.protectedIssues} ocorrências tratadas corretamente.');
  }

  buffer.writeln('\n## ℹ️ Legenda de Riscos');
  buffer.writeln('- 🔴 **HIGH**: Potencial alto de crash (I/O, DB, Permissões).');
  buffer.writeln('- 🟠 **MEDIUM**: Comportamento inesperado ou falha lógica.');
  buffer.writeln('- 🟡 **LOW**: Erro provavelmente controlável ou cosmético.');
  
  await File('trycatch_audit_report.md').writeAsString(buffer.toString());
}
