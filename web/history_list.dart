import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'package:over_react/over_react.dart';
import 'utils.dart' show unifyPathname;

part 'history_list.over_react.g.dart';

mixin HistoryListProps on UiProps {}

UiFactory<HistoryListProps> HistoryList = uiFunction((props) {
  final list = useState([]);
  final listRef = useRef(list.value);

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

        list.set([
          ...l,
          [pathname, document.title.split(' | ')[0]]
        ]);
      },
    );
  }

  void init() {
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
        final l = list.value;

        list.set(l.where((item) => item[0] != d[0]).toList());
      };

  return Fragment()(list.value.map((d) => (Dom.div()
        ..key = d[0]
        ..className = 'edp-box edp-list-item history-list-item')(
        (Dom.div()
          ..title = d[0]
          ..onClick = onItemClick(d))(d[1]),
        (Dom.span()
          ..className = 'close icon-close'
          ..title = 'Remove'
          ..onClick = onItemRemove(d))(),
      )));
}, $HistoryListConfig);
