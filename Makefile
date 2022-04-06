# Run tests and generate coverage
test:
	(cd app && very_good test --coverage  --test-randomize-ordering-seed random \
	--exclude-coverage '\.g\.dart' --min-coverage 100 && \
	genhtml coverage/lcov.info -o coverage)

test_e2e:
	(cd app && flutter test integration_test)

# Open coverage
open_coverage:
	open app/coverage/index.html

watch_features_changes:
	(cd app && flutter packages pub run build_runner watch --delete-conflicting-outputs)
