# Flutter Push Notifications Implementation

A comprehensive Flutter project demonstrating Firebase Cloud Messaging (FCM) integration with local notifications, navigation routing, and screen wake-up functionality.

## 📱 Features

- **Firebase Cloud Messaging (FCM)** integration
- **Local Notifications** for foreground messages
- **Smart Navigation Routing** based on notification data
- **Screen Wake-up** when notifications arrive
- **App State Persistence** using SharedPreferences
- **Multi-screen Navigation** with notification-driven routing

## 🏗️ Architecture Overview

```mermaid
graph TB
    A[Firebase Console] -->|Send FCM Message| B[Firebase Cloud Messaging]
    B --> C{App State}

    C -->|Foreground| D[Local Notification Service]
    C -->|Background| E[System Notification]
    C -->|Terminated| F[System Notification]

    D --> G[Show Local Notification]
    E --> H[Show System Notification]
    F --> I[Show System Notification]

    G -->|User Taps| J[Navigation Router]
    H -->|User Taps| J
    I -->|User Taps| J

    J --> K{Parse Notification Data}
    K -->|type: friend_request| L[Friend Requests Screen]
    K -->|type: chat| M[Chat Screen]
    K -->|type: like| N[Profile Screen]
    K -->|unknown/default| O[Home Screen]

    P[App Preferences] -->|Store/Retrieve| Q[FCM Token]
    P -->|Store/Retrieve| R[App State]
```

## � How It Works - The User Experience

When I built this notification system, I wanted to create something that feels natural and intuitive for users. Here's what actually happens when someone receives a notification:

### 📱 **When You're Using the App** (Foreground)

Imagine you're actively browsing the app, and suddenly a friend likes your profile picture. Instead of disrupting your current activity, the app shows a subtle local notification at the top of your screen. You can choose to tap it and instantly jump to your profile to see the interaction, or simply ignore it and continue what you were doing.

### 🔄 **When You've Minimized the App** (Background)

Let's say you're texting someone and have the app running in the background. When you receive a chat message notification, it appears as a system notification just like any other app. The moment you tap it, boom! The app opens directly to the chat screen with that specific conversation - no need to navigate through menus or search for the chat.

### 🚀 **When the App is Completely Closed** (Terminated)

This is where the magic really happens. Your app is completely closed, maybe you haven't used it in hours. Someone sends you a friend request. Your phone buzzes, the screen lights up, and you see the notification. When you tap it, the app doesn't just open to the home screen like most apps do - it launches directly to the friend requests page where you can immediately see who wants to connect with you.

### 🎯 **Smart Routing Based on What You Received**

The system is smart enough to know what type of notification you received:

- **Friend Request** → Takes you straight to pending friend requests
- **Chat Message** → Opens directly to that specific chat conversation
- **Profile Like** → Shows your profile where you can see the new interaction
- **Unknown/General** → Safely defaults to the home screen

### 🔧 **Behind the Scenes**

What makes this smooth is that every notification carries a small piece of data that tells the app exactly where to take you. It's like having a GPS coordinate for each notification type. The app reads this "coordinate" and instantly knows which screen to show you.

The beauty is that users don't need to think about any of this complexity - they just tap a notification and land exactly where they expect to be. That's the kind of user experience I wanted to create with this implementation.

## �🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Firebase project setup
- Android/iOS development environment

### 1. Firebase Setup

1. **Create Firebase Project**

   ```bash
   # Visit https://console.firebase.google.com/
   # Create new project or use existing one
   ```

2. **Install Firebase CLI**

   ```bash
   npm install -g firebase-tools
   firebase login
   ```

3. **Configure Firebase for Flutter**
   ```bash
   flutter pub global activate flutterfire_cli
   flutterfire configure
   ```

### 2. Dependencies Installation

```bash
flutter pub get
```

**Dependencies used:**

```yaml
dependencies:
  firebase_core: ^4.0.0
  firebase_messaging: ^16.0.0
  flutter_local_notifications: ^18.0.1
  shared_preferences: ^2.5.3
```

### 3. Android Configuration

#### AndroidManifest.xml Setup

Location: `android/app/src/main/AndroidManifest.xml`

```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:showWhenLocked="true"
    android:turnScreenOn="true"
    android:windowSoftInputMode="adjustResize">
```

#### Gradle Configuration

Location: `android/app/build.gradle.kts`

```kotlin
android {
    compileSdk = 34

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
```

### 4. iOS Configuration (Optional)

Add to `ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

## 📂 Project Structure

```
lib/
├── main.dart                           # App entry point & FCM initialization
├── firebase_options.dart              # Firebase configuration
├── core/
│   ├── navigation/
│   │   └── app_router.dart            # Navigation routing & notification handling
│   └── services/
│       ├── app_prefs.dart             # SharedPreferences wrapper
│       ├── fcm_service.dart           # FCM token & listener management
│       └── local_notification_service.dart # Local notifications
└── features/
    ├── home/view/home_page.dart       # Home screen with navigation buttons
    ├── chat/view/chat_screen.dart     # Chat screen
    ├── friend_requests/view/friend_requests_screen.dart
    └── profile/view/profile_screen.dart
```

## 🔄 Notification Flow

### 1. App Lifecycle States

```mermaid
flowchart TD
    Start([App Start]) --> Foreground[Foreground]
    Foreground --> |App Minimized| Background[Background]
    Background --> |App Killed| Terminated[Terminated]
    Background --> |App Resumed| Foreground
    Terminated --> |App Launched| Foreground

    Foreground --> |FCM Message| LocalNotification[LocalNotification]
    Background --> |FCM Message| SystemNotification[SystemNotification]
    Terminated --> |FCM Message| SystemNotification

    LocalNotification --> |User Taps| Navigate[Navigate]
    SystemNotification --> |User Taps| Navigate
    Navigate --> |Based on Data| TargetScreen[TargetScreen]

    %% Color coding by functional groups
    classDef appStates fill:#90EE90,stroke:#333,stroke-width:2px,color:#000
    classDef notifications fill:#FFA500,stroke:#333,stroke-width:2px,color:#000
    classDef navigation fill:#9370DB,stroke:#333,stroke-width:2px,color:#fff
    classDef inactive fill:#D3D3D3,stroke:#333,stroke-width:2px,color:#000

    class Foreground,Background appStates
    class Terminated inactive
    class LocalNotification,SystemNotification notifications
    class Navigate,TargetScreen navigation
```

### 2. Notification Data Structure

Send notifications with this data format:

```json
{
  "notification": {
    "title": "Friend Request",
    "body": "John Doe sent you a friend request"
  },
  "data": {
    "type": "friend_request",
    "fromUserId": "user123",
    "requestId": "req456"
  }
}
```

### 3. Supported Notification Types

| Type             | Screen          | Required Data             |
| ---------------- | --------------- | ------------------------- |
| `friend_request` | Friend Requests | `fromUserId`, `requestId` |
| `chat`           | Chat Screen     | `chatId`, `fromUserId`    |
| `like`           | Profile Screen  | `userId`                  |
| Default          | Home Screen     | None                      |

## ⚡ Key Components

### FCM Service (`fcm_service.dart`)

- **Token Management**: Fetches and persists FCM tokens
- **Permission Handling**: Requests notification permissions
- **Lifecycle Listeners**: Handles foreground, background, and terminated states
- **Smart Token Caching**: Avoids unnecessary token fetches

### Local Notification Service (`local_notification_service.dart`)

- **Foreground Notifications**: Shows notifications when app is active
- **Screen Wake-up**: Turns on device screen for important notifications
- **Channel Configuration**: Sets up Android notification channels
- **Tap Handling**: Routes to appropriate screens when tapped

### Navigation Router (`app_router.dart`)

- **Data-driven Routing**: Navigates based on notification payload
- **Navigator Ready Check**: Waits for MaterialApp to be ready
- **Fallback Handling**: Defaults to home screen for unknown types

### App Preferences (`app_prefs.dart`)

- **Token Persistence**: Stores FCM tokens locally
- **Generic Storage**: Provides methods for string, bool, int, double storage
- **Singleton Pattern**: Ensures single instance across app
 
 
---

Built with ❤️ by Shishir Rijal using Flutter & Firebase
