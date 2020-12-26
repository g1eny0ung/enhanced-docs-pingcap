import 'dart:html';
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart';
import 'list_item.dart';

part 'bookmark_list.over_react.g.dart';

mixin BookmarkListProps on UiProps {
  Map bookmarks;
  dynamic setBookmarks;
}

UiFactory<BookmarkListProps> BookmarkList = uiFunction((props) {
  final bookmarks = props.bookmarks;

  final folded = useState(true);

  void onClick(_) {
    if (folded.value) {
      folded.set(false);

      onClickOutside(
        document.querySelector('.bookmark-list'),
        () => folded.set(true),
      );
    }
  }

  dynamic onItemClick(d) => (_) {
        document.dispatchEvent(CustomEvent('EDP_NAVIGATE', detail: d[0]));
      };

  dynamic onItemRemove(d) => (SyntheticEvent event) {
        final b = bookmarks;

        b.remove(d[0]);

        props.setBookmarks(Map.from(b));
        chrome.storageSyncSet({'bookmarks': b});
      };

  return (Dom.div()..style = {'position': 'relative'})(
    (Dom.div()
      ..className = 'edp-box'
      ..title = 'Bookmarks'
      ..onClick = onClick)(
      (Dom.span()..className = 'icon-list-ul')(),
    ),
    (Dom.div()
      ..className = 'bookmark-list'
      ..style = {'display': folded.value ? 'none' : 'block'})(
      bookmarks.isNotEmpty
          ? bookmarks.entries.map(
              (d) => (ListItem()
                ..data = [d.key, d.value]
                ..onItemClick = onItemClick
                ..onItemRemove = onItemRemove)(),
            )
          : (Dom.div()..className = 'bookmark-list-tooltip')(
              'Click the button in the lower left corner to add the first bookmark.'),
    ),
  );
}, $BookmarkListConfig);
