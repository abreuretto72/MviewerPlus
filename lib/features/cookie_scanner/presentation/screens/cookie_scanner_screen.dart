import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/cookie_scanner_provider.dart';
import 'cookie_scan_results_screen.dart';

/// Tela principal do Cookie Scanner v2.0
class CookieScannerScreen extends StatefulWidget {
  const CookieScannerScreen({super.key});

  @override
  State<CookieScannerScreen> createState() => _CookieScannerScreenState();
}

class _CookieScannerScreenState extends State<CookieScannerScreen> {
  @override
  void initState() {
    super.initState();
    _loadLastScan();
  }

  Future<void> _loadLastScan() async {
    final provider = context.read<CookieScannerProvider>();
    final history = await provider.loadLastScanHistory();
    
    if (history != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Último scan: ${history['files_found']} arquivos encontrados',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔍 Cookie Scanner'),
      ),
      body: Consumer<CookieScannerProvider>(
        builder: (context, provider, child) {
          if (provider.isScanning) {
            return _buildScanningView(provider);
          }

          if (provider.hasResults) {
            return _buildResultsPreview(context, provider);
          }

          return _buildInitialView(context, provider);
        },
      ),
    );
  }

  Widget _buildInitialView(BuildContext context, CookieScannerProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ícone e título
          Icon(
            Icons.cookie,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Cookie Scanner',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Localize e analise arquivos de cookies no seu dispositivo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 32),

          // Aviso de limitações
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    provider.getAccessLimitationsWarning(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Seleção de escopo
          Text(
            'Escopo da Varredura',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          
          _buildScopeOption(
            context,
            provider,
            'default',
            'Diretórios Padrão',
            'Navegadores e locais comuns',
            Icons.folder_special,
          ),
          _buildScopeOption(
            context,
            provider,
            'downloads',
            'Downloads',
            'Pasta de downloads',
            Icons.download,
          ),
          _buildScopeOption(
            context,
            provider,
            'documents',
            'Documentos',
            'Pasta de documentos',
            Icons.description,
          ),
          _buildScopeOption(
            context,
            provider,
            'custom',
            'Selecionar Pasta...',
            provider.customPath ?? 'Nenhuma pasta selecionada',
            Icons.folder_open,
            onTap: () => _selectCustomFolder(provider),
          ),

          const SizedBox(height: 24),

          // Toggle Deep Scan
          Card(
            child: SwitchListTile(
              title: const Text('Leitura Profunda'),
              subtitle: const Text('Mais lenta, mas mais precisa'),
              value: provider.deepScan,
              onChanged: (value) => provider.setDeepScan(value),
              secondary: const Icon(Icons.search),
            ),
          ),

          const SizedBox(height: 32),

          // Botão Iniciar
          ElevatedButton.icon(
            onPressed: () => provider.startScan(),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Iniciar Varredura'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),

          if (provider.error != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                provider.error!,
                style: TextStyle(color: Colors.red.shade900),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScopeOption(
    BuildContext context,
    CookieScannerProvider provider,
    String scope,
    String title,
    String subtitle,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    final isSelected = provider.selectedScope == scope;
    
    return Card(
      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: isSelected ? const Icon(Icons.check_circle) : null,
        onTap: onTap ?? () => provider.setScope(scope),
      ),
    );
  }

  Future<void> _selectCustomFolder(CookieScannerProvider provider) async {
    final result = await FilePicker.platform.getDirectoryPath();
    
    if (result != null) {
      provider.setScope('custom', customPath: result);
    }
  }

  Widget _buildScanningView(CookieScannerProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: provider.progress,
                strokeWidth: 8,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '${(provider.progress * 100).toInt()}%',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              provider.progressStatus,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => provider.cancelScan(),
              icon: const Icon(Icons.stop),
              label: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsPreview(BuildContext context, CookieScannerProvider provider) {
    final stats = provider.getStatistics();
    
    return Column(
      children: [
        // Header com estatísticas
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Column(
            children: [
              Text(
                '${provider.totalFilesFound} arquivos de cookies encontrados',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatChip('Tamanho', stats['total_size']),
                  _buildStatChip('Duração', '${stats['scan_duration']}s'),
                  if (stats['jwt_detections'] > 0)
                    _buildStatChip('JWT', '${stats['jwt_detections']}', Colors.red),
                ],
              ),
            ],
          ),
        ),

        // Ações
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CookieScanResultsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.list),
                label: const Text('Ver Resultados Detalhados'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => provider.startScan(),
                icon: const Icon(Icons.refresh),
                label: const Text('Nova Varredura'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => provider.clearResults(),
                icon: const Icon(Icons.clear),
                label: const Text('Limpar Resultados'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(String label, String value, [Color? color]) {
    return Chip(
      label: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
