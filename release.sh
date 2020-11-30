RELEASE=enhanced-docs-pingcap

if [ -f $RELEASE ]; then
  rm "${RELEASE}.zip"
fi

zip -r $RELEASE public
