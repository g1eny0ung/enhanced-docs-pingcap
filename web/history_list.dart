import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart';

part 'history_list.over_react.g.dart';

mixin HistoryListProps on UiProps {}

UiFactory<HistoryListProps> HistoryList = uiFunction((props) {
  final list = useState([]);
  final historyNum = useRef(0);
  final listRef = useRef(list.value);

  void retrieveHistory() {
    chrome.storageSyncGet(
      {
        'history': [],
        'historyNum': 5,
      },
      [
        'history',
        'historyNum',
      ],
      (f) {
        final historyLength = f['history'].length;
        final num = int.parse(f['historyNum']);

        list.set(historyLength > num
            ? f['history'].sublist(historyLength - num)
            : f['history']);
        historyNum.current = num;
      },
    );
  }

  void updateList(dynamic location) {
    Timer(
      Duration(seconds: 1),
      () {
        var l = listRef.current;
        final pathname = unifyPathname(location['pathname']);

        if (l.isNotEmpty) {
          l.removeWhere((d) => d[0] == pathname);
        }

        final updated = [
          ...(l.length == historyNum.current ? l.skip(1) : l),
          [pathname, document.title.split(' | ')[0]]
        ];

        list.set(updated);
        chrome.storageSyncSet({'history': updated});
      },
    );
  }

  void init() {
    retrieveHistory();

    document.addEventListener('PASS_LOCATION_TO_EDP', (dynamic event) {
      final location = json.decode(event.detail);

      updateList(location);
    });
  }

  useEffect(() {
    init();
  }, []);

  useEffect(() {
    listRef.current = list.value;
  }, [list.value]);

  dynamic onItemClick(d) => (_) {
        document.dispatchEvent(CustomEvent('EDP_NAVIGATE', detail: d[0]));
      };

  dynamic onItemRemove(d) => (SyntheticEvent event) {
        final updated = list.value.where((item) => item[0] != d[0]).toList();

        list.set(updated);
        chrome.storageSyncSet({'history': updated});
      };

  ReactElement renderListItem(d) {
    final version = detectDocVersion(d[0]);

    return (Dom.div()
      ..key = d[0]
      ..className = 'edp-box edp-list-item history-list-item'
      ..title = d[1])(
      (Dom.div()..onClick = onItemClick(d))(
        [
          (Dom.span()..className = 'meta')(
            d[0].startsWith('/zh') ? 'zh' : 'en',
          ),
          if (version != null)
            (Dom.span()..className = 'meta')(
              version,
            ),
          (Dom.span()..className = 'content')(d[1]),
        ],
      ),
      (Dom.span()
        ..className = 'close icon-close'
        ..title = 'Remove'
        ..onClick = onItemRemove(d))(),
    );
  }

  return Fragment()(
    list.value.map(renderListItem),
  );
}, $HistoryListConfig);
