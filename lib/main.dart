import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/app_constants.dart';
import 'screens/calculator_screen.dart';

/// The entry point of the Flutter application.
void main() {
  // Ensure that plugin services are initialized before we use them (like SystemChrome).
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure the look of the system status bar and navigation bar.
  // This helps the app look seamless with the system UI.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.background,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  
  // Start the Flutter app.
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the "debug" banner in the corner.
      title: AppStrings.appTitle,
      
      // Global theme configuration using Material 3.
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        
        // Customizing the AppBar globally.
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          elevation: 0,
          centerTitle: true,
        ),
        
        // Customizing the color scheme for consistency.
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
      ),
      
      // The first screen that will be shown.
      home: const CalculatorScreen(),
    );
  }
}
