# flutter3_dart3

Flutter and Dart 3, clean architecture

## Getting Started

flutter pub add <package>
dart run build_runner build --delete-conflicting-outputs (flutter pub run build_runner build)

Clean Architecture

config
    theme
    routes
core
    util
    error
    network
    use_cases
features
    <feature-name>
        presentation
            pages
            widgets
            state_management
        data (data retrieval)
            repository
            data_sources
            models
        domain (no dependencies)
            use_cases
            entities
            repository
