# Clean Architecture Trivia App

## Overview
The Clean Architecture Trivia App is a Flutter application designed to showcase the implementation of Clean Architecture principles. It allows users to discover trivia about numbers, either by entering a specific number or by fetching random trivia. The app demonstrates a well-structured project that separates concerns into layers, including presentation, domain, and data, ensuring scalability, maintainability, and testability.

## Features
- **Get Trivia for a Specific Number**: Users can enter a number to get interesting facts about it.
- **Get Random Number Trivia**: Users can fetch trivia for a random number for a fun, spontaneous experience.
- **Clean Architecture**: The project is structured according to Clean Architecture principles, separating the app into layers and defining clear interfaces.
- **Bloc for State Management**: Utilizes the Bloc library for managing app state, demonstrating a practical implementation of the pattern in a Flutter app.
- **Unit and Widget Tests**: Includes examples of unit and widget tests, showcasing testing strategies for Clean Architecture.

## Technologies Used
- **Flutter**: For creating the UI and handling user interactions.
- **Dart**: The programming language used to develop the application.
- **Bloc**: For state management, following the principles of CQRS (Command Query Responsibility Segregation).
- **Dartz**: For handling functional programming concepts, such as Either for error handling.
- **Mockito**: For mocking dependencies in tests, ensuring that unit tests are reliable and independent of external factors.

## Getting Started
To run the Clean Architecture Trivia App on your local machine, follow these steps:

1. **Clone the Repository**: Clone the project to your local machine.
2. **Install Dependencies**: Run `flutter pub get` in the project directory to install the required dependencies.
3. **Run the App**: Execute `flutter run` to run the app on a connected device or emulator.

## Testing
This project emphasizes testing, with examples of unit and widget tests. To run the tests, execute the following command in the project directory:
