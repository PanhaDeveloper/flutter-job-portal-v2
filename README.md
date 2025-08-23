<div align="center">

# 🚀 Flutter Job Portal v2

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
<img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase">
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
<img src="https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge" alt="License">

### 🌟 A Modern, Performance-Optimized Job Portal Application

*Connecting job seekers with their dream careers through innovative technology*

[📱 Features](#-features) • [🛠️ Installation](#%EF%B8%8F-installation-guide) • [🏗️ Architecture](#%EF%B8%8F-project-architecture) • [🔧 Configuration](#-configuration) • [📋 Documentation](#-documentation)

</div>

---

## 📋 Prerequisites

Before diving into this amazing project, ensure you have these tools ready:

### 🖥️ System Requirements

| Platform | Minimum Version | Recommended |
|----------|----------------|-------------|
| **Flutter SDK** | 3.7.2+ | Latest Stable |
| **Dart** | 3.0+ | Latest |
| **Android Studio** | 2022.1+ | Latest |
| **VS Code** | 1.70+ | Latest |
| **Git** | 2.30+ | Latest |

### 🔧 Development Tools
- **Android SDK** (API 21+)
- **Xcode** (iOS development - macOS only)
- **Chrome** (Web development)
- **Firebase CLI** (Optional but recommended)

---

## 🚀 Installation Guide

### 🏁 Step 1: Flutter SDK Installation

<details>
<summary>🪟 <strong>Windows Installation</strong></summary>

```powershell
# Download Flutter SDK
Invoke-WebRequest -Uri "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.3-stable.zip" -OutFile "flutter_windows.zip"

# Extract to C:\development\flutter
Expand-Archive -Path "flutter_windows.zip" -DestinationPath "C:\development"

# Add to PATH (System Environment Variables)
# Add: C:\development\flutter\bin

# Verify installation
flutter doctor
```

</details>

<details>
<summary>🍎 <strong>macOS Installation</strong></summary>

```bash
# Using Homebrew (Recommended)
brew install flutter

# Or manual installation
cd ~/development
curl -o flutter_macos.zip https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.24.3-stable.zip
unzip flutter_macos.zip

# Add to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify installation
flutter doctor
```

</details>

<details>
<summary>🐧 <strong>Linux Installation</strong></summary>

```bash
# Install dependencies
sudo apt-get update
sudo apt-get install curl git unzip xz-utils zip libglu1-mesa

# Download and extract Flutter
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz
tar xf flutter_linux_3.24.3-stable.tar.xz

# Add to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
flutter doctor
```

</details>

### 🔨 Step 2: Development Environment Setup

#### Android Studio Configuration
```bash
# Install Android Studio from: https://developer.android.com/studio
# During setup, ensure these components are installed:
# - Android SDK
# - Android SDK Platform-Tools
# - Android SDK Build-Tools
# - Android Emulator

# Install Flutter and Dart plugins in Android Studio
```

#### VS Code Setup (Recommended for this project)
```bash
# Install VS Code extensions:
code --install-extension Dart-Code.flutter
code --install-extension Dart-Code.dart-code
code --install-extension ms-vscode.vscode-json
code --install-extension bradlc.vscode-tailwindcss
code --install-extension usernamehw.errorlens
```

### 🏗️ Step 3: Project Setup

```bash
# Clone the repository
git clone https://github.com/PanhaDeveloper/flutter-job-portal-v2.git
cd flutter-job-portal-v2

# Install dependencies
flutter pub get

# Run code generation (if needed)
flutter packages pub run build_runner build

# Check everything is working
flutter doctor
flutter devices
```

---

## 🔧 Firebase Configuration

This project uses **Firebase** for backend services. Follow these steps for complete setup:

### 🔥 Firebase Project Setup

1. **Create Firebase Project**
   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools
   
   # Login to Firebase
   firebase login
   
   # Initialize Firebase in project
   firebase init
   ```

2. **Enable Required Services**
   - ✅ **Authentication** (Email/Password, Google, Facebook)
   - ✅ **Cloud Firestore** (Database)
   - ✅ **Firebase Storage** (File uploads)
   - ✅ **Cloud Messaging** (Push notifications)

### 📱 Platform Configuration

<details>
<summary><strong>🤖 Android Configuration</strong></summary>

```bash
# Add Android app in Firebase Console
# Download google-services.json
# Place in: android/app/google-services.json

# Update android/app/build.gradle
# Add at the bottom:
apply plugin: 'com.google.gms.google-services'

# Update android/build.gradle
# Add to dependencies:
classpath 'com.google.gms:google-services:4.3.15'
```

</details>

<details>
<summary><strong>🍎 iOS Configuration</strong></summary>

```bash
# Add iOS app in Firebase Console
# Download GoogleService-Info.plist
# Add to ios/Runner/ in Xcode

# Update ios/Runner/Info.plist with URL schemes
# Add your REVERSED_CLIENT_ID from GoogleService-Info.plist
```

</details>

<details>
<summary><strong>🌐 Web Configuration</strong></summary>

```bash
# Add Web app in Firebase Console
# Copy web configuration
# Update lib/firebase_options.dart with your config

# The project already includes web config in firebase_options.dart
# Update with your Firebase project details
```

</details>

### 🔐 Social Authentication Setup

#### Google Sign-In
```bash
# Android: Add SHA-1 fingerprint to Firebase
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore

# iOS: Configure URL schemes in Info.plist
# Web: Add authorized domains in Firebase Console
```

#### Facebook Authentication
```bash
# Create Facebook App at: https://developers.facebook.com/
# Add Facebook App ID to Firebase Authentication
# Update facebook_app_id in android/app/src/main/res/values/strings.xml
```

---

## 🏃‍♂️ Running the Application

### 🎯 Quick Start Commands

```bash
# Check available devices
flutter devices

# Run on connected device/emulator
flutter run

# Run with specific device
flutter run -d <device-id>

# Run in release mode for better performance
flutter run --release

# Run with hot reload (development)
flutter run --hot
```

### 🎪 Platform-Specific Runs

```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Web
flutter run -d web-server --web-port 8080

# Windows (if configured)
flutter run -d windows

# macOS (if configured)
flutter run -d macos
```

---

## 🏗️ Project Architecture

This project follows **Clean Architecture** principles with **GetX** for state management:

```
📦 lib/
├── 🚀 main.dart                    # Application entry point
├── 📱 app.dart                     # App configuration & theme
├── 🔥 firebase_options.dart        # Firebase configuration
│
├── 📂 cores/                       # Core utilities & shared components
│   ├── 🔗 bindings/               # GetX bindings
│   ├── 📊 data/                   # Static data & constants
│   ├── 🎨 shared/                 # Shared widgets
│   └── 🛠️ utils/                  # Utilities, constants, themes
│       ├── 🎨 theme/              # App themes (light/dark)
│       ├── 🖼️ constants/          # Colors, images, UI constants
│       ├── 🔒 security/           # Security services & encryption
│       ├── 📈 performance/        # Performance monitoring
│       └── 📝 logging/            # Logging utilities
│
├── 📂 features/                    # Feature modules
│   ├── 🏠 home/                   # Home screen & widgets
│   ├── 🔐 auth/                   # Authentication flows
│   ├── 💼 jobs/                   # Job listings & details
│   ├── 👤 profile/                # User profile management
│   ├── ⚙️ settings/               # App settings
│   ├── 🌐 network/                # Network handling
│   └── 📱 onboarding/             # App introduction
│
├── 📂 routes/                      # Navigation & routing
│   ├── 🗺️ app_routes.dart         # Route definitions
│   └── 📄 app_pages.dart          # Page configurations
│
└── 📂 locale/                      # Internationalization
    └── 🌍 locale.dart              # Multi-language support
```

### 🎯 Key Features Breakdown

#### 🔐 **Advanced Security**
- **PIN/Password Protection**: App-level security
- **Biometric Authentication**: Fingerprint & Face ID
- **Encryption**: SHA-256 credential hashing
- **Auto-lock**: Configurable timeout settings

#### 🚀 **Performance Optimizations**
- **Memory Management**: Smart controller disposal
- **Image Caching**: Optimized network image loading
- **Lazy Loading**: On-demand widget rendering
- **Performance Monitoring**: Real-time performance tracking

#### 🌍 **Internationalization**
- **Multi-language Support**: English, Khmer, Chinese
- **RTL Support**: Right-to-left language compatibility
- **Dynamic Language Switching**: Runtime language changes

#### 📱 **Modern UI/UX**
- **Material Design 3**: Latest design principles
- **Custom Animations**: Smooth page transitions
- **Responsive Design**: Adaptive layouts for all screens
- **Dark/Light Themes**: Automatic theme switching

---

## 🎨 Features

### 🔑 **Authentication & Security**
- 📧 **Email/Password Authentication**
- 🔑 **Google Sign-In Integration**
- 📘 **Facebook Login**
- 🔒 **PIN/Password App Lock**
- 👆 **Biometric Authentication**
- 🔐 **Secure Data Storage**

### 💼 **Job Management**
- 🔍 **Advanced Job Search**
- 📊 **Smart Filtering**
- ⭐ **Favorite Jobs**
- 📄 **Detailed Job Descriptions**
- 🏢 **Company Profiles**
- 📝 **Easy Job Applications**

### 👤 **Profile & Settings**
- 📋 **Personal Profile Management**
- 🔧 **Comprehensive Settings**
- 🌍 **Language Preferences**
- 🔔 **Notification Controls**
- 🎨 **Theme Customization**

### 📱 **Enhanced UX**
- 🎭 **Smooth Animations**
- 📡 **Offline Support**
- 🔄 **Real-time Updates**
- 📊 **Performance Monitoring**
- 🌐 **Multi-platform Support**

---

## 🛠️ Development Commands

### 📦 **Package Management**
```bash
# Get dependencies
flutter pub get

# Upgrade packages
flutter pub upgrade

# Add new package
flutter pub add package_name

# Remove package
flutter pub remove package_name
```

### 🏗️ **Build Commands**
```bash
# Build APK (Android)
flutter build apk --release

# Build App Bundle (Android)
flutter build appbundle --release

# Build iOS (macOS only)
flutter build ios --release

# Build Web
flutter build web --release

# Build Windows
flutter build windows --release
```

### 🧹 **Maintenance**
```bash
# Clean project
flutter clean

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test

# Check for updates
flutter upgrade
```

---

## 🔧 Configuration Files

### 📋 **Key Configuration Files**

<details>
<summary><strong>📱 pubspec.yaml</strong></summary>

The project uses these main dependencies:
- **State Management**: GetX (^4.7.2)
- **Firebase**: Core, Auth, Firestore, Storage
- **UI Components**: Lottie, Cached Network Image, Carousel Slider
- **Utilities**: Connectivity Plus, Image Picker, File Picker
- **Security**: Crypto (^3.0.5)

</details>

<details>
<summary><strong>🔥 Firebase Options</strong></summary>

```dart
// Firebase is pre-configured for:
// - Web: laravel-ea7a9.firebaseapp.com
// - Android: com.example.jobApp
// - iOS: com.example.quizApp

// Update with your Firebase project details
```

</details>

<details>
<summary><strong>📱 App Configuration</strong></summary>

```dart
// Key app settings in app.dart:
// - Theme: Light/Dark mode support
// - Localization: EN, KM, ZH support
// - Performance: Optimized transitions
// - Navigation: GetX routing
```

</details>

---

## 🐛 Troubleshooting

### ⚠️ **Common Issues & Solutions**

<details>
<summary><strong>🔥 Firebase Issues</strong></summary>

**Problem**: Firebase not initialized
```bash
# Solution:
flutter clean
flutter pub get
# Ensure google-services.json is in android/app/
# Ensure GoogleService-Info.plist is added to iOS project
```

**Problem**: Google Sign-In not working
```bash
# Solution:
# Add SHA-1 fingerprint to Firebase Console
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
```

</details>

<details>
<summary><strong>📱 Build Issues</strong></summary>

**Problem**: Gradle build failed
```bash
# Solution:
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

**Problem**: iOS build failed
```bash
# Solution:
cd ios
rm Podfile.lock
rm -rf Pods
pod install
cd ..
flutter clean
flutter pub get
```

</details>

<details>
<summary><strong>🔧 Development Issues</strong></summary>

**Problem**: Hot reload not working
```bash
# Solution:
flutter clean
flutter pub get
# Restart your IDE
# Use 'r' in terminal to manually reload
```

**Problem**: Dependencies conflict
```bash
# Solution:
flutter pub deps
flutter pub upgrade
# Check for package compatibility
```

</details>

---

## 📚 Documentation

### 📖 **Additional Resources**

- [📱 Flutter Documentation](https://docs.flutter.dev/)
- [🔥 Firebase Documentation](https://firebase.google.com/docs)
- [🎯 GetX Documentation](https://github.com/jonataslaw/getx)
- [🎨 Material Design 3](https://m3.material.io/)

### 🤝 **Contributing**

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### 📄 **License**

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

### 🌟 **Made with ❤️ by PanhaDeveloper**

*If you find this project helpful, please give it a ⭐!*

[⬆️ Back to Top](#-flutter-job-portal-v2)

</div>
