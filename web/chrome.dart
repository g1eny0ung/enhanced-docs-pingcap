@JS('chrome')
library chrome;

import 'package:js/js.dart';

// storage

@JS('storage.sync.get')
external void storageSyncGet(StorageObjectLiteral items, Function callback);

@JS('storage.sync.set')
external void storageSyncSet(StorageObjectLiteral items);

@JS()
@anonymous
class StorageObjectLiteral {
  external Map<String, String> get favorites;

  external factory StorageObjectLiteral({
    Map<String, String> favorites,
  });
}
