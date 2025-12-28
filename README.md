🚀 Flutter Clean Architecture

    This is a Flutter boilerplate project following Clean Architecture with Cubit (BLoC) for scalable and                  maintainable development.

📱 Final Output (Demo)

    📸 Screenshots are available in the /screenshots folder.

🧱 Project Architecture

  lib/
├── core/                     # App-wide utilities, constants, and base classes 
│   ├── constants/            # App constants (colors, strings, API URLs)
│   ├── utils/                # Helper functions and utilities
│

├── data/                     # Data layer (repositories, data sources, models)
│   ├── data_sources/         # Remote API or local DB interactions
│   │   ├── remote/           # REST API calls, network logic
│   │   └── local/            # SQLite, SharedPreferences, Hive, etc.
│   ├── models/               # Data models for serialization/deserialization
│   └── repositories/         # Repository implementations (use data_sources)
│
├── domain/                   # Domain layer (business logic, pure Dart)
│   ├── entities/             # Immutable entity classes
│   └── repositories/         # Abstract repository interfaces
│
├── view/                     # Presentation layer
│   ├── features/             # Feature-based organization
│   │   ├── transactions/     
│   │   │   ├── cubit/        # Cubit + State for transactions
│   │   │   ├── pages/        # Screens (TransactionPage, DetailsPage)
│   │   │   └── components/   # Widgets specific to transactions
│   │   └── home/             # Another feature module
│   │       ├── cubit/
│   │       ├── pages/
│   │       └── components/
│   └── shared/               # Widgets shared across multiple features
│
├── widgets/                  # Globally reusable widgets
│
├── library.dart              # Common exports (packages, helpers, widgets)
└── main.dart                 # App entry point, 

🧩 State Management
    Using flutter_bloc with Cubit for managing UI and business logic state.

🧪 Environment Setup
    - Flutter SDK: >=3.22.0 <4.0.0
    - Dart SDK: >=3.2.0 <4.0.0

🚀 How to Run the Project

    Clone the Repository:
    Open in Android Studio or VS Code
    Install Dependencies:
    flutter pub get
    Run the App:
    flutter run


📦 Third-Party Packages Used
  flutter_bloc - State management (Cubit)

