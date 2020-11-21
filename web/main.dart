import 'dart:html';
import 'package:over_react/react_dom.dart' as react_dom;
import 'app.dart';

void main() {
  final app = DivElement();
  app.id = 'enhanced-docs-pingcap-app';

  document.body.append(app);

  react_dom.render(App()(), querySelector('#' + app.id));
}
