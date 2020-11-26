import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'bookmark.dart';
import 'bookmark_list.dart';

part 'app.over_react.g.dart';

mixin AppProps on UiProps {}

UiFactory<AppProps> App = uiFunction((props) {
  final favorites = useState<Map>({});

  void retrieveFavorites() =>
      chrome.storageSyncGet({'favorites': {}}, favorites.set);

  useEffect(() {
    retrieveFavorites();
  }, []);

  return (Dom.div()..className = 'edp-container')(
    (Bookmark()..favorites = favorites)(),
    (BookmarkList()..favorites = favorites.value)(),
  );
}, $AppConfig);
