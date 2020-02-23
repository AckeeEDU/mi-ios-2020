#!/bin/sh

# This script is supposed to be called from build pre-action to generate values to preprocess Info.plist file

cd "$PROJECT_DIR"

COMMITS=`git rev-list HEAD --count`

echo "// Auto-generated" > "$INFOPLIST_PREFIX_HEADER"
echo "" >> "$INFOPLIST_PREFIX_HEADER"
echo "#define BUILD_NUMBER $COMMITS" >> "$INFOPLIST_PREFIX_HEADER"

# touch plist file so "fake" change is generated and Xcode is forced to preprocess plist again
touch $INFOPLIST_FILE

cd -