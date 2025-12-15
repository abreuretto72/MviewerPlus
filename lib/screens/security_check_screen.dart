import 'package:flutter/material.dart';
import 'package:file_viewer/services/security_service.dart';
import 'package:file_viewer/services/native_security_checker.dart';

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
      final actions = SecurityService.instance.getRecommendedActions(result);

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
          SnackBar(content: Text('Erro ao verificar segurança: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificação de Segurança'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isChecking ? null : _performSecurityCheck,
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: _isChecking
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_result == null) {
      return const Center(child: Text('Nenhum resultado disponível'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSecurityLevelCard(),
        const SizedBox(height: 16),
        _buildChecksCard(),
        if (_actions != null && _actions!.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildActionsCard(),
        ],
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verificações Realizadas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildCheckItem('Root/Jailbreak', !_result!.isRooted),
            _buildCheckItem('Debugger', !_result!.isDebugging),
            _buildCheckItem('Hooking', !_result!.isHooked),
            _buildCheckItem('Integridade do App', _result!.hasValidIntegrity),
            _buildCheckItem('Sistema Atualizado', _result!.hasUpdatedOS),
            _buildCheckItem('Bloqueio de Tela', _result!.hasScreenLock),
            _buildCheckItem('Dispositivo Real', !_result!.isEmulator),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String label, bool passed) {
    return Padding(
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
            passed ? 'OK' : 'FALHOU',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: passed ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ações Recomendadas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    switch (level) {
      case SecurityLevel.safe:
        return 'Seguro';
      case SecurityLevel.warning:
        return 'Avisos Detectados';
      case SecurityLevel.critical:
        return 'AMEAÇAS CRÍTICAS';
    }
  }

  String _getSecurityLevelDescription(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.safe:
        return 'Todas as verificações de segurança passaram';
      case SecurityLevel.warning:
        return 'Algumas configurações podem ser melhoradas';
      case SecurityLevel.critical:
        return 'Ameaças críticas detectadas - Ação necessária';
    }
  }
}
