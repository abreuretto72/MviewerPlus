import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/cookie_inspector_provider.dart';
import '../../domain/models/cookie_entry.dart';
import '../../domain/security/cookie_security_guard.dart';

/// Tela principal do Cookie Inspector
class CookieInspectorScreen extends StatefulWidget {
  const CookieInspectorScreen({super.key});

  @override
  State<CookieInspectorScreen> createState() => _CookieInspectorScreenState();
}

class _CookieInspectorScreenState extends State<CookieInspectorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _urlController = TextEditingController();
  String _selectedTab = 'http'; // 'http', 'webview', 'security'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            _selectedTab = 'http';
            break;
          case 1:
            _selectedTab = 'webview';
            break;
          case 2:
            _selectedTab = 'security';
            break;
        }
      });
    });

    // Inicializa o provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CookieInspectorProvider>().initialize();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍪 Cookie Inspector'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.http), text: 'HTTP Cookies'),
            Tab(icon: Icon(Icons.web), text: 'WebView Cookies'),
            Tab(icon: Icon(Icons.security), text: 'Security & Logs'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner de privacidade
          _buildPrivacyBanner(),

          // Campo de URL/Domínio
          if (_selectedTab != 'security') _buildUrlInput(),

          // Conteúdo das abas
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHttpCookiesTab(),
                _buildWebViewCookiesTab(),
                _buildSecurityTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Banner de aviso de privacidade
  Widget _buildPrivacyBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.orange.shade100,
      child: Row(
        children: [
          Icon(Icons.warning_amber, color: Colors.orange.shade900),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Cookies podem conter tokens de sessão e login. Use com cuidado.',
              style: TextStyle(
                color: Colors.orange.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Campo de entrada de URL/Domínio
  Widget _buildUrlInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: _selectedTab == 'http' ? 'URL ou Domínio' : 'URL',
                hintText: 'https://example.com',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.link),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: _loadCookies,
            icon: const Icon(Icons.refresh),
            label: const Text('Listar'),
          ),
        ],
      ),
    );
  }

  /// Aba de cookies HTTP
  Widget _buildHttpCookiesTab() {
    return Consumer<CookieInspectorProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
                const SizedBox(height: 16),
                Text(
                  provider.error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.clearError(),
                  child: const Text('Limpar Erro'),
                ),
              ],
            ),
          );
        }

        if (provider.httpCookies.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cookie_outlined, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                const Text(
                  'Nenhum cookie HTTP encontrado',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Digite uma URL e clique em "Listar"',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Botões de ação
            _buildActionButtons(provider.httpCookies, CookieSource.http),

            // Lista de cookies
            Expanded(
              child: ListView.builder(
                itemCount: provider.httpCookies.length,
                itemBuilder: (context, index) {
                  final cookie = provider.httpCookies[index];
                  return _buildCookieCard(cookie, CookieSource.http);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// Aba de cookies WebView
  Widget _buildWebViewCookiesTab() {
    return Consumer<CookieInspectorProvider>(
      builder: (context, provider, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.web, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              const Text(
                'WebView Cookies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  provider.getWebViewLimitationsWarning(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Esta funcionalidade requer uma WebView ativa.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Aba de segurança e logs
  Widget _buildSecurityTab() {
    return Consumer<CookieInspectorProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Estatísticas
              _buildStatisticsCard(provider),

              const SizedBox(height: 16),

              // Relatório de segurança
              _buildSecurityReportCard(provider),

              const SizedBox(height: 16),

              // Configurações de autenticação
              _buildAuthSettingsCard(provider),
            ],
          ),
        );
      },
    );
  }

  /// Card de estatísticas
  Widget _buildStatisticsCard(CookieInspectorProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 Estatísticas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
              future: provider.getHttpStatistics(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final stats = snapshot.data!;
                return Column(
                  children: [
                    _buildStatRow('Total de Cookies', '${stats['total_cookies']}'),
                    _buildStatRow('Total de Domínios', '${stats['total_domains']}'),
                    _buildStatRow('Cookies Secure', '${stats['secure_cookies']}'),
                    _buildStatRow('Cookies HttpOnly', '${stats['http_only_cookies']}'),
                    _buildStatRow('Cookies Expirados', '${stats['expired_cookies']}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// Card de relatório de segurança
  Widget _buildSecurityReportCard(CookieInspectorProvider provider) {
    final allCookies = [...provider.httpCookies, ...provider.webViewCookies];

    if (allCookies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '🔐 Relatório de Segurança',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () => _showSecurityReport(provider, allCookies),
                  icon: const Icon(Icons.visibility),
                  label: const Text('Ver Detalhes'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              provider.generateSecurityReport(allCookies),
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  /// Card de configurações de autenticação
  Widget _buildAuthSettingsCard(CookieInspectorProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔒 Configurações de Segurança',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.fingerprint),
              title: const Text('Autenticação Biométrica'),
              subtitle: const Text('Proteger ações sensíveis'),
              trailing: FutureBuilder<bool>(
                future: provider.canUseBiometrics(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox.shrink();
                  return Switch(
                    value: snapshot.data!,
                    onChanged: null, // TODO: Implementar toggle
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.pin),
              title: const Text('Configurar PIN'),
              subtitle: const Text('PIN de segurança alternativo'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showPinSetup(provider),
            ),
          ],
        ),
      ),
    );
  }


  /// Botões de ação (Exportar, Excluir Todos)
  Widget _buildActionButtons(List<CookieEntry> cookies, CookieSource source) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ElevatedButton.icon(
            onPressed: () => _exportCookies(cookies, source),
            icon: const Icon(Icons.download),
            label: const Text('Exportar'),
          ),
          ElevatedButton.icon(
            onPressed: () => _deleteAllCookies(source),
            icon: const Icon(Icons.delete_sweep),
            label: const Text('Excluir Todos'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Card individual de cookie
  Widget _buildCookieCard(CookieEntry cookie, CookieSource source) {
    final provider = context.read<CookieInspectorProvider>();
    final analysis = provider.getSecurityAnalysis(cookie);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: analysis.isSensitive ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: analysis.isSensitive
            ? BorderSide(
                color: Color(int.parse(
                    '0xFF${CookieSecurityGuard.getRiskColor(analysis.riskLevel).substring(1)}')),
                width: 2,
              )
            : BorderSide.none,
      ),
      child: ExpansionTile(
        leading: Text(
          CookieSecurityGuard.getRiskIcon(analysis.riskLevel),
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(
          cookie.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Domain: ${cookie.domain}'),
            if (analysis.isSensitive)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber, size: 14, color: Colors.orange.shade900),
                    const SizedBox(width: 4),
                    Text(
                      'Cookie sensível (${analysis.riskLevel.name})',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCookieDetail('Valor', cookie.maskedValue, canReveal: true, cookie: cookie),
                _buildCookieDetail('Domínio', cookie.domain),
                _buildCookieDetail('Path', cookie.path),
                _buildCookieDetail(
                  'Expira',
                  cookie.expires?.toString() ?? 'Sessão',
                ),
                _buildCookieDetail('Secure', cookie.secure ? 'Sim' : 'Não'),
                _buildCookieDetail('HttpOnly', cookie.httpOnly ? 'Sim' : 'Não'),
                _buildCookieDetail('SameSite', cookie.sameSite ?? 'None'),
                
                if (analysis.signals.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Sinais de Segurança:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...analysis.signals.map((signal) => Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Text('• $signal', style: const TextStyle(fontSize: 12)),
                      )),
                ],

                const SizedBox(height: 16),

                // Botões de ação
                Wrap(
                  spacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _copyCookieValue(cookie, analysis.isSensitive),
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('Copiar Valor'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _editCookie(cookie, source, analysis.isSensitive),
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Editar'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _deleteCookie(cookie, source, analysis.isSensitive),
                      icon: const Icon(Icons.delete, size: 16),
                      label: const Text('Excluir'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Detalhe do cookie
  Widget _buildCookieDetail(
    String label,
    String value, {
    bool canReveal = false,
    CookieEntry? cookie,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(value),
                ),
                if (canReveal && cookie != null)
                  IconButton(
                    icon: const Icon(Icons.visibility, size: 16),
                    tooltip: 'Revelar valor completo',
                    onPressed: () => _revealCookieValue(cookie),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Carrega cookies baseado na aba selecionada
  Future<void> _loadCookies() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite uma URL válida')),
      );
      return;
    }

    final provider = context.read<CookieInspectorProvider>();

    if (_selectedTab == 'http') {
      await provider.loadHttpCookies(url);
    }
    // WebView requer controller ativo, não implementado aqui
  }

  /// Copia o valor do cookie
  Future<void> _copyCookieValue(CookieEntry cookie, bool isSensitive) async {
    if (isSensitive) {
      final authenticated = await _authenticateAction('Copiar valor do cookie');
      if (!authenticated) return;
    }

    await Clipboard.setData(ClipboardData(text: cookie.value));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Valor copiado para a área de transferência')),
      );
    }
  }

  /// Revela o valor completo do cookie
  Future<void> _revealCookieValue(CookieEntry cookie) async {
    final provider = context.read<CookieInspectorProvider>();
    final analysis = provider.getSecurityAnalysis(cookie);

    if (analysis.isSensitive) {
      final authenticated = await _authenticateAction('Revelar valor do cookie');
      if (!authenticated) return;
    }

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Valor de ${cookie.name}'),
          content: SelectableText(cookie.value),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: cookie.value));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Valor copiado')),
                );
              },
              child: const Text('Copiar'),
            ),
          ],
        ),
      );
    }
  }

  /// Edita um cookie
  Future<void> _editCookie(
    CookieEntry cookie,
    CookieSource source,
    bool isSensitive,
  ) async {
    if (isSensitive) {
      final authenticated = await _authenticateAction('Editar cookie');
      if (!authenticated) return;
    }

    if (!mounted) return;

    final result = await showDialog<CookieEntry>(
      context: context,
      builder: (context) => _CookieEditDialog(cookie: cookie),
    );

    if (result != null && mounted) {
      final provider = context.read<CookieInspectorProvider>();
      final url = _urlController.text.trim();

      bool success;
      if (source == CookieSource.http) {
        success = await provider.setHttpCookie(url: url, cookie: result);
      } else {
        success = await provider.setWebViewCookie(url: url, cookie: result);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Cookie atualizado' : 'Erro ao atualizar cookie'),
          ),
        );

        if (success) {
          _loadCookies();
        }
      }
    }
  }

  /// Exclui um cookie
  Future<void> _deleteCookie(
    CookieEntry cookie,
    CookieSource source,
    bool isSensitive,
  ) async {
    if (isSensitive) {
      final authenticated = await _authenticateAction('Excluir cookie');
      if (!authenticated) return;
    }

    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deseja excluir o cookie "${cookie.name}"?'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.orange.shade700),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Esta ação pode encerrar sessões ativas.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final provider = context.read<CookieInspectorProvider>();
      final url = _urlController.text.trim();

      bool success;
      if (source == CookieSource.http) {
        success = await provider.deleteHttpCookie(
          url: url,
          name: cookie.name,
          domain: cookie.domain,
        );
      } else {
        success = await provider.deleteWebViewCookie(
          url: url,
          name: cookie.name,
          domain: cookie.domain,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Cookie excluído' : 'Erro ao excluir cookie'),
          ),
        );

        if (success) {
          _loadCookies();
        }
      }
    }
  }

  /// Exclui todos os cookies
  Future<void> _deleteAllCookies(CookieSource source) async {
    final authenticated = await _authenticateAction('Excluir todos os cookies');
    if (!authenticated) return;

    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Confirmar Exclusão em Massa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deseja excluir TODOS os cookies?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'ATENÇÃO: Esta ação é irreversível!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Todas as sessões serão encerradas\n'
                    '• Você será desconectado de sites\n'
                    '• Configurações salvas serão perdidas',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                const Expanded(
                  child: Text(
                    'Entendo que isso pode encerrar sessões',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir Todos'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final provider = context.read<CookieInspectorProvider>();

      bool success;
      if (source == CookieSource.http) {
        success = await provider.clearAllHttpCookies();
      } else {
        success = await provider.clearAllWebViewCookies();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Todos os cookies foram excluídos' : 'Erro ao excluir cookies',
            ),
          ),
        );
      }
    }
  }

  /// Exporta cookies
  Future<void> _exportCookies(List<CookieEntry> cookies, CookieSource source) async {
    if (cookies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum cookie para exportar')),
      );
      return;
    }

    // Verifica se há cookies sensíveis
    final provider = context.read<CookieInspectorProvider>();
    final hasSensitive = cookies.any((c) => provider.getSecurityAnalysis(c).isSensitive);

    if (!mounted) return;

    final format = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exportar Cookies'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasSensitive)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Este relatório contém cookies de autenticação.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('JSON'),
              onTap: () => Navigator.pop(context, 'json'),
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('CSV'),
              onTap: () => Navigator.pop(context, 'csv'),
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF'),
              onTap: () => Navigator.pop(context, 'pdf'),
            ),
          ],
        ),
      ),
    );

    if (format != null && mounted) {
      // Pergunta sobre mascaramento
      final maskValues = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Opções de Exportação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<bool>(
                title: const Text('Valores mascarados (recomendado)'),
                subtitle: const Text('Cookies sensíveis serão protegidos'),
                value: true,
                groupValue: true,
                onChanged: (value) => Navigator.pop(context, value),
              ),
              RadioListTile<bool>(
                title: const Text('Valores reais'),
                subtitle: const Text('Requer autenticação adicional'),
                value: false,
                groupValue: true,
                onChanged: (value) => Navigator.pop(context, value),
              ),
            ],
          ),
        ),
      );

      if (maskValues != null) {
        // Se escolheu valores reais, requer autenticação
        if (!maskValues) {
          final authenticated = await _authenticateAction(
            'Exportar cookies com valores reais',
          );
          if (!authenticated) return;
        }

        // Exporta
        try {
          switch (format) {
            case 'json':
              final json = provider.exportToJson(
                cookies: cookies,
                source: source.name,
                maskSensitiveValues: maskValues,
              );
              await Clipboard.setData(ClipboardData(text: json));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('JSON copiado para área de transferência')),
                );
              }
              break;

            case 'csv':
              final csv = provider.exportToCsv(
                cookies: cookies,
                maskSensitiveValues: maskValues,
              );
              await Clipboard.setData(ClipboardData(text: csv));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('CSV copiado para área de transferência')),
                );
              }
              break;

            case 'pdf':
              await provider.exportToPdf(
                cookies: cookies,
                source: source.name,
                maskSensitiveValues: maskValues,
              );
              break;
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao exportar: $e')),
            );
          }
        }
      }
    }
  }

  /// Mostra relatório de segurança detalhado
  void _showSecurityReport(CookieInspectorProvider provider, List<CookieEntry> cookies) {
    final report = provider.generateSecurityReport(cookies);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Relatório de Segurança Completo'),
        content: SingleChildScrollView(
          child: SelectableText(
            report,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: report));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Relatório copiado')),
              );
            },
            child: const Text('Copiar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  /// Mostra diálogo de configuração de PIN
  void _showPinSetup(CookieInspectorProvider provider) {
    showDialog(
      context: context,
      builder: (context) => _PinSetupDialog(provider: provider),
    );
  }

  /// Autentica uma ação sensível
  Future<bool> _authenticateAction(String reason) async {
    final provider = context.read<CookieInspectorProvider>();

    // Tenta autenticação biométrica/PIN
    final authenticated = await provider.authenticate(reason);
    
    if (authenticated) {
      return true;
    }

    // Se falhou, verifica se tem PIN configurado
    final hasPin = await provider.hasPin();
    if (!hasPin) {
      // Sem PIN configurado, pede para configurar
      if (mounted) {
        final shouldSetup = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Autenticação Necessária'),
            content: const Text(
              'Configure um PIN de segurança para proteger ações sensíveis.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Configurar PIN'),
              ),
            ],
          ),
        );

        if (shouldSetup == true) {
          _showPinSetup(provider);
        }
      }
      return false;
    }

    // Solicita PIN
    if (mounted) {
      final pin = await showDialog<String>(
        context: context,
        builder: (context) => _PinInputDialog(reason: reason),
      );

      if (pin != null) {
        return await provider.validatePin(pin);
      }
    }

    return false;
  }
}

/// Diálogo para editar cookie
class _CookieEditDialog extends StatefulWidget {
  final CookieEntry cookie;

  const _CookieEditDialog({required this.cookie});

  @override
  State<_CookieEditDialog> createState() => _CookieEditDialogState();
}

class _CookieEditDialogState extends State<_CookieEditDialog> {
  late TextEditingController _valueController;
  late TextEditingController _pathController;
  late bool _secure;
  late String _sameSite;

  @override
  void initState() {
    super.initState();
    _valueController = TextEditingController(text: widget.cookie.value);
    _pathController = TextEditingController(text: widget.cookie.path);
    _secure = widget.cookie.secure;
    _sameSite = widget.cookie.sameSite ?? 'None';
  }

  @override
  void dispose() {
    _valueController.dispose();
    _pathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar ${widget.cookie.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pathController,
              decoration: const InputDecoration(
                labelText: 'Path',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Secure'),
              value: _secure,
              onChanged: (value) => setState(() => _secure = value),
            ),
            DropdownButtonFormField<String>(
              value: _sameSite,
              decoration: const InputDecoration(
                labelText: 'SameSite',
                border: OutlineInputBorder(),
              ),
              items: ['None', 'Lax', 'Strict']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (value) => setState(() => _sameSite = value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final updated = widget.cookie.copyWith(
              value: _valueController.text,
              path: _pathController.text,
              secure: _secure,
              sameSite: _sameSite,
            );
            Navigator.pop(context, updated);
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

/// Diálogo para configurar PIN
class _PinSetupDialog extends StatefulWidget {
  final CookieInspectorProvider provider;

  const _PinSetupDialog({required this.provider});

  @override
  State<_PinSetupDialog> createState() => _PinSetupDialogState();
}

class _PinSetupDialogState extends State<_PinSetupDialog> {
  final _pinController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Configurar PIN'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _pinController,
            decoration: const InputDecoration(
              labelText: 'PIN (mínimo 4 dígitos)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 6,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _confirmController,
            decoration: const InputDecoration(
              labelText: 'Confirmar PIN',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 6,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_pinController.text != _confirmController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PINs não coincidem')),
              );
              return;
            }

            if (_pinController.text.length < 4) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PIN deve ter no mínimo 4 dígitos')),
              );
              return;
            }

            final success = await widget.provider.setPin(_pinController.text);
            if (mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success ? 'PIN configurado' : 'Erro ao configurar PIN'),
                ),
              );
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

/// Diálogo para entrada de PIN
class _PinInputDialog extends StatefulWidget {
  final String reason;

  const _PinInputDialog({required this.reason});

  @override
  State<_PinInputDialog> createState() => _PinInputDialogState();
}

class _PinInputDialogState extends State<_PinInputDialog> {
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Digite seu PIN'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.reason),
          const SizedBox(height: 16),
          TextField(
            controller: _pinController,
            decoration: const InputDecoration(
              labelText: 'PIN',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 6,
            autofocus: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _pinController.text),
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}

