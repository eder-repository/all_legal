# all_legal

A new Flutter project.

> all_legal is a mobile application for a technical test that is dedicated to uploading documents and signing them


## Key Features:

- Upload documents
- Upload Sign 
- Indicate Signatories
- Customizations
- Summary 

- It also includes internationalization throughout the app in Spanish and English.




## Prerequisites 💻
### Install FVM 


If you use the [Homebrew package manager](https://brew.sh) for Mac OS X or Linux, you can install FVM by running

```
brew tap leoafarias/fvm
brew install fvm
```

If you use [Chocolatey](https://chocolatey.org/) for Windows, run the following command from the command line or from PowerShell:

```bash
choco install fvm 
```
### Install Flutter

```bash
fvm install 3.24.0  # Installs specific version 
```
###  Or else  install version flutter 3.24.0




## Getting Started 🚀

For fvm's specific details, visit [fvm web page](https://fvm.app)

> You must first run the following commands to obtain the packages and generate the necessary code:

> ###  Install make file 

```bash
choco install make
```

- Get flutter dependencies in the project It is used in the terminal
```sh
$ al_packages:
# or
$ flutter pub get
```
- Generate necessary code 
```sh
$ make al_build
# or
$ dart run build_runner build --delete-conflicting-outputs
```
- Generate necessary code core packages

```sh
$ make core_build
# or
$ dart run build_runner build --delete-conflicting-outputs
```

- Generate localizations
```sh
$ make gf_slang
# or 
$ dart run slang
```
## Working with Translations 🌐

This project relies on the [slang][slang_link] type-safe i18n solution using JSON files.

### Adding Strings

1. To add new localizable strings, open the `myFeatureName.json` file at `i18n/en/myFeatureName.json`.

```json
{
    "appName": "All legal"
}
```

2. Then add a new key/value and description

```json
{
    "appName": "All legal"
}
```

3. Use the new string

```dart
import 'package:all_legal/i18n/translations.g.dart';

@override
Widget build(BuildContext context) {
  return Text(context.texts.misc.appName);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new JSON file in `lib/i18n`.

```
├── i18n
│   ├── en
│   │   ├── misc.json
│   │   ├── myFeature.json
│   ├── es
│   │   ├── misc.json
│   │   ├── myFeature.json
```

2. Add the translated strings to each `.json` file:

> IMPORTANT: slang does not support \_ or - for file names. You must use camelCase. Example `myFeatureName.json`

`i18n/en/myFeatureName.json`

```json
{
    "appName": "AllLegal",
    "events": "home"
}
```

`i18n/es/myFeatureName.json`

```json
{
    "appName": "AllLegal",
    "events": "home"
}
```

### Generating Translations

To use the latest translation changes, you will need to generate them:

```sh
$ make gf_slang
# or
$ dart run slang
```

---

[slang_link]: https://pub.dev/packages/slang
