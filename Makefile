.PHONY: all clean linux macos

BUILD_DIR := build
BUILD_TYPE ?= Release

all: $(BUILD_DIR)/libcodequality

$(BUILD_DIR)/libcodequality:
	mkdir -p $(BUILD_DIR)
ifeq ($(shell uname), Darwin)
	brew install llvm 2>/dev/null || true
	$(eval LLVM_DIR := $(shell brew --prefix llvm)/lib/cmake/llvm)
	$(eval Clang_DIR := $(shell brew --prefix llvm)/lib/cmake/clang)
	cmake -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -DLLVM_DIR=\"$(LLVM_DIR)\" -DClang_DIR=\"$(Clang_DIR)\" -S . -B $(BUILD_DIR)
else
	cmake -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -S . -B $(BUILD_DIR)
endif
	cmake --build $(BUILD_DIR) --config $(BUILD_TYPE)

linux:
	@echo \"Building for Linux\"
	cmake -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -S . -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR) --config $(BUILD_TYPE)

macos:
	@echo "Building for macOS"
	brew install llvm 2>/dev/null || true
	cmake -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -DLLVM_DIR="$(shell brew --prefix llvm)/lib/cmake/llvm" -DClang_DIR="$(shell brew --prefix llvm)/lib/cmake/clang" -S . -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR) --config $(BUILD_TYPE)

install:
	cmake --install $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

test: $(BUILD_DIR)/libcodequality
	@echo \"Testing the build...\"
	@ls -la $(BUILD_DIR)/codequality/libcodequality.* 2>/dev/null && echo \"Build successful!\" || (echo \"Build failed!\" && exit 1)