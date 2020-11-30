NAME=enhanced-docs-pingcap
PLATFORM=chrome

if [ -n "$1" ]; then
  PLATFORM=$1
fi

RELEASE="${NAME}-${PLATFORM}"

if [ -f "${RELEASE}.zip" ]; then
  rm "${RELEASE}.zip"
fi

zip -r $RELEASE public
