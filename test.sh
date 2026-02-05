#!/bin/bash

# Test suite for dvm-default-sandbox Docker image
# Tests all installed languages, runtimes, and tools

set -e  # Exit on first error

FAILED_TESTS=0
PASSED_TESTS=0

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "DVM Default Sandbox - Test Suite"
echo "=========================================="
echo

# Helper functions
pass_test() {
    echo -e "${GREEN}OK${NC} $1"
    PASSED_TESTS=$((PASSED_TESTS + 1))
}

fail_test() {
    echo -e "${RED}FAIL${NC} $1"
    FAILED_TESTS=$((FAILED_TESTS + 1))
}

test_command_exists() {
    if command -v "$1" >/dev/null 2>&1; then
        pass_test "$1 is installed"
        return 0
    else
        fail_test "$1 is not installed"
        return 1
    fi
}

# ----------------------------
# Node.js
echo "Testing Node.js..."
if test_command_exists node; then
    echo "  Version: $(node --version)"
    if node -e "console.log('Hello from Node.js')" >/dev/null 2>&1; then
        pass_test "Node.js executes JavaScript"
    else
        fail_test "Node.js execution failed"
    fi
fi
test_command_exists npm
echo

# ----------------------------
# Bun
echo "Testing Bun..."
if test_command_exists bun; then
    echo "  Version: $(bun --version)"
    if bun -e "console.log('Hello from Bun')" >/dev/null 2>&1; then
        pass_test "Bun executes JavaScript"
    else
        fail_test "Bun execution failed"
    fi
fi
echo

# ----------------------------
# pnpm
echo "Testing pnpm..."
if test_command_exists pnpm; then
    echo "  Version: $(pnpm --version)"
fi
echo

# ----------------------------
# Python
echo "Testing Python..."
if test_command_exists python3; then
    echo "  Version: $(python3 --version)"

    if python3 --version | grep -q "3.11"; then
        pass_test "Python 3.11 detected"
    else
        fail_test "Python version is not 3.11"
    fi

    if python3 -c "print('Hello from Python')" >/dev/null 2>&1; then
        pass_test "Python executes code"
    else
        fail_test "Python execution failed"
    fi
fi
test_command_exists pip3
echo

# ----------------------------
# Python packages
echo "Testing Python packages..."
PYTHON_PACKAGES="numpy pandas scipy matplotlib sklearn jupyter seaborn plotly requests bs4"

for pkg in $PYTHON_PACKAGES; do
    if python3 -c "import $pkg" >/dev/null 2>&1; then
        pass_test "Python package $pkg importable"
    else
        fail_test "Python package $pkg missing"
    fi
done
echo

# ----------------------------
# Go
echo "Testing Go..."
if test_command_exists go; then
    echo "  Version: $(go version)"

    mkdir -p /tmp/go-test
    cat > /tmp/go-test/hello.go << EOF
package main
import "fmt"
func main() {
    fmt.Println("Hello from Go")
}
EOF

    if (cd /tmp/go-test && go run hello.go >/dev/null 2>&1); then
        pass_test "Go compiles and runs"
    else
        fail_test "Go execution failed"
    fi

    rm -rf /tmp/go-test
fi
echo

# ----------------------------
# TypeScript
echo "Testing TypeScript..."
if test_command_exists tsc; then
    echo "  Version: $(tsc --version)"

    mkdir -p /tmp/ts-test
    cat > /tmp/ts-test/hello.ts << EOF
const greeting: string = "Hello from TypeScript";
console.log(greeting);
EOF

    if (cd /tmp/ts-test && tsc hello.ts >/dev/null 2>&1); then
        pass_test "TypeScript compiles"

        if node /tmp/ts-test/hello.js >/dev/null 2>&1; then
            pass_test "Compiled TypeScript runs"
        else
            fail_test "Compiled JS failed"
        fi
    else
        fail_test "TypeScript compilation failed"
    fi

    rm -rf /tmp/ts-test
fi
echo

# ----------------------------
# ffmpeg
echo "Testing ffmpeg..."
if test_command_exists ffmpeg; then
    echo "  Version: $(ffmpeg -version | head -n 1)"
    pass_test "ffmpeg responds"
fi
echo

# ----------------------------
# System tools
echo "Testing system tools..."
test_command_exists git
test_command_exists curl
test_command_exists wget
test_command_exists gcc
test_command_exists g++
test_command_exists make
echo

# ----------------------------
# Environment
echo "Testing environment..."
if [ -n "$GOPATH" ]; then
    pass_test "GOPATH is set"
else
    fail_test "GOPATH is not set"
fi
echo

# ----------------------------
# Summary
echo "=========================================="
echo "Test Results Summary"
echo "=========================================="
echo "Passed: $PASSED_TESTS"
echo "Failed: $FAILED_TESTS"
echo

if [ "$FAILED_TESTS" -eq 0 ]; then
    echo "All tests passed"
    exit 0
else
    echo "Some tests failed"
    exit 1
fi
