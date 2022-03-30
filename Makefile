# Run tests and generate coverage
test:
	(cd flutter_bloc_clean_architecture && very_good test --coverage --test-randomize-ordering-seed random \
	--exclude-coverage '\.g\.dart' --min-coverage 100 && \
	genhtml coverage/lcov.info -o coverage)

# Open coverage
open_coverage:
	open flutter_bloc_clean_architecture/coverage/index.html

watch_features_changes:
	(cd flutter_bloc_clean_architecture && flutter packages pub run build_runner watch --delete-conflicting-outputs)
