# Run tests and generate coverage
test:
	(cd flutter_bloc_clean_architecture && very_good test --coverage --test-randomize-ordering-seed random && \
	remove_from_coverage -f coverage/lcov.info -r '\.g\.dart' && \
	genhtml coverage/lcov.info -o coverage)

# Open coverage
open_coverage:
	open flutter_bloc_clean_architecture/coverage/index.html
