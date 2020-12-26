import 'package:over_react/over_react.dart';
import 'utils.dart';

part 'list_item.over_react.g.dart';

mixin ListItemProps on UiProps {
  List data;
  dynamic onItemClick;
  dynamic onItemRemove;
  Map<String, dynamic> contentStyle;
}

UiFactory<ListItemProps> ListItem = uiFunction((props) {
  final d = props.data;
  final version = detectDocVersion(d[0]);

  return (Dom.div()
    ..key = d[0]
    ..className =
        'edp-list-item${props.className != null ? ' ${props.className}' : ''}'
    ..title = d[0] + ' ' + d[1])(
    (Dom.div()..onClick = props.onItemClick(d))(
      [
        (Dom.span()..className = 'meta')(
          d[0].startsWith('/zh') ? 'zh' : 'en',
        ),
        if (version != null)
          (Dom.span()..className = 'meta')(
            version,
          ),
        (Dom.span()
          ..className = 'content'
          ..style = props.contentStyle)(d[1]),
      ],
    ),
    (Dom.span()
      ..className = 'close icon-close'
      ..title = 'Remove'
      ..onClick = props.onItemRemove(d))(),
  );
}, $ListItemConfig);
