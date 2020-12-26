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
  final listRef = useRef(list.value);

  void retrieveHistory() =>
      chrome.storageSyncGet({'history': []}, 'history', list.set);

  void updateList(dynamic location) {
    Timer(
      Duration(seconds: 1),
      () {
        final l = listRef.current;
        final pathname = unifyPathname(location['pathname']);

        if (l.isNotEmpty &&
            l.singleWhere((d) => d[0] == pathname, orElse: () => null) !=
                null) {
          return;
        }

        final updated = [
          ...(l.length == 5 ? l.skip(1) : l),
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
      ..className = 'edp-box edp-list-item history-list-item')(
      (Dom.div()
        ..title = d[0]
        ..onClick = onItemClick(d))(
        [
          (Dom.span()..className = 'meta')(
            d[0].startsWith('/zh') ? 'zh' : 'en',
          ),
          if (version != null)
            (Dom.span()..className = 'meta')(
              version,
            ),
          Dom.span()(d[1]),
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
