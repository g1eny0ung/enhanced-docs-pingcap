library chrome;

import 'dart:js';
import 'dart:convert';

// getURL

String getURL(String url) =>
    context['browser']['extension'].callMethod('getURL', [url]);

// storage

void storageSyncGet(Object items, String key, Function callback) =>
    context['browser']['storage']['sync'].callMethod(
      'get',
      [
        JsObject.jsify(items),
      ],
    ).callMethod(
      'then',
      [
        (items) {
          final f = json.decode(
            context['JSON'].callMethod('stringify', [items[key]]),
          );

          callback(f);
        }
      ],
    );

void storageSyncSet(Object items) =>
    context['browser']['storage']['sync'].callMethod(
      'set',
      [JsObject.jsify(items)],
    );
