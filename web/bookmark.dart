import 'dart:html';
import 'dart:convert';
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart';

part 'bookmark.over_react.g.dart';

mixin BookmarkProps on UiProps {
  Map bookmarks;
  dynamic setBookmarks;
}

UiFactory<BookmarkProps> Bookmark = uiFunction((props) {
  final bookmarks = props.bookmarks;

  final bookmarksRef = useRef(bookmarks);
  final marked = useState(false);

  void updateMarkedByPathname(String pathname) =>
      marked.set(bookmarksRef.current.containsKey(unifyPathname(pathname)));

  void init() {
    final s = document.createElement('script');

    s.setAttribute('src', chrome.getURL('inject.js'));
    document.body.append(s);
    s.onLoad.listen((_) => s.remove());

    document.addEventListener('PASS_LOCATION_TO_EDP', (dynamic event) {
      final location = json.decode(event.detail);

      updateMarkedByPathname(location['pathname']);
    });
  }

  useEffect(() {
    init();
  }, []);

  useEffect(() {
    bookmarksRef.current = bookmarks;

    updateMarkedByPathname(window.location.pathname);
  }, [bookmarks]);

  void handleMark(_) {
    final isMarked = marked.value;
    final b = bookmarks;
    final k = unifyPathname(window.location.pathname);

    if (isMarked) {
      b.remove(k);
    } else {
      final title = document.title.split(' | ')[0];

      b[k] = title;
    }

    props.setBookmarks(
        Map.from(b)); // A new object must be created to ensure the re-rendering
    chrome.storageSyncSet({'bookmarks': b});
  }

  return Dom.div()(
    (Dom.div()
      ..className = 'edp-box'
      ..title = 'Add to Bookmarks'
      ..onClick = handleMark)(
      (Dom.span()
        ..className =
            '${marked.value ? 'icon-bookmark marked' : 'icon-bookmark-o'} bookmark')(),
    ),
  );
}, $BookmarkConfig);
