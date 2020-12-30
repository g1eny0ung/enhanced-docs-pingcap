import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart';
import 'list_item.dart';

part 'history_list.over_react.g.dart';

mixin HistoryListProps on UiProps {}

UiFactory<HistoryListProps> HistoryList = uiFunction((props) {
  final bodyWidth75 = (document.body.clientWidth * .75).round();

  final list = useState([]);
  final historyNum = useRef(5);
  final listRef = useRef(list.value);

  void retrieveHistory() {
    chrome.storageSyncGet(
      {
        'history': [],
        'historyNum': '5',
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

  return Fragment()(
    list.value.map(
      (d) => (ListItem()
        ..data = d
        ..onItemClick = onItemClick
        ..onItemRemove = onItemRemove
        ..className = 'edp-box history-list-item'
        ..contentStyle = {
          'maxWidth': max((bodyWidth75 / list.value.length - 100).round(), 16),
        })(),
    ),
  );
}, $HistoryListConfig);
