all: test

test:
	@echo "Running tests..."
	@for f in tests/*.toit; do \
		echo "Running $$f"; \
		toit $$f; \
	done
