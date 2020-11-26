import 'package:over_react/over_react.dart';

part 'bookmark_list.over_react.g.dart';

mixin BookmarkListProps on UiProps {
  Map favorites;
}

UiFactory<BookmarkListProps> BookmarkList = uiFunction((props) {
  final folded = useState(true);

  void onClick(_) {
    folded.set(!folded.value);
  }

  ReactElement renderListItem(d) => (Dom.div()
    ..key = d.key + '|' + d.value
    ..className = 'edp-list-item')(d.value);

  return (Dom.div()
    ..className = 'edp-box'
    ..onClick = onClick)(
    (Dom.span()..className = 'icon-list-ul')(),
    (Dom.div()
      ..className = 'bookmark-list'
      ..style = {
        'display': folded.value ? 'none' : 'block'
      })(props.favorites.entries.map(renderListItem)),
  );
}, $BookmarkListConfig);
