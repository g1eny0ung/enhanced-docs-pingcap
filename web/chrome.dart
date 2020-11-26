library chrome;

import 'dart:js';
import 'dart:convert';

// storage

void storageSyncGet(Object items, Function callback) =>
    context['chrome']['storage']['sync'].callMethod(
      'get',
      [
        JsObject.jsify(items),
        (items) {
          final f = json.decode(
            context['JSON'].callMethod('stringify', [items['favorites']]),
          );

          callback(f);
        }
      ],
    );

void storageSyncSet(Object items) =>
    context['chrome']['storage']['sync'].callMethod(
      'set',
      [JsObject.jsify(items)],
    );
