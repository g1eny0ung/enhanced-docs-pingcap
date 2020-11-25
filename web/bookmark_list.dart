import 'dart:collection';
import 'dart:js';
import 'package:js/js.dart';
import 'package:node_interop/util.dart' show dartify;
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart' show parseFavorites;

part 'bookmark_list.over_react.g.dart';

mixin BookmarkListProps on UiProps {}

UiFactory<BookmarkListProps> BookmarkList = uiFunction((props) {
  final folded = useState(true);
  final favorites = useState<LinkedHashMap>(null);

  void updateFavorites() => chrome.storageSyncGet(
        chrome.StorageObjectLiteral(
          favorites: {},
        ),
        allowInterop((items) {
          final f = dartify(items.favorites);
          parseFavorites(f);

          favorites.set(f);
        }),
      );

  useEffect(() {
    updateFavorites();
  }, []);

  void onClick(_) {
    folded.set(!folded.value);

    updateFavorites();
  }

  ReactElement renderListItem(d) =>
      (Dom.div()..key = d.key + '|' + d.value)(d.value);

  return (Dom.div()..className = 'edp-box')(
    (Dom.span()
      ..className = 'icon-list-ul'
      ..onClick = onClick)(),
    (Dom.div()
          ..className = 'bookmark-list'
          ..style = {'display': folded.value ? 'none' : 'block'})(
        favorites.value != null
            ? favorites.value.entries.map(renderListItem)
            : null),
  );
}, $BookmarkListConfig);
