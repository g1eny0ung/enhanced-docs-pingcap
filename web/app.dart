import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'bookmark.dart';
import 'bookmark_list.dart';
import 'history_list.dart';

part 'app.over_react.g.dart';

mixin AppProps on UiProps {}

UiFactory<AppProps> App = uiFunction((props) {
  final bookmarks = useState<Map>({});

  void retrieveBookmarks() =>
      chrome.storageSyncGet({'bookmarks': {}}, 'bookmarks', bookmarks.set);

  useEffect(() {
    retrieveBookmarks();
  }, []);

  return (Dom.div()..className = 'edp-container')(
    (Bookmark()
      ..bookmarks = bookmarks.value
      ..setBookmarks = bookmarks.set)(),
    (BookmarkList()
      ..bookmarks = bookmarks.value
      ..setBookmarks = bookmarks.set)(),
    HistoryList()(),
  );
}, $AppConfig);
