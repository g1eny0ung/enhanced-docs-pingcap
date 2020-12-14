import 'dart:html';

String unifyPathname(String pathname) {
  return pathname.endsWith('/') ? pathname : '$pathname/';
}

void clickOutside(Element el, Function callback) {
  void handler(Event event) {
    if (!el.contains(event.target)) {
      callback();

      document.body.removeEventListener('click', handler);
    }
  }

  document.body.addEventListener('click', handler);
}
