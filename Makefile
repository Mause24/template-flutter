.PHONY: dev prod build-dev build-prod format analyze test clean lint

format:
	dart format .

analyze:
	dart analyze

test:
	flutter test

clean:
	flutter clean

dev:
	flutter run --dart-define-from-file=.env.dev

prod:
	flutter run --dart-define-from-file=.env.prod

build-dev:
	flutter build --dart-define-from-file=.env.dev 

build-prod:
	flutter build --dart-define-from-file=.env.prod

install-hooks:
	@echo "Instalando pre-commit hook..."
	@rm -f .git/hooks/pre-commit
	@ln -s ../../tool/pre-commit.sh .git/hooks/pre-commit
	@echo "Hook instalado!"

lint:
	@flutter analyze
	@flutter pub run dart_code_metrics:metrics analyze lib
