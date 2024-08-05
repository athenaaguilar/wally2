## Setup Commands ----------------------------------------

pubs: ## Gets pubs
	flutter pub get

format: ## Formats the codebase
	dart format lib test

lint: ## Analyzes the codebase for issues
	flutter analyze
	dart analyze

run: ## Run the app
	flutter run

## Rebuilds the project
rebuild: pubs format lint run

## Tests Commands ----------------------------------------

tests: ## Runs all unit tests
	flutter test test/unit