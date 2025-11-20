import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'constants/constants.dart';
import 'screens/screens.dart';
import 'styles/styles.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.uiAppTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppStyles.primaryColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppStyles.backgroundColor,
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppStyles.surfaceColor,
          foregroundColor: AppStyles.textPrimary,
          titleTextStyle: TextStyle(
            fontSize: AppConstants.fontSizeMedium,
            fontWeight: FontWeight.w700,
            color: AppStyles.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => FileBloc()..add(const FileLoadRequested()),
        child: const HomeScreen(),
      ),
    );
  }
}
