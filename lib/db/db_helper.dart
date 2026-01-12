// Conditional export: use sqflite implementation on non-web, and shared_preferences on web.
export 'db_helper_mobile.dart' if (dart.library.html) 'db_helper_web.dart';
