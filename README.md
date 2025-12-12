# MviewerPlus 📱

> **Advanced File Viewer with AI-Powered Analysis**

A powerful Flutter application for viewing, analyzing, and exporting various file formats with intelligent CSV optimization and AI assistance.

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-blue.svg)](https://flutter.dev/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey.svg)](https://github.com/abreuretto72/MviewerPlus)

## ✨ Features

### 📄 File Viewing
- **Multi-format Support**: View CSV, JSON, XML, TXT, code files, and more
- **Syntax Highlighting**: Beautiful code highlighting for multiple programming languages
- **Smart CSV Handling**: Intelligent data cleaning and optimization
  - Automatic removal of empty columns and rows
  - Detection and removal of header/footer junk
  - Support for files with 250+ columns and thousands of rows

### 🚀 Performance Optimizations
- **Background Processing**: CSV parsing in separate isolates for smooth UI
- **Virtualized Rendering**: Efficient display of large datasets
- **Synchronized Scrolling**: Perfect horizontal scroll sync in CSV tables
- **Smart Delimiter Detection**: Fast and accurate CSV delimiter identification

### 🤖 AI Integration
- **AI-Powered Analysis**: Ask questions about your files using AI
- **Context-Aware Responses**: Get insights based on file content
- **Export Conversations**: Save AI chat sessions as PDF

### 📊 Export & Sharing
- **PDF Export**: Convert files and AI chats to formatted PDFs
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
- **Google Generative AI**: AI-powered file analysis
- **PDF Generation**: Professional PDF export with `pdf` and `printing` packages
- **CSV Parsing**: Optimized CSV handling with intelligent cleaning
- **Syntax Highlighting**: Code display with `flutter_highlight`

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
Create a `.env` file in the root directory:
```env
GEMINI_API_KEY=your_api_key_here
```

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
