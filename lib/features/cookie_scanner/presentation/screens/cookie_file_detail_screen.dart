import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../domain/models/cookie_file_hit.dart';
import '../../domain/models/cookie_risk_result.dart';
import '../providers/cookie_scanner_provider.dart';

class CookieFileDetailScreen extends StatefulWidget {
  final CookieFileHit file;
  final CookieRiskResult? riskResult;

  const CookieFileDetailScreen({
    super.key,
    required this.file,
    this.riskResult,
  });

  @override
  State<CookieFileDetailScreen> createState() => _CookieFileDetailScreenState();
}

class _CookieFileDetailScreenState extends State<CookieFileDetailScreen> {
  bool _contentRevealed = false;
  String? _fullContent;

  @override
  Widget build(BuildContext context) {
    final isHighRisk = widget.riskResult?.isHighRisk ?? false;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file.fileName),
        actions: [
          if (widget.riskResult != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Chip(
                label: Text(
                  widget.riskResult!.riskLevel.name.toUpperCase(),
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                backgroundColor: _getRiskColor(widget.riskResult!.riskLevel),
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner de risco
          if (widget.riskResult != null && isHighRisk)
            _buildRiskBanner(context),
          
          if (widget.riskResult != null && isHighRisk)
            const SizedBox(height: 16),

          // Informações do arquivo
          _buildInfoCard(context),
          
          const SizedBox(height: 16),

          // Análise de risco
          if (widget.riskResult != null)
            _buildRiskCard(context),
          
          if (widget.riskResult != null)
            const SizedBox(height: 16),

          // Preview do conteúdo
          _buildContentCard(context),
        ],
      ),
    );
  }

  Widget _buildRiskBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200, width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.red.shade700, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚠️ ARQUIVO DE ALTO RISCO',
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.riskResult!.riskDescription,
                  style: TextStyle(color: Colors.red.shade800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Informações do Arquivo', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildInfoRow('Nome', widget.file.fileName),
            _buildInfoRow('Caminho', widget.file.path),
            _buildInfoRow('Tamanho', widget.file.formattedSize),
            _buildInfoRow('Tipo', widget.file.type.name),
            _buildInfoRow('Navegador', widget.file.browserName ?? 'Desconhecido'),
            _buildInfoRow('Modificado', _formatDate(widget.file.lastModified)),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Análise de Risco', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            
            // Score e nível
            Row(
              children: [
                Text(
                  widget.riskResult!.riskIcon,
                  style: const TextStyle(fontSize: 48),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.riskResult!.riskDescription,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('Pontuação: ${widget.riskResult!.riskScore}/100'),
                      if (widget.riskResult!.metadata['primary_reason'] != null)
                        Text(
                          widget.riskResult!.metadata['primary_reason'],
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // Sinais detectados
            if (widget.riskResult!.signals.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Sinais Detectados:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.riskResult!.signals.map((signal) {
                  return Chip(
                    label: Text(
                      signal.title,
                      style: const TextStyle(fontSize: 11),
                    ),
                    backgroundColor: _getSignalColor(signal.severity),
                  );
                }).toList(),
              ),
              
              // Detalhes dos sinais críticos
              if (widget.riskResult!.criticalSignals.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Detalhes dos Sinais Críticos:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...widget.riskResult!.criticalSignals.map((signal) {
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.warning, color: Colors.red),
                    title: Text(signal.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(signal.description),
                        if (signal.recommendation != null)
                          Text(
                            '→ ${signal.recommendation}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    final provider = context.read<CookieScannerProvider>();
    final cachedContent = provider.getCachedContent(widget.file);
    final isHighRisk = widget.riskResult?.isHighRisk ?? false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preview do Conteúdo', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            
            if (!_contentRevealed && isHighRisk)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.visibility_off, size: 48),
                    const SizedBox(height: 8),
                    const Text(
                      'Conteúdo mascarado por segurança',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _contentRevealed = true;
                        });
                      },
                      icon: const Icon(Icons.visibility),
                      label: const Text('Revelar Conteúdo'),
                    ),
                  ],
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SelectableText(
                      cachedContent ?? 'Carregando...',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _copyContent(cachedContent),
                        icon: const Icon(Icons.copy),
                        label: const Text('Copiar'),
                      ),
                      const SizedBox(width: 8),
                      if (_fullContent == null)
                        OutlinedButton.icon(
                          onPressed: () => _loadFullContent(provider),
                          icon: const Icon(Icons.download),
                          label: const Text('Carregar Completo'),
                        ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: SelectableText(value)),
        ],
      ),
    );
  }

  Color _getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.none:
        return Colors.green;
      case RiskLevel.low:
        return Colors.yellow.shade700;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return Colors.red;
      case RiskLevel.critical:
        return Colors.red.shade900;
    }
  }

  Color _getSignalColor(int severity) {
    if (severity >= 70) return Colors.red.shade100;
    if (severity >= 40) return Colors.orange.shade100;
    if (severity >= 20) return Colors.yellow.shade100;
    return Colors.green.shade100;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  void _copyContent(String? content) {
    if (content != null) {
      Clipboard.setData(ClipboardData(text: content));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conteúdo copiado para área de transferência')),
      );
    }
  }

  Future<void> _loadFullContent(CookieScannerProvider provider) async {
    final content = await provider.readFullContent(widget.file);
    setState(() {
      _fullContent = content;
    });
  }
}
