# 🧪 Plano de Testes Exaustivo - MviewerPlus (v1.0)
**Data:** 12/12/2025
**Objetivo:** Validar a estabilidade, funcionalidade e usabilidade do MviewerPlus em todos os cenários de uso previstos.

---

## 🛠️ 1. Preparação do Ambiente
*   **Dispositivos Alvo:**
    *   Android (Smartphone e Tablet) - Testar responsividade.
    *   Web (Chrome/Edge) - Testar downloads e layout.
*   **Massa de Dados (Pasta `arq_testes`):**
    *   `pequeno.csv` (10 linhas), `medio.csv` (10k linhas), `grande.csv` (100k+ linhas).
    *   `codigo_complexo.dart` (com 2000 linhas).
    *   `relatorio.xlsx` (Múltiplas abas).
    *   `arquivo_teste.zip` (Estrutura aninhada).
    *   `texto_utf8.txt` e `texto_latin1.txt` (Encoding).
    *   `imagem_grande.png` (Se suportado).

---

## 📋 2. Matriz de Casos de Teste

### 📦 2.1 Módulo: Gestão de Arquivos (Core)
| ID | Caso de Teste | Passos | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| **F01** | Abrir Arquivo Suportado | Clicar "Abrir Arquivo" > Selecionar `.txt` | Arquivo abre imediatamente. Loader exibido se > 1MB. |
| **F02** | Abrir Arquivo Não Suportado | Selecionar arquivo binário desconhecido (`.exe`, `.bin`) | Exibir mensagem de erro amigável ou abrir como texto bruto/hex (se implementado). |
| **F03** | Cancelar Seleção | Clicar "Abrir" > Cancelar no Picker | Retornar à Home sem erro. Overlay de "Carregando" deve sumir. |
| **F04** | Histórico de Arquivos | Abrir arquivo > Fechar > Abrir Histórico | Arquivo deve constar na lista de recentes (se feature ativa). |

### 📊 2.2 Visualizador: Tabelas (CSV/Excel)
| ID | Caso de Teste | Passos | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| **T01** | Detecção de Delimitador | Abrir CSV com `;` e outro com `,` | Ambos devem ser formatados corretamente em colunas. |
| **T02** | Scroll Sincronizado | Abrir CSV largo (50 colunas) > Scroll Horizontal | Cabeçalho e dados devem mover-se juntos perfeitamente. |
| **T03** | Ordenação | Clicar no cabeçalho de uma coluna numérica | Ordenar ascendente/descendente corretamente (1, 2, 10 e não 1, 10, 2). |
| **T04** | Busca em Tabela | Digitar termo existente na barra de busca | Filtrar linhas que contêm o termo. Highlight do termo encontrado. |
| **T05** | Excel Multi-Tabs | Abrir `.xlsx` com 3 abas | Exibir seletor de abas. A troca de aba carrega novos dados. |

### 💻 2.3 Visualizador: Código e Texto
| ID | Caso de Teste | Passos | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| **C01** | Syntax Highlighting | Abrir `.dart`, `.py`, `.sql` | Cores devem corresponder à sintaxe (Keywords, Strings, Comments). |
| **C02** | Line Numbers | Abrir arquivo longo | Números de linha devem aparecer à esquerda e alinhar com o texto. |
| **C03** | Copy Content | Botão "Copiar" | Todo o texto vai para o clipboard. Toast de confirmação. |
| **C04** | Markdown Render | Abrir `.md` | Ver renderização rica (Negrito, Links, Tabelas). Toggle para Raw View funciona. |

### 🗜️ 2.4 Visualizador: Arquivos Compactados (ZIP)
| ID | Caso de Teste | Passos | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| **Z01** | Listar Conteúdo | Abrir `.zip` válido | Lista de arquivos exibida com Ícone, Nome e Tamanho. |
| **Z02** | Arquivo Vazio | Abrir `.zip` vazio ou corrompido | SnackBar "Arquivo ZIP vazio ou inválido". Não travar o app. |
| **Z03** | Busca Bloqueada | Tentar usar a lupa em um ZIP | SnackBar "Busca não disponível para arquivos compactados". |
| **Z04** | Edição Bloqueada | Tentar editar um ZIP | SnackBar "Este formato é apenas para leitura". |

### 📄 2.5 Módulo: Exportação PDF
| ID | Caso de Teste | Passos | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| **P01** | Header Completo | Gerar PDF de qualquer arquivo | Header contém: App Name, Data, Nome Arq., Tamanho e Contagem (Linhas/Reg). |
| **P02** | Paginação | Gerar PDF de arquivo grande (>5 pág) | Footer mostra "Página 1 de 5", "2 de 5"... em todas as páginas. |
| **P03** | Split Table (CSV) | Gerar PDF de CSV com 30 colunas | Tabela deve ser quebrada horizontalmente. Coluna 1 repetida em cada seção. |
| **P04** | Relatório ZIP | Gerar PDF de um `.zip` | Tabela listando o conteúdo do ZIP (Nome, Tipo, Tamanho). Badge "ARCHIVE" no header. |
| **P05** | Internacionalização | Mudar idioma para ES > Gerar PDF | Header/Footer em espanhol ("Página X de Y", "Tamaño", "Filas"). |

### 🤖 2.6 Módulo: Inteligência Artificial (Groq)
| ID | Caso de Teste | Passos | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| **A01** | Sem Chave API | Tentar usar IA sem configurar chave | Exibir alerta/dialog pedindo a chave. |
| **A02** | Configuração de Chave | Inserir chave válida em Settings | Salvar com sucesso. |
| **A03** | Análise de Arquivo | Abrir arquivo > Perguntar "Resuma" | Resposta coerente baseada no conteúdo do arquivo. |
| **A04** | Arquivo Grande | Usar IA em arquivo > 100k chars | Aviso de "Conteúdo truncado" (transparente ou UI). Resposta gerada sobre o início. |
| **A05** | Privacidade | Verificar tráfego (Opcional) | Confirmar que request vai para `api.groq.com` e não Google. |

### 🌍 2.7 Módulo: Localização e Settings
| ID | Caso de Teste | Passos | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| **L01** | Troca de Idioma | Settings > Mudar para PT-BR | Toda a UI muda instantaneamente. |
| **L02** | Persistência | Mudar idioma > Reiniciar App | App inicia no idioma escolhido. |
| **L03** | Formatação Regional | Em PT-BR, ver datas no PDF | Data formato `dd/MM/yyyy` (ou similar local). |
| **L04** | Remoção Premium | Verificar Settings | **NÃO** deve haver botão "Go Premium". |

---

## 🚦 3. Critérios de Aceitação
*   **Críticos (Blockers):** Nenhuma falha (Crash) ao abrir arquivos válidos. PDF deve ser gerado sempre.
*   **Performance:** Abertura de arquivo < 10MB em menos de 3 segundos.
*   **UI:** Sem textos cortados (overflow) em telas pequenas.

## 📝 4. Notas de Execução
Utilize este documento para marcar o status de cada teste na coluna de observações (a adicionar).
Se encontrar bugs, registre no GitHub Issues com a tag `bug-report`.
