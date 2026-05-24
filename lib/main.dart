import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/mobile/main_screen.dart';
import 'screens/tv/tv_main_screen.dart';
import 'utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const StreamViewApp());
}

class StreamViewApp extends StatelessWidget {
  const StreamViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamView IPTV',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: _buildHomeScreen(context),
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTV = screenSize.width > 600 && screenSize.height > 400;

    if (isTV) {
      return const TVMainScreen();
    }
    return const MainScreen();
  }
}
