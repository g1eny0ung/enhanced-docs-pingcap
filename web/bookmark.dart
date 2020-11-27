import 'dart:html';
import 'dart:convert';
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart';

part 'bookmark.over_react.g.dart';

mixin BookmarkProps on UiProps {
  StateHook<Map> favorites;
}

UiFactory<BookmarkProps> Bookmark = uiFunction((props) {
  final _favorites = props.favorites.value;

  final _favoritesRef = useRef(_favorites);
  final marked = useState(false);

  void updateMarkedByPathname(String pathname) =>
      marked.set(_favoritesRef.current.containsKey(unifyPathname(pathname)));

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
    _favoritesRef.current = _favorites;

    updateMarkedByPathname(window.location.pathname);
  }, [_favorites]);

  void handleMark(_) {
    final isMarked = marked.value;
    final f = _favorites;
    final k = unifyPathname(window.location.pathname);

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
