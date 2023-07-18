# QuizCraft Frontend

## Project overview

Welcome to our website, a one-stop platform that empowers users to create personalized quizzes or discover suitable ones. We understand the struggle of finding comprehensive evaluations on specific topics, whether it's searching for quizzes, tests, or open-ended questions scattered across the web. Our mission is to simplify this process by offering a centralized hub for generating quizzes on demand.</br>

***Key Features***:

1. *Create Personalized Quizzes*
2. *Extensive Quiz Library*
3. *On-Demand Quiz Generation*
4. *Answer Assistance*

## Requirements and How to build

- Install [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Go to main folder of the application and run `flutter pub get` and then `flutter build web --release`
- This populates a `build/web` directory with built files, including an assets directory, which need to be served together.
- Use files files from `build/web` for deploying. For example, you can run in this folder simple python server with following command `python -m http.server 8000`.
- Moreover, run `flutter build apk` for apk file.

## How to use

[Link to demo](#)

## Implementation details

1. State management is implemented with Bloc library. It helps to easily add new features to the logic.
2. Navigation is made with AutoRoute library. It allows to customize path of pages and use path as provider of information.
