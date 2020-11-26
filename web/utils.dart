String unifyPathname(String pathname) {
  return pathname.endsWith('/') ? pathname : '$pathname/';
}
