NAME="enhanced-docs-pingcap"
PLATFORM="chrome"
SOURCE="public"

if [ -n "$1" ]; then
  PLATFORM=$1
fi

if [ "$PLATFORM" = "firefox" ]; then
  SOURCE=firefox
fi

RELEASE="${NAME}-${PLATFORM}"

if [ -f "${RELEASE}.zip" ]; then
  rm "${RELEASE}.zip"
fi

cd $SOURCE
zip -r "../$RELEASE" * -x *.DS_Store
cd ..
