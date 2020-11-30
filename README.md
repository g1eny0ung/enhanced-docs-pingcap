# Enhanced docs.pingcap

> Browser extension that puts wings on PingCAP Docs.

## Browsers support

| <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/chrome/chrome_48x48.png" alt="Chrome" width="24px" height="24px" /><br />Chrome |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                          [Link](https://chrome.google.com/webstore/detail/enhanced-pingcap-docs/gmlnojpblggphjoccipabhkgdlnppdid)                          |

Currently, this plugin has the following features:

- **Bookmarks support**

  This allows you to bookmark the page for viewing later.

- **History support**

  Record document browsing history, currently record 5 items at most.

## How to development

> Make sure that the Dart SDK was installed. You can also use the Dart SDK bundled with Flutter.
>
> For more installation details, check:
>
> <https://dart.dev/get-dart>
>
> <https://flutter.dev/docs/get-started/install>
>
> It's needed to use the **stable channel versions** because some dependencies haven't supported the feature of [null safety](https://medium.com/dartlang/announcing-dart-null-safety-beta-87610fee6730) for now.

### Global dependencies

Install [webdev](https://pub.dev/packages/webdev):

> Must install version **2.6.2** because of dependency constraints.

```sh
dart pub global activate webdev 2.6.2
```

### Scripts

Some useful commands were defined in `package.json` so that you can use `npm` or `yarn` to exec it.

```json
{
  "scripts": {
    "deps": "dart pub get",
    "serve": "dart pub global run webdev serve",
    "build": "dart pub global run webdev build",
    "sass": "dart bin/compile-sass.dart styles/app.sass public/app.css",
    "bundle": "yarn build && ./bundle.sh && yarn sass"
  }
}
```

For example, get dependencies:

```sh
yarn deps
```

Build to js:

```sh
yarn build
```

Compile sass:

```sh
yarn sass
```

Bundle all production files to `public` dir:

```sh
yarn bundle
```

### Preview changes

Run the `bundle` script and load the `public` dir in [chrome://extensions](chrome://extensions).

## License

MIT.
