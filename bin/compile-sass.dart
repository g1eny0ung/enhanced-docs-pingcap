import 'dart:io';
import 'package:sass/sass.dart' as sass;

void main(List<String> arguments) {
  File(arguments[1]).writeAsStringSync(sass.compile(arguments[0]));
}
