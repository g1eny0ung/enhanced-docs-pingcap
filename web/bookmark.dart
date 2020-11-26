import 'dart:html';
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart';

part 'bookmark.over_react.g.dart';

mixin BookmarkProps on UiProps {
  StateHook<Map> favorites;
}

UiFactory<BookmarkProps> Bookmark = uiFunction((props) {
  final pathname = window.location.pathname;
  final _favorites = props.favorites.value;

  final marked = useState(false);

  useEffect(() {
    window.onClick.listen((event) {
      final t = event.target as Element;
      final type = t.tagName;

      if (type == 'A' && !t.getAttribute('href').startsWith('#')) {
        marked
            .set(_favorites.containsKey(unifyPathname(t.getAttribute('href'))));
      }
    });
  }, []);

  useEffect(() {
    marked.set(_favorites.containsKey(unifyPathname(pathname)));
  }, [_favorites]);

  void handleMark(_) {
    final isMarked = marked.value;
    final f = _favorites;
    final k = unifyPathname(pathname);

    marked.set(!isMarked);

    if (isMarked) {
      f.remove(k);
    } else {
      final title = document.title.split(' | ')[0];

      f[k] = title;
    }

    props.favorites.set(f);
    chrome.storageSyncSet({'favorites': f});
  }

  return (Dom.div()
    ..className = 'edp-box'
    ..onClick = handleMark)(
    (Dom.span()
      ..className =
          '${marked.value ? 'icon-bookmark marked' : 'icon-bookmark-o'} bookmark')(),
  );
}, $BookmarkConfig);
