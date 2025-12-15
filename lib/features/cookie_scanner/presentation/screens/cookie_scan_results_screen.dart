import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cookie_scanner_provider.dart';
import '../widgets/cookie_hit_tile.dart';
import '../../domain/models/cookie_risk_result.dart';

class CookieScanResultsScreen extends StatefulWidget {
  const CookieScanResultsScreen({super.key});

  @override
  State<CookieScanResultsScreen> createState() => _CookieScanResultsScreenState();
}

class _CookieScanResultsScreenState extends State<CookieScanResultsScreen> {
  RiskLevel? _filterRiskLevel;
  String _searchKeyword = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados da Varredura'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assessment),
            onPressed: () => _showRiskReport(context),
            tooltip: 'Relatório de Segurança',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filtrar',
          ),
        ],
      ),
      body: Consumer<CookieScannerProvider>(
        builder: (context, provider, child) {
          var files = provider.foundFiles;

          // Aplicar filtro de risco
          if (_filterRiskLevel != null) {
            files = provider.filterByRiskLevel(_filterRiskLevel!);
          }

          // Aplicar filtro de palavra-chave
          if (_searchKeyword.isNotEmpty) {
            files = provider.filterByKeyword(_searchKeyword);
          }

          if (files.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    _filterRiskLevel != null || _searchKeyword.isNotEmpty
                        ? 'Nenhum arquivo encontrado com os filtros aplicados'
                        : 'Nenhum arquivo encontrado',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  if (_filterRiskLevel != null || _searchKeyword.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _filterRiskLevel = null;
                          _searchKeyword = '';
                          _searchController.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text('Limpar Filtros'),
                    ),
                  ],
                ],
              ),
            );
          }

          return Column(
            children: [
              // Barra de busca
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar por nome ou caminho...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchKeyword.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchKeyword = '';
                                _searchController.clear();
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchKeyword = value;
                    });
                  },
                ),
              ),

              // Chips de filtro ativo
              if (_filterRiskLevel != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: Text('Risco: ${_filterRiskLevel!.name}'),
                        onDeleted: () {
                          setState(() {
                            _filterRiskLevel = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),

              // Lista de resultados
              Expanded(
                child: ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    final risk = provider.getRiskResult(file);
                    
                    return CookieHitTile(
                      file: file,
                      riskResult: risk,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar por Risco'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRiskFilterOption(null, 'Todos'),
            _buildRiskFilterOption(RiskLevel.critical, 'Crítico'),
            _buildRiskFilterOption(RiskLevel.high, 'Alto'),
            _buildRiskFilterOption(RiskLevel.medium, 'Médio'),
            _buildRiskFilterOption(RiskLevel.low, 'Baixo'),
            _buildRiskFilterOption(RiskLevel.none, 'Sem Risco'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskFilterOption(RiskLevel? level, String label) {
    return RadioListTile<RiskLevel?>(
      title: Text(label),
      value: level,
      groupValue: _filterRiskLevel,
      onChanged: (value) {
        setState(() {
          _filterRiskLevel = value;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showRiskReport(BuildContext context) {
    final provider = context.read<CookieScannerProvider>();
    final report = provider.generateRiskReport();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Relatório de Segurança'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SelectableText(
              report,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
