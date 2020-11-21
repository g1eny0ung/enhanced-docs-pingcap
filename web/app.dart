import 'package:over_react/over_react.dart';
import 'bookmark.dart';

part 'app.over_react.g.dart';

mixin AppProps on UiProps {}

UiFactory<AppProps> App = uiFunction((props) {
  return Fragment()(
    Bookmark()(),
  );
}, $AppConfig);
