NAME="enhanced-docs-pingcap"
PLATFORM="chrome"
SOURCE="public"

if [ -n "$1" ]; then
  PLATFORM=$1
fi

if [ "$PLATFORM" = "firefox" ]; then
  SOURCE=firefox
  cd public && cp -r `ls | grep -v "manifest\|background\|iconmoon"` ../firefox && cd ..
fi

RELEASE="${NAME}-${PLATFORM}"

if [ -f "${RELEASE}.zip" ]; then
  rm "${RELEASE}.zip"
fi

cd $SOURCE
zip -r "../$RELEASE" * -x *.DS_Store
cd ..
