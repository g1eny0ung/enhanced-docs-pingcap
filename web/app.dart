import 'package:over_react/over_react.dart';
import 'bookmark.dart';
import 'bookmark_list.dart';

part 'app.over_react.g.dart';

mixin AppProps on UiProps {}

UiFactory<AppProps> App = uiFunction((props) {
  return (Dom.div()..className = 'edp-container')(
    Bookmark()(),
    BookmarkList()(),
  );
}, $AppConfig);
