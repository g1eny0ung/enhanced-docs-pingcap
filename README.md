> **Since I no longer work for PingCAP and the current documentation site has been updated a lot, I decided to remove the plugin and archive this repository.**

# Enhanced PingCAP Docs

> Browser extension that puts wings on PingCAP Docs.

## Browsers support

| <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/chrome/chrome_48x48.png" alt="Chrome" width="24px" height="24px" /><br />Chrome | <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/firefox/firefox_48x48.png" alt="Firefox" width="24px" height="24px" /><br />Firefox |
| :-: | :-: |
| [Web Store](https://chrome.google.com/webstore/detail/enhanced-pingcap-docs/gmlnojpblggphjoccipabhkgdlnppdid) | [ADD-ONS](https://addons.mozilla.org/en-US/firefox/addon/enhanced-pingcap-docs) |

Currently, this plugin has the following features:

- **Bookmarks support**

  This allows you to bookmark the page for viewing later.

- **History support**

  Record document browsing history, 5 records by default.

- **Lang switch**

  Shortcut for switch between Chinese and English documents.

  Default:

  - Chrome: `Alt+S`
  - Firefox: `Alt+W`

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
    "build": "dart pub global run webdev build",
    "sass": "dart bin/compile-sass.dart styles/app.sass public/app.css",
    "bundle:chrome": "yarn build && ./bundle.sh && yarn sass",
    "bundle:firefox": "yarn build && ./bundle.sh firefox && yarn sass",
    "release:chrome": "yarn bundle:chrome && ./release.sh",
    "release:firefox": "yarn bundle:firefox && ./release.sh firefox"
  }
}
```

For example, get dependencies first:

```sh
yarn deps
```

Build `*.dart` to js:

```sh
yarn build
```

Compile sass:

```sh
yarn sass
```

Bundle all production files to `public` dir (for Chrome):

```sh
yarn bundle:chrome
```

### Preview changes

#### Chrome

Run the `bundle:chrome` script and then load the `public` dir in `chrome://extensions`.

After making new changes, just run the script again and then go back to the extensions page and click the `reload` button.

#### Firefox

You can use [web-ext](https://github.com/mozilla/web-ext) to help develop extensions in Firefox.

Run `npm install web-ext -g` to install it.

Here is an example that develops this extension in the firefox developer edition.

```sh
yarn bundle:firefox
web-ext run -s firefox -f firefoxdeveloperedition
```

After making new changes, just run `yarn bundle:firefox` again and then the web-ext will reload it automatically.

## License

MIT.
