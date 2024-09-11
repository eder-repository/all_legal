al_packages:
	flutter pub get

flutter_gen:
	cd packages/all_legal_ui && fluttergen -c pubspec.yaml

al_build:
	flutter pub get packages && flutter pub run build_runner build --delete-conflicting-outputs 

core_build:
	cd packages/all_legal_core && flutter pub run build_runner build --delete-conflicting-outputs

al_slang:
	dart run slang