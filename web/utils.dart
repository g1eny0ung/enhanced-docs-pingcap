import 'dart:html';

String unifyPathname(String pathname) {
  return pathname.endsWith('/') ? pathname : '$pathname/';
}

void onClickOutside(Element el, Function callback) {
  void handler(Event event) {
    if (!el.contains(event.target)) {
      event.stopPropagation();

      callback();

      document.body.removeEventListener('click', handler);
    }
  }

  document.body.addEventListener('click', handler);
}

dynamic detectDocVersion(String pathname) {
  if (pathname.contains('tidb') ||
      pathname.contains('tidb-data-migration') ||
      pathname.contains('tidb-in-kubernetes') ||
      pathname.contains('dev-guide')) {
    final tmp = pathname.startsWith('/zh')
        ? pathname.substring(4)
        : pathname.substring(1);

    return tmp.split('/')[1];
  } else {
    return null;
  }
}
