# MviewerPlus 📱

> **Advanced File Viewer with AI-Powered Analysis**

A powerful, **completely free and open-source** Flutter application for viewing, analyzing, and exporting various file formats with intelligent CSV optimization and AI assistance.

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-blue.svg)](https://flutter.dev/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey.svg)](https://github.com/abreuretto72/MviewerPlus)
[![Free](https://img.shields.io/badge/price-FREE-success.svg)](https://github.com/abreuretto72/MviewerPlus)

## 💚 Free & Open Source

**MviewerPlus is 100% free with no ads, no subscriptions, and no hidden costs.**

- ✅ All features available to everyone
- ✅ No advertisements
- ✅ No premium tiers or paywalls
- ✅ Open-source and community-driven
- ✅ Privacy-focused - your data stays on your device

## ✨ Features

### 📄 File Viewing & Format Support

**MviewerPlus supports 60+ file formats across multiple categories:**

#### 📊 Data & Tables
- **CSV** - Advanced table view with sorting, filtering, and smart data cleaning
  - Automatic delimiter detection (comma, semicolon)
  - Handles 250+ columns and thousands of rows
  - Export to PDF with automatic table splitting
- **Excel** (.xlsx, .xls) - Multi-sheet support
  - View data in tabular format
  - Toggle between sheets
  - Background processing for large files
- **Archives** (.zip, .apk, .jar) - Archive explorer
  - View contents (files/folders)
  - Inspect file types and sizes
  - Restricted search/edit for data integrity
  - Clean PDF reports of archive contents

#### 📝 Markup & Documentation
- **Markdown** (.md, .markdown) - Beautiful rendered view with:
  - Formatted headings, lists, and links
  - Code blocks with syntax highlighting
  - Tables, blockquotes, and horizontal rules
  - Toggle between rendered and raw view
- **JSON** - Syntax highlighted with proper formatting
- **XML** - Structured view with color coding
- **YAML** (.yaml, .yml) - Configuration file support
- **HTML/HTM** - Web markup with syntax highlighting

#### 💻 Programming Languages (Syntax Highlighting)
**Web Development:**
- JavaScript (.js, .jsx)
- TypeScript (.ts, .tsx)
- CSS (.css, .scss, .sass, .less)

**Mobile & App Development:**
- Dart (.dart)
- Java (.java)
- Kotlin (.kt, .kts)
- Swift (.swift)

**Systems Programming:**
- C (.c)
- C++ (.cpp, .cc, .cxx, .h, .hpp)
- C# (.cs)
- Go (.go)
- Rust (.rs)

**Scripting Languages:**
- Python (.py)
- Ruby (.rb)
- PHP (.php)
- Perl (.pl)
- Bash (.sh, .bash)
- PowerShell (.ps1)

**Database:**
- SQL (.sql) - Custom Dracula theme with:
  - Pink keywords (SELECT, FROM, WHERE)
  - Cyan functions (COUNT, SUM, AVG)
  - Yellow strings
  - Purple numbers
  - Italic comments

**Other Languages:**
- R (.r)
- Scala (.scala)
- Lua (.lua)
- Vim Script (.vim)
- Elisp (.el)
- Clojure (.clj)
- Elixir (.ex, .exs)

**Configuration Files:**
- INI (.ini, .cfg) - Custom syntax highlighting
- TOML (.toml) - Custom syntax highlighting
- Properties (.properties) - Custom syntax highlighting
- Environment (.env) - Bash-style highlighting
- Config (.conf) - Nginx-style highlighting
- XML Config (.config) - XML highlighting

#### 📄 Plain Text Files
- TXT
- ASC (ASCII)

#### 🎬 Multimedia & Documents
- **Video Player** - Native playback (MP4, MKV, AVI, etc.)
- **Audio Player** - Native playback (MP3, WAV, OGG, etc.)
- **PDF Viewer** - Native rendering with page navigation
- **Word Documents** (.docx, .doc) - content reading

#### 📋 Log Files
- LOG - Custom syntax highlighting with:
  - ERROR/FATAL → Red (bold)
  - WARN/WARNING → Orange (semi-bold)
  - INFO → Cyan
  - DEBUG/TRACE → Gray
  - SUCCESS/OK → Green (semi-bold)
  - Timestamps → Purple

### 🎨 Viewing Features

#### Syntax Highlighting
- **40+ Programming Languages** with Dracula theme
- **Custom SQL Highlighter** with:
  - Pink keywords (SELECT, FROM, WHERE)
  - Cyan functions (COUNT, SUM, AVG)
  - Yellow strings
  - Purple numbers
  - Italic blue-gray comments
- **Custom Config File Highlighter** with:
  - Pink sections ([section])
  - Cyan keys
  - Purple separators (= or :)
  - Yellow values
  - Italic blue-gray comments
- **Custom Log File Highlighter** with severity-based colors

#### Markdown Rendering
- **Rich Text Formatting** with toggle Raw ↔ Rendered
- Formatted headings with theme colors
- Code blocks with syntax highlighting
- Tables, blockquotes, and horizontal rules
- Links and images support

#### CSV Tables
- **Smart Data Cleaning**: Automatic removal of empty columns/rows
- **Sortable Columns**: Click headers to sort
- **Search & Filter**: Find data across all cells
- **Dynamic Column Widths**: Auto-sized based on content
- **Alternating Row Colors**: Better readability
- **Info Display**: Shows rows × columns count

#### PDF Export
- **Automatic Pagination**: Handles files of any size
- **CSV Table Splitting**: 
  - Horizontal: 15 columns per section
  - Vertical: 10 rows per section (with indicators)
  - First column repeated for context
- **Professional Formatting**:
  - Landscape mode for wide tables
  - Clean headers and borders
  - Alternating row colors
- **No Size Limits**: Supports thousands of lines

### 🚀 Performance Optimizations
- **Background Processing**: CSV parsing in separate isolates for smooth UI
- **Virtualized Rendering**: Efficient display of large datasets
- **Synchronized Scrolling**: Perfect horizontal scroll sync in CSV tables
- **Smart Delimiter Detection**: Fast and accurate CSV delimiter identification

### 🤖 AI Integration
- **Groq Power ⚡**: Uses Llama 3 70b via Groq for high-speed analysis.
- **Context-Aware**: Understands file structure (CSV stats, Code logic, Logs patterns).
- **Zero Cost**: Built for free tier API usage (easy setup guide included).
- **Export Conversations**: Save AI chat sessions as PDF.

### 📊 Export & Sharing
- **PDF Export**: Convert files and AI chats to formatted PDFs
  - **Comprehensive Reports**: Headers with file name, type, size, and row/file count.
  - **Automatic Pagination**: "Page X of Y" footer on every page.
  - **Smart Table Splitting**: Wide CSV tables divided into readable sections.
  - **Archive Reports**: Generates detailed content lists for ZIP files.
  - **Professional Layout**: Clean formatting with headers and borders.
- **Table Formatting**: CSV files exported as professional tables
- **Print & Share**: Easy sharing with customizable options

### 🔍 Advanced Tools
- **Find & Replace**: Search and replace text across files
- **File Editing**: Edit and save modified files
- **Multiple Views**: Toggle between raw and formatted views
- **CSV Sorting**: Sort table columns with visual indicators

### 🌍 Localization
- English (EN)
- Portuguese Brazil (PT-BR)
- Portuguese Portugal (PT-PT)
- Spanish (ES)

## 🛠️ Technical Highlights

### Architecture
- **Clean Architecture**: Separation of concerns with providers and services
- **State Management**: Efficient state handling with Provider
- **Async Processing**: Compute isolates for CPU-intensive tasks

### Key Technologies
- **Flutter**: Cross-platform UI framework
- **Groq API**: High-performance AI analysis (Llama 3)
- **PDF Generation**: `pdf` and `printing` packages
- **File Parsing**: `csv`, `spreadsheet_decoder` (Excel), `archive` (ZIP)
- **Syntax Highlighting**: `flutter_highlight`

### Performance Features
- Background CSV parsing with `compute()`
- Virtualized list rendering for large datasets
- Lazy loading for optimal memory usage
- Smart data cleaning algorithms

## 📱 Screenshots

*Coming soon...*

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.10 or higher
- Dart 3.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/abreuretto72/MviewerPlus.git
cd MviewerPlus
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure AI (Optional)**
No environment variables required. Get a free Groq API Key at [console.groq.com](https://console.groq.com/keys).
Enter your key directly in the app: **Settings > AI API Key**.

4. **Run the app**
```bash
flutter run
```

## 📦 Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**André Abreu**
- GitHub: [@abreuretto72](https://github.com/abreuretto72)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google for Generative AI integration
- Open source community for various packages used

## 📞 Support

For support, please open an issue in the GitHub repository.

---

**Made with ❤️ using Flutter**
