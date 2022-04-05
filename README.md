

### Folder Structure
Here is the core folder structure which flutter provides.

```
seat_geek/
|- assets
|- android
|- ios
|- build
|- lib
|- test
|- scripts
```

Here is the folder structure we have been using in this project

```
lib/
|- api/
    |- entities/(Model class for APIs)
    |- api_constants.dart (constant variables for API JSON model class)
    |- api_names.dart (List of apis and base url)
|- bloc/
|- core/
    |- cache/
    |- error/
    |- network/
    |- utils/
|- extension/
|- inject/
|- localizations/
|- services/
|- ui/
|- main.dart
```

## Scripts:
Execute `formatter.sh` to format dart files. The script must be executed before creating a PR.
```
./scripts/formatter.sh
```

Here is a script for generate `*.g.dart`
```
./scripts/build_runner.sh
```

## How to run:
Execute `build_runner.sh` or `flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs;` in terminal.