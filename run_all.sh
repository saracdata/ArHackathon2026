#!/usr/bin/env bash
# Run every practice test case against the student routing.py and collect
# all output into a single log file: results/run_all.log
set -u

cd "$(dirname "$0")"

# Make the package importable even if `pip install -e .` was not run for
# this python3.
export PYTHONPATH="${PYTHONPATH:-}:."

mkdir -p results
log="results/run_all.log"
: > "$log"   # truncate

{
    echo "Run started: $(date)"
    echo
    for test_case in test_cases/level*/*.json; do
        echo "=========================================="
        echo "Running: $test_case"
        echo "=========================================="
        python3 scripts/run_game.py "$test_case" 2>&1
        echo
    done
    echo "Run finished: $(date)"
} | tee "$log"

echo
echo "Summary:"
grep -E "^(Running:|Score:|Delivered)" "$log"
echo
echo "Full output saved to $log"
