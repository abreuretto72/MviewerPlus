import 'package:flutter/material.dart';
import 'package:file_viewer/services/security_service.dart';
import 'package:file_viewer/services/native_security_checker.dart';
import 'package:file_viewer/l10n/app_localizations.dart';

/// Tela de verificação de segurança
class SecurityCheckScreen extends StatefulWidget {
  const SecurityCheckScreen({super.key});

  @override
  State<SecurityCheckScreen> createState() => _SecurityCheckScreenState();
}

class _SecurityCheckScreenState extends State<SecurityCheckScreen> {
  bool _isChecking = false;
  SecurityCheckResult? _result;
  List<SecurityAction>? _actions;

  @override
  void initState() {
    super.initState();
    _performSecurityCheck();
  }

  Future<void> _performSecurityCheck() async {
    setState(() {
      _isChecking = true;
    });

    try {
      final result = await SecurityService.instance.performSecurityCheck(forceRefresh: true);
      // ignore: use_build_context_synchronously
      if (!mounted) return;
      final actions = SecurityService.instance.getRecommendedActions(result, AppLocalizations.of(context)!);

      setState(() {
        _result = result;
        _actions = actions;
        _isChecking = false;
      });
    } catch (e) {
      setState(() {
        _isChecking = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.securityCheck}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t.securityCheck),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isChecking ? null : _performSecurityCheck,
            tooltip: t.refresh,
          ),
        ],
      ),
      body: _isChecking
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    final t = AppLocalizations.of(context)!;
    
    if (_result == null) {
      return Center(child: Text(t.noResultsAvailable));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSecurityLevelCard(),
        const SizedBox(height: 16),
        if (_result!.signatureMismatches.isNotEmpty) ...[
          _buildSignatureMismatchesCard(),
          const SizedBox(height: 16),
        ],
        _buildChecksCard(),
        if (_actions != null && _actions!.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildActionsCard(),
        ],
        const SizedBox(height: 16),
        _buildMonitoredAppsStatus(),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildSecurityLevelCard() {
    final level = _result!.securityLevel;
    final color = _getSecurityLevelColor(level);
    final icon = _getSecurityLevelIcon(level);
    final title = _getSecurityLevelTitle(level);

    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getSecurityLevelDescription(level),
                    style: TextStyle(color: color.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecksCard() {
    final t = AppLocalizations.of(context)!;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.checksPerformed,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildCheckItem(t.checkRootJailbreak, !_result!.isRooted, 'root'),
            _buildCheckItem(t.checkDebugger, !_result!.isDebuggerAttached, 'debugger'),
            _buildCheckItem(t.checkHooking, !_result!.isHookingDetected, 'hooking'),
            _buildCheckItem(t.checkIntegrity, !_result!.isAppTampered, 'integrity'),
            _buildCheckItem(t.checkOSVersion, !_result!.isOSOutdated, 'os_version'),
            _buildCheckItem(t.checkScreenLock, !_result!.isScreenLockDisabled, 'screen_lock'),
            _buildCheckItem(t.checkRealDevice, !_result!.isEmulator, 'emulator'),
            // Novo item para validação de assinaturas
            _buildCheckItem(t.expAppSignaturesTitle, _result!.signatureMismatches.isEmpty, 'app_signatures'),
          ],
        ),
      ),
    );
  }

  Widget _buildMonitoredAppsStatus() {
    if (_result == null) return const SizedBox.shrink();

    final apps = _result!.monitoredAppsStatus;
    
    if (apps.isEmpty) {
       return const Card(
         color: Colors.orangeAccent,
         child: Padding(
           padding: EdgeInsets.all(16.0),
           child: Text('DEBUG: No monitored apps config loaded!\nPossible causes:\n1. Firebase fetch failed\n2. JSON syntax error in Firebase\n3. "trusted_app_hashes" key missing', style: TextStyle(color: Colors.black)),
         ),
       );
    }

    return Card(
      child: ExpansionTile(
        title: Text('Status de Assinaturas (${apps.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
        children: apps.map((status) {
          final isInstalled = status['status'] == 'INSTALLED';
          final isValid = status['isValid'] == true;
          final expected = status['expectedHash'] as String? ?? '';
          final isPlaceholder = expected.startsWith('PLACEHOLDER');
          
          Color statusColor;
          IconData statusIcon;
          String statusLabel;

          if (!isInstalled) {
             statusColor = Colors.grey;
             statusIcon = Icons.radio_button_unchecked;
             statusLabel = 'Não Instalado';
          } else if (isValid) {
             statusColor = Colors.green;
             statusIcon = Icons.check_circle;
             statusLabel = 'Verificado';
          } else if (isPlaceholder) {
             statusColor = Colors.orange;
             statusIcon = Icons.hourglass_empty;
             statusLabel = 'Pendente Configuração';
          } else {
             statusColor = Colors.red;
             statusIcon = Icons.warning;
             statusLabel = 'Assinatura Inválida!';
          }

          return ListTile(
            leading: Icon(statusIcon, color: statusColor),
            title: Text(status['packageName'] ?? 'Desconhecido'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(statusLabel, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
              ],
            ),
            trailing: isInstalled && !isValid && !isPlaceholder 
                ? const Icon(Icons.arrow_forward_ios, size: 14) 
                : null,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSignatureMismatchesCard() {
    return Card(
      color: Colors.red.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Apps Comprometidos Detectados!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Os seguintes aplicativos possuem assinaturas inválidas (possíveis versões falsas ou modificadas):',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const Divider(),
            ..._result!.signatureMismatches.map((mismatch) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.remove_circle_outline, size: 16, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mismatch['packageName'] ?? 'Desconhecido', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('Hash esperado: ${mismatch['expectedHash'].toString().substring(0, 8)}...', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String label, bool passed, String key) {
    final t = AppLocalizations.of(context)!;
    
    return InkWell(
      onTap: () => _showExplanationDialog(key),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              passed ? Icons.check_circle : Icons.cancel,
              color: passed ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label),
            ),
            Text(
              passed ? t.statusOk : t.statusFailed,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: passed ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.info_outline, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showExplanationDialog(String key) {
    final t = AppLocalizations.of(context)!;
    String title = '';
    String content = '';

    switch (key) {
      case 'root':
        title = t.expRootTitle;
        content = t.expRootDesc;
        break;
      case 'debugger':
        title = t.expDebuggerTitle;
        content = t.expDebuggerDesc;
        break;
      case 'hooking':
        title = t.expHookingTitle;
        content = t.expHookingDesc;
        break;
      case 'integrity':
        title = t.expIntegrityTitle;
        content = t.expIntegrityDesc;
        break;
      case 'os_version':
        title = t.expOSTitle;
        content = t.expOSDesc;
        break;
      case 'screen_lock':
        title = t.expLockTitle;
        content = t.expLockDesc;
        break;
      case 'emulator':
        title = t.expEmulatorTitle;
        content = t.expEmulatorDesc;
        break;
      case 'app_signatures':
        title = t.expAppSignaturesTitle;
        content = t.expAppSignaturesDesc;
        break;
      default:
        return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.help_outline, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(child: Text(title)),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            content,
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.understood),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
    final t = AppLocalizations.of(context)!;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.recommendedActions,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ..._actions!.map((action) => _buildActionItem(action)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(SecurityAction action) {
    final isCritical = action.type == SecurityActionType.critical;
    final color = isCritical ? Colors.red : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCritical ? Icons.error : Icons.warning,
                color: color,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  action.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(action.description),
          const SizedBox(height: 8),
          Text(
            '💡 ${action.recommendation}',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Color _getSecurityLevelColor(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.safe:
        return Colors.green;
      case SecurityLevel.warning:
        return Colors.orange;
      case SecurityLevel.critical:
        return Colors.red;
    }
  }

  IconData _getSecurityLevelIcon(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.safe:
        return Icons.verified_user;
      case SecurityLevel.warning:
        return Icons.warning;
      case SecurityLevel.critical:
        return Icons.error;
    }
  }

  String _getSecurityLevelTitle(SecurityLevel level) {
    final t = AppLocalizations.of(context)!;
    switch (level) {
      case SecurityLevel.safe:
        return t.securityLevelSafe;
      case SecurityLevel.warning:
        return t.securityLevelWarning;
      case SecurityLevel.critical:
        return t.securityLevelCritical;
    }
  }

  String _getSecurityLevelDescription(SecurityLevel level) {
    final t = AppLocalizations.of(context)!;
    switch (level) {
      case SecurityLevel.safe:
        return t.securityDescSafe;
      case SecurityLevel.warning:
        return t.securityDescWarning;
      case SecurityLevel.critical:
        return t.securityDescCritical;
    }
  }
}
