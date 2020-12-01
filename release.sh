NAME="enhanced-docs-pingcap"
PLATFORM="chrome"
LIST="public"

if [ -n "$1" ]; then
  PLATFORM=$1
fi

if [ "$PLATFORM" = "firefox" ]; then
  LIST=firefox
  cd public && cp -r `ls | grep -v "manifest\|background\|iconmoon"` ../firefox && cd ..
fi

RELEASE="${NAME}-${PLATFORM}"

if [ -f "${RELEASE}.zip" ]; then
  rm "${RELEASE}.zip"
fi

zip -r $RELEASE $LIST
