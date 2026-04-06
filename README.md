<div align="center">

# 🛡️ GraphGuardians — Mobile App

### *Stay ahead of vulnerabilities — anytime, anywhere.*

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase_FCM-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Socket.IO](https://img.shields.io/badge/Socket.IO-010101?style=for-the-badge&logo=socket.io&logoColor=white)](https://socket.io)
[![Hackathon](https://img.shields.io/badge/IIT%20Delhi-Hackathon-FF5722?style=for-the-badge)](https://github.com/GraphGuardians)

<br/>

> **"We don't just detect vulnerabilities — we show exactly how they reach your code."**

</div>

---

## 📖 Overview

The **GraphGuardians Mobile App** is a Flutter-based real-time security monitoring interface that keeps developers instantly informed about vulnerabilities in their projects — straight from their phone.

- 📡 Live updates from backend vulnerability scans
- 🔔 Instant push notifications via Firebase FCM
- 📊 Mobile-friendly security dashboard
- ⚡ Real-time scan tracking via Socket.IO

---

## ✨ Key Features

| Feature | Description |
|---|---|
| 🔔 **Push Notifications** | Firebase FCM alerts within **< 5 seconds** of scan completion |
| 📊 **Security Dashboard** | Vulnerability breakdown by severity — Critical / High / Medium / Low |
| ⚡ **Live Scan Updates** | Real-time scan progress via Socket.IO, auto-refreshes on completion |
| 🔗 **Deep Linking** | Tap a notification → lands directly on that repo's scan result |
| 📱 **On-the-go Monitoring** | Full scan results, insights, and alerts from anywhere |

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter 3.x |
| **Language** | Dart |
| **Push Notifications** | Firebase Cloud Messaging (FCM) |
| **Real-Time** | Socket.IO |
| **API Communication** | REST APIs (`dio`) |
| **State Management** | Provider / Riverpod |
| **Navigation** | GoRouter + Deep Linking |

---

## 🏗️ Architecture
```
Backend (Node.js API)
        ↓
Firebase FCM + Socket.IO
        ↓
Flutter Mobile App
        ↓
User Interface (Dashboard + Alerts)
```

---

## 🚀 How It Works

1. 📡 Backend completes a vulnerability scan
2. 🔔 Firebase sends a push notification instantly
3. 📱 User receives alert with repo name, vuln count & severity
4. 👆 User taps notification (deep link)
5. 📊 App opens dashboard with full updated scan results

---

## 📱 App Screens

| Screen | Preview |
|---|---|
| **Dashboard** | *(add screenshot)* |
| **Scan Results** | *(add screenshot)* |
| **Push Notification** | *(add screenshot)* |
| **Vulnerability Detail** | *(add screenshot)* |

> 📸 Screenshots: [View on Google Drive](https://drive.google.com/drive/folders/1BO918riNZjUSYQUWwg3_2osKcK7moKoc)
>
> 🎥 Demo Video: [Watch on Google Drive](https://drive.google.com/file/d/1QJBNoEcdxjohO44JZctz57B6oBL5Gst5/view?usp=drivesdk)

---

## ⚡ Performance

| Metric | Result |
|---|---|
| 📱 Push notification delivery | **< 5 seconds** |
| 🔄 Real-time socket updates | Instant |
| ⚡ UI render after scan | Instant |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>= 3.0.0`
- Dart `>= 3.0.0`
- Android Studio / Xcode
- A running instance of the [GraphGuardians Backend](https://github.com/GraphGuardians/backend)
- Firebase project with FCM enabled

### Installation
```bash
# 1. Clone the repository
git clone https://github.com/GraphGuardians/GraphGuardians-app.git
cd GraphGuardians-app

# 2. Install dependencies
flutter pub get

# 3. Add your Firebase config
# Place google-services.json      →  android/app/
# Place GoogleService-Info.plist  →  ios/Runner/

# 4. Run the app
flutter run
```

### Build APK (Android)
```bash
flutter build apk --release
# Output → build/app/outputs/flutter-apk/app-release.apk
```

### Build for iOS
```bash
flutter build ios --release
```

### 🔐 Permissions Required

- 📶 Internet access
- 🔔 Notification permission

---

## 🗂️ Folder Structure
```
GraphGuardians-app/
├── lib/
│   ├── main.dart                  # Entry point
│   ├── app.dart                   # App config & routing
│   ├── core/
│   │   ├── api/                   # REST API calls to backend
│   │   └── models/                # Data models (ScanResult, Alert)
│   ├── features/
│   │   ├── dashboard/             # Home screen & live stats
│   │   ├── scan_result/           # Scan details screen
│   │   └── notifications/         # Alert history screen
├── android/
│   └── app/google-services.json   # Firebase Android config
├── pubspec.yaml                   # Dependencies
└── .env.example                   # Environment variable template
```

---

## 🔮 Future Enhancements

- 📊 Advanced analytics dashboard
- 🌙 Dark mode
- 📱 Offline scan history
- 🔔 Custom alert preferences
- 🔗 Slack / Jira integrations

---

## 🔗 Related Repositories

| Repo | Description |
|---|---|
| [`GraphGuardians/backend`](https://github.com/GraphGuardians/backend) | Node.js + TigerGraph API & vulnerability detection engine |
| [`GraphGuardians/frontend`](https://github.com/GraphGuardians/frontend) | React.js web dashboard |
| [`GraphGuardians/GraphGuardians-app`](https://github.com/GraphGuardians/GraphGuardians-app) | ← You are here — Flutter mobile app |

---

## 👥 Team

| Name | Role |
|---|---|
| 👨‍💻 Dev Varshney | Team Lead / Backend |
| 👨‍💻 Priyank Singh | Frontend |
| 👩‍💻 Swastika Singh | App Developer |
| 👩‍💻 Ritika Katta | ML Engineer |

> *Built with 💙 for IIT Delhi Hackathon — Track: Open Innovation / Cybersecurity + Graph Intelligence*

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**GraphGuardians** · *Secure the graph. Guard the system.*

[![GitHub Org](https://img.shields.io/badge/GitHub-GraphGuardians-181717?style=flat-square&logo=github)](https://github.com/GraphGuardians)

</div>
