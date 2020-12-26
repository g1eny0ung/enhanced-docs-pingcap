library chrome;

import 'dart:js';
import 'dart:convert';

// getURL

String getURL(String url) =>
    context['browser']['runtime'].callMethod('getURL', [url]);

// storage

void storageSyncGet(Object items, dynamic key, Function callback) =>
    context['browser']['storage']['sync'].callMethod(
      'get',
      [
        JsObject.jsify(items),
      ],
    ).callMethod(
      'then',
      [
        (items) {
          var f;

          if (key is String) {
            f = json.decode(
              context['JSON'].callMethod('stringify', [items[key]]),
            );
          }

          if (key is List) {
            f = {};

            key.forEach(
              (k) => f[k] = json.decode(
                context['JSON'].callMethod('stringify', [items[k]]),
              ),
            );
          }

          callback(f);
        }
      ],
    );

void storageSyncSet(Object items) =>
    context['browser']['storage']['sync'].callMethod(
      'set',
      [JsObject.jsify(items)],
    );
