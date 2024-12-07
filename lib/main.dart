import 'package:f290_ldmp_web_desktop_playground/src/features/home/presentation/view_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await dotenv.load(fileName: 'web/.env');
 await Supabase.initialize(
 url: dotenv.get('SB_URL'),
 anonKey: dotenv.get('SB_ANON_KEY'),
 );

 runApp(const App());
}