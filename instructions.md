# Instructions for Biodiversity Conservation Citizen Flutter Mobile App

## Project Analysis

**Core Purpose**  
The app aims to engage citizens in biodiversity conservation by enabling them to run and participate in conservation campaigns. Users can capture and share animal sightings, contributing valuable data while promoting conservation awareness.

**Target Users**
- Citizens interested in conservation, aged 12 and above.
- Campaign organizers for biodiversity preservation.
- Researchers and conservationists seeking crowdsourced data.

**Key Features**
1. Social media login and user onboarding.
2. Conservation campaign dashboard with updates and notifications.
3. Animal sighting capture functionality.
4. Leaderboards for gamification and engagement.
5. User profile management.

**Technical Constraints**
- **Database, Storage and Authentication**: Firebase for user authentication, cloud storage, messaging, and Firestore.
- **Framework**: Flutter for cross-platform support with modern UI requirements.

---

## Feature Definition

### **1. Onboarding and User Authentication**
- **Description**: First-time users are introduced to the app and authenticated.
- **Requirements**:
    - **Onboarding Pages**:
        - Three interactive page views explaining app features.
        - Option to skip or continue at the end of onboarding.
    - **Social Login**:
        - Setup authentication for social media login with firebase.
        - Support for Google via Firebase Authentication.
        - create collection "users" in firestore
        - Save user data i.e name, uid, email to firestore with the collection name "users". The uid is used as a unique identifier for each document in the collection.
    - **User Info Collection**:
        - Post-login form for:
            - Profession (dropdown).
            - Animals of interest (multi-select chips).
            - Optional profile photo upload.
        - Add to collection "users" in firestore with the following fields:
            - name
            - profession
            - species interest
            - profile photo
            - points
            - rank
        - Data stored in Firestore by updating the "users" collection for the authenticated user. If profile photo is uploaded, it will be stored in Firebase Storage.

---

### **2. Home/Dashboard**
- **Description**: Main landing page showcasing campaigns and user activities.
    - Create a firestore collections called newsfeed.
        - Add to the newsfeed collection in firestore two other collections called "campaigns" and "submissions".
    - **Firestore Collection**: "campaigns" for active campaigns.
        - Add to collection "campaigns" in firestore with the following fields:
            - title
            - description
            - start date
            - banner image
            - end date
            - location
            - species
            - status
    - **Firestore Collection**: "submissions" for user activity feed.
        - Add to colection "submissions" in firestore with the following fields:
            - id
            - date
            - image
            - List<String> likes (which is a list of user ids)
            - name
            - species
            - location
            - status 
            - user id
- **Requirements**:
    - **Campaign Promotions**:
        - Horizontal list of active conservation campaigns from Firestore.
        - Highlight current conservation campaigns with clickable details.
    - **Real-time User Activity Feed**:
        - Vertical list of recent submissions, updates, and notifications from Firestore.
        - Updates via Firebase Cloud Messaging (push notifications).
    - **Header Section**:
        - Display user’s first name, last name initial, and profile avatar (clickable to Profile Page).

**Profile Page**:
- View and manage user details, including:
    - Profile photo and submitted details.
    - Submission history and status.
    - User points and rank.
    - Logout functionality.

---

### **3. Animal Capture**
- **Description**: Central feature to submit sightings for conservation efforts.
- **Requirements**:
    - Prominent “Capture Sighting” button.
    - Capture form fields:
        - Proposed name (text input).
        - Image of sighting (camera or gallery).
        - Area of sighting (dropdown).
        - Activity of animal (dropdown).
        - GPS coordinates auto-captured.
        - Date of sighting (auto-captured).
        - Time of sighting (auto-captured).
    - Submission Process:
        - Save data locally in SQLite DB with a unique UUID and pending status.
        - Background worker syncs pending data to Firestore with an image link to Firebase Storage.

---

### **4. Leaderboards**
- **Description**: Gamification to encourage participation.
- **Requirements**:
    - Display user rankings based on points earned for successful submissions.
    - Option to follow other users and view their profiles.
    - View detailed leaderboard with ranks and scores.

---

## Technical Requirements

### **Frameworks and Packages**
- **Flutter**: Latest stable version for cross-platform support.
- **Firebase**:
    - Authentication: Social login.
    - Firestore: User data, submissions, campaigns, and leaderboards.
    - Cloud Storage: Image uploads.
    - Cloud Messaging: Real-time updates and notifications.
- **SQLite**: Local data storage for offline support.
- **Additional Flutter Packages**:
    - `provider`  for state management.
    - `geolocator` for GPS integration.
    - `image_picker` for photo capture/upload.
    - `workmanager` for background data sync.
    - `intl` for date formatting.
    - `google_fonts` for custom fonts.
    - `flutter_svg` for SVG support.
    - `firebase_messaging` for push notifications.
    - `flutter_local_notifications` for local notifications.
    - `flutter_native_splash` for custom splash screen.
    - `flutter_launcher_icons` for app icons.    
    - `google_sign_in` for Google login.
    - `twitter_login` for Twitter login.
    - `firebase_auth` for authentication.
    - `cloud_firestore` for Firestore integration.
    - `firebase_storage` for Firebase Storage integration.
    - `path_provider` for file access.
    - `shared_preferences` for local storage.
    - `gap` for spacing and layout.
    - `flutter_animate` for animations.


---

## Data Management

- **User Data**: Profession, species interest, and profile photo stored in Firestore.
- **Sighting Data**: Temporarily stored in SQLite, then synced to Firestore.
- **Leaderboard Data**: Firebase Firestore collection for ranking and points.
- **Image Storage**: Firebase Storage with links saved in Firestore.

---

## User Experience

- **Modern UI**:
    - Simple and appealing design for users aged 12+.
    - Interactive onboarding with animations.
- **Accessibility**:
    - Intuitive navigation with a bottom bar for Home, Capture, and Leaderboards.
    - Accessible fonts, colors, and controls for usability.
- **Localization**:
    - Ensure text can be easily translated for multi-language support.

---

## Security

- **Authentication**:
    - Secure OAuth for social logins (Google, Twitter, Apple).
- **Data Protection**:
    - Firebase Firestore security rules for restricted access.
    - End-to-end encryption for data transfers.
- **Compliance**:
    - Adherence to GDPR and COPPA regulations for user data and children’s privacy.

---

## Testing and Quality Assurance

- **Onboarding Flow**: Test navigation and skip/continue options.
- **Authentication**: Validate social login for supported providers.
- **Data Sync**: Ensure smooth local-to-cloud submission.
- **Push Notifications**: Test real-time updates for various campaigns.
- **Leaderboard Accuracy**: Confirm point calculations and rankings.

---

## Documentation

### Essential Links
- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter fire documentation](https://firebase.flutter.dev/)
- [Firebase Authentication Guide](https://firebase.google.com/docs/auth)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- [Cloud Storage Documentation](https://firebase.google.com/docs/storage)
- [SQLite in Flutter](https://pub.dev/packages/sqflite)  
