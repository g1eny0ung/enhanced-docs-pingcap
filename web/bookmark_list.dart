import 'dart:html';
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart';

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
      clickOutside(
        document.querySelector('.bookmark-list'),
        () => folded.set(true),
      );
    }

    folded.set(!folded.value);
  }

  dynamic onItemClick(d) => (_) {
        document.dispatchEvent(CustomEvent('EDP_NAVIGATE', detail: d.key));
      };

  dynamic onItemRemove(d) => (SyntheticEvent event) {
        final b = bookmarks;

        b.remove(d.key);

        props.setBookmarks(Map.from(b));
        chrome.storageSyncSet({'bookmarks': b});
      };

  ReactElement renderListItem(d) => (Dom.div()
        ..key = d.key
        ..className = 'edp-list-item')(
        (Dom.div()
          ..title = d.key
          ..onClick = onItemClick(d))(d.value),
        (Dom.span()
          ..className = 'close icon-close'
          ..title = 'Remove'
          ..onClick = onItemRemove(d))(),
      );

  return (Dom.div()..style = {'position': 'relative'})(
      (Dom.div()
        ..className = 'edp-box'
        ..title = 'Bookmarks'
        ..onClick = onClick)(
        (Dom.span()..className = 'icon-list-ul')(),
      ),
      (Dom.div()
        ..className = 'bookmark-list'
        ..style = {'display': folded.value ? 'none' : 'block'})(bookmarks
              .isNotEmpty
          ? bookmarks.entries.map(renderListItem)
          : (Dom.div()..className = 'bookmark-list-tooltip')(
              'Click the button in the lower left corner to add the first bookmark.')));
}, $BookmarkListConfig);
