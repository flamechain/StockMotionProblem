TEST_FILES:=$(wildcard tests/*)
SOURCE_FILE:=$(wildcard src/*.dart)
DART:=dart

test:
	$(DART) $(SOURCE_FILE) $(TEST_FILES)
