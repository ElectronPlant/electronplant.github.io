#!/usr/bin/env bash
# ==============================================================================
# Script Name:  prepare_print.sh
# Description:  Prepares the MkDocs page to generate a printable CV.
# Author:       David Arnaiz
# Date:         2026-07-25
# Version:      1.0
# Usage:        ./prepare_print.sh
# ==============================================================================

set -e
set -u
set -o pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
INPUT_DIR="../../docs"
INDEX_RELATIVE_PATH="$INPUT_DIR/index.md"
EXTRA_COPY=("./extra_style.css" "$INPUT_DIR/assets")
OUTPUT_DIR="./build"
OUTPUT_INDEX_PATH="$OUTPUT_DIR/index.md"
SKIP_START="<!-- print skip start -->"
SKIP_END="<!-- print skip end -->"
PRINT_ONLY_START="<!-- print only start"
PRINT_ONLY_END="print only end -->"


cd -- "$SCRIPT_DIR" || exit 1
if [ -d "$OUTPUT_DIR" ]; then rm -r "$OUTPUT_DIR"; fi
mkdir "$OUTPUT_DIR"
awk -v start="$SKIP_START" -v end="$SKIP_END" -v skip1="$PRINT_ONLY_START" -v skip2="$PRINT_ONLY_END" '
    index($0, start) { skip=1; next }
    index($0, end)   { skip=0; next }
    index($0, skip1) {next}
    index($0, skip2) {next}
    !skip
' "$INDEX_RELATIVE_PATH" > "$OUTPUT_INDEX_PATH"
for c in $EXTRA_COPY
do
    cp "$c" "$OUTPUT_DIR"
done

mkdocs serve -f mkdocs_print.yml
