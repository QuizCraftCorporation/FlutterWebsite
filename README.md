# QuizCraft Frontend

## Requirements
Install the following:
- flutter
- optional: python (for running the simple server)

## How to build
- Install [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Go to main folder of the application and run `flutter build web --release`
- This populates a `build/web` directory with built files, including an assets directory, which need to be served together.
- Use files files from `build/web` for deploying. For example, you can run in this folder simple python server with following command `python -m http.server 8000`.
- Moreover, run `flutter build apk` for apk file.