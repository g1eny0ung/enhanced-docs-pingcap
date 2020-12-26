cp build/packages/react/react_with_react_dom_prod.js public/react_with_react_dom_prod.js
cp build/main.dart.js public/main.dart.js

PLATFORM="chrome"

if [ -n "$1" ]; then
  PLATFORM=$1
fi

if [ "$PLATFORM" = "firefox" ]; then
  cd public && cp -r `ls | grep -v "manifest\|background\|options.js\|iconmoon"` ../firefox && cd ..
fi
