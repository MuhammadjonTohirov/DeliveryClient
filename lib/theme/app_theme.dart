import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_client/utils/constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kNeutralWhiteColor,
      colorScheme: const ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kSecondaryBlueColor,
        error: kErrorColor,
        surface: kNeutralWhiteColor,
        onPrimary: kNeutralWhiteColor,
        onSecondary: kNeutralWhiteColor,
        onSurface: kNeutralDarkGrayColor,
        onError: kNeutralWhiteColor,
        brightness: Brightness.light,
        // Additional colors from your palette
        tertiary: kPrimaryRedColor, // Example: using primary red as tertiary
        onTertiary: kNeutralWhiteColor,
        surfaceVariant: kNeutralLightGrayColor, // For card backgrounds etc.
        outline: kNeutralLightGrayColor, // Borders
        shadow: kNeutralDarkGrayColor, // Shadows
        inversePrimary: kPrimaryColor, // For specific cases
      ),
      appBarTheme: AppBarTheme(
        color: kPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralWhiteColor),
        titleTextStyle: GoogleFonts.lato(
          fontSize: kFontSizeSubheader,
          fontWeight: FontWeight.w600,
          color: kNeutralWhiteColor,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lato(
          fontSize: kFontSizeHeaderLarge,
          fontWeight: FontWeight.bold,
          color: kNeutralDarkGrayColor,
        ), // H1
        displayMedium: GoogleFonts.lato(
          fontSize: kFontSizeHeader,
          fontWeight: FontWeight.bold,
          color: kNeutralDarkGrayColor,
        ), // H2
        displaySmall: GoogleFonts.lato(
          fontSize: kFontSizeSubheaderLarge,
          fontWeight: FontWeight.bold,
          color: kNeutralDarkGrayColor,
        ), // H3
        headlineMedium: GoogleFonts.lato(
          fontSize: kFontSizeSubheader,
          fontWeight: FontWeight.w600,
          color: kNeutralDarkGrayColor,
        ), // H4 / Subheader
        headlineSmall: GoogleFonts.lato(
          fontSize: kFontSizeBodyLarge,
          fontWeight: FontWeight.w600,
          color: kNeutralDarkGrayColor,
        ), // H5
        titleLarge: GoogleFonts.lato(
          fontSize: kFontSizeBody,
          fontWeight: FontWeight.w600,
          color: kNeutralDarkGrayColor,
        ), // H6 / Card Titles
        bodyLarge: GoogleFonts.lato(
          fontSize: kFontSizeBodyLarge,
          fontWeight: FontWeight.normal,
          color: kNeutralDarkGrayColor,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: kFontSizeBody,
          fontWeight: FontWeight.normal,
          color: kNeutralDarkGrayColor,
        ),
        bodySmall: GoogleFonts.lato(
          fontSize: kFontSizeCaption,
          fontWeight: FontWeight.normal,
          color: kNeutralDarkGrayColor,
        ),
        labelLarge: GoogleFonts.lato(
          fontSize: kFontSizeButton,
          fontWeight: FontWeight.w500,
          color: kNeutralWhiteColor,
        ), // Button text
        labelMedium: GoogleFonts.lato(
          fontSize: kFontSizeCaption,
          fontWeight: FontWeight.w500,
          color: kNeutralDarkGrayColor,
        ),
        labelSmall: GoogleFonts.lato(
          fontSize: kFontSizeCaption,
          fontWeight: FontWeight.w300,
          color: kNeutralDarkGrayColor,
        ), // Captions light
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadiusButton)),
        buttonColor: kPrimaryColor,
        textTheme: ButtonTextTheme.primary,
        height: kButtonHeight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: kNeutralWhiteColor,
          minimumSize: const Size(double.infinity, kButtonHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadiusButton)),
          textStyle: GoogleFonts.lato(fontSize: kFontSizeButton, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor,
          textStyle: GoogleFonts.lato(fontSize: kFontSizeBody, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: const BorderSide(color: kNeutralLightGrayColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: const BorderSide(color: kNeutralLightGrayColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: const BorderSide(color: kErrorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: const BorderSide(color: kErrorColor, width: 1.5),
        ),
        labelStyle: GoogleFonts.lato(color: kNeutralDarkGrayColor.withOpacity(0.7)),
        hintStyle: GoogleFonts.lato(color: kNeutralDarkGrayColor.withOpacity(0.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.9),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadiusStandard)),
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 4),
        color: kNeutralWhiteColor,
      ),
      iconTheme: const IconThemeData(color: kNeutralDarkGrayColor, size: 24.0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: kNeutralWhiteColor,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kNeutralDarkGrayColor.withOpacity(0.6),
        selectedLabelStyle: GoogleFonts.lato(fontSize: kFontSizeCaption, fontWeight: FontWeight.w500),
        unselectedLabelStyle: GoogleFonts.lato(fontSize: kFontSizeCaption, fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: kNeutralLightGrayColor,
        selectedColor: kPrimaryColor,
        labelStyle: GoogleFonts.lato(color: kNeutralDarkGrayColor, fontSize: kFontSizeCaption),
        secondaryLabelStyle: GoogleFonts.lato(color: kNeutralWhiteColor, fontSize: kFontSizeCaption),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadiusStandard)),
      ),
      // Add other theme properties as needed
    );
  }

  // Optional: Define a dark theme if required by the design prompt
  static ThemeData get darkTheme {
    // For now, let's return a modified light theme or a basic dark theme
    // You can customize this extensively based on the "Support iOS dark mode" and "Support Android dark theme" requirements
    return ThemeData.dark().copyWith(
      primaryColor: kPrimaryColor, // Keep primary color consistent or adapt for dark mode
      scaffoldBackgroundColor: kNeutralDarkGrayColor, // Dark background
      colorScheme: const ColorScheme.dark(
        primary: kPrimaryColor,
        secondary: kSecondaryBlueColor,
        error: kErrorColor,
        surface: Color(0xFF121212), // Common dark surface color
        onPrimary: kNeutralWhiteColor,
        onSecondary: kNeutralWhiteColor,
        onSurface: kNeutralLightGrayColor, // Text on dark background
        onError: kNeutralWhiteColor,
        brightness: Brightness.dark,
        tertiary: kPrimaryRedColor,
        onTertiary: kNeutralWhiteColor,
        surfaceVariant: Color(0xFF1E1E1E), // Slightly lighter dark surface
        outline: kNeutralLightGrayColor,
        shadow: kNeutralWhiteColor, // Shadows might need to be lighter or different
        inversePrimary: kPrimaryColor,
      ),
      appBarTheme: AppBarTheme(
        color: kPrimaryColor, // Or a darker shade for dark mode
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralWhiteColor),
        titleTextStyle: GoogleFonts.lato(
          fontSize: kFontSizeSubheader,
          fontWeight: FontWeight.w600,
          color: kNeutralWhiteColor,
        ),
      ),
      textTheme: TextTheme(
        // Adjust text colors for dark mode
        displayLarge: GoogleFonts.lato(
          fontSize: kFontSizeHeaderLarge,
          fontWeight: FontWeight.bold,
          color: kNeutralLightGrayColor,
        ),
        displayMedium: GoogleFonts.lato(
          fontSize: kFontSizeHeader,
          fontWeight: FontWeight.bold,
          color: kNeutralLightGrayColor,
        ),
        displaySmall: GoogleFonts.lato(
          fontSize: kFontSizeSubheaderLarge,
          fontWeight: FontWeight.bold,
          color: kNeutralLightGrayColor,
        ),
        headlineMedium: GoogleFonts.lato(
          fontSize: kFontSizeSubheader,
          fontWeight: FontWeight.w600,
          color: kNeutralLightGrayColor,
        ),
        headlineSmall: GoogleFonts.lato(
          fontSize: kFontSizeBodyLarge,
          fontWeight: FontWeight.w600,
          color: kNeutralLightGrayColor,
        ),
        titleLarge: GoogleFonts.lato(
          fontSize: kFontSizeBody,
          fontWeight: FontWeight.w600,
          color: kNeutralLightGrayColor,
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: kFontSizeBodyLarge,
          fontWeight: FontWeight.normal,
          color: kNeutralLightGrayColor,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: kFontSizeBody,
          fontWeight: FontWeight.normal,
          color: kNeutralLightGrayColor,
        ),
        bodySmall: GoogleFonts.lato(
          fontSize: kFontSizeCaption,
          fontWeight: FontWeight.normal,
          color: kNeutralLightGrayColor,
        ),
        labelLarge: GoogleFonts.lato(fontSize: kFontSizeButton, fontWeight: FontWeight.w500, color: kNeutralWhiteColor),
        labelMedium: GoogleFonts.lato(
          fontSize: kFontSizeCaption,
          fontWeight: FontWeight.w500,
          color: kNeutralLightGrayColor,
        ),
        labelSmall: GoogleFonts.lato(
          fontSize: kFontSizeCaption,
          fontWeight: FontWeight.w300,
          color: kNeutralLightGrayColor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadiusButton)),
        buttonColor: kPrimaryColor,
        textTheme: ButtonTextTheme.primary,
        height: kButtonHeight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: kNeutralWhiteColor,
          minimumSize: const Size(double.infinity, kButtonHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadiusButton)),
          textStyle: GoogleFonts.lato(fontSize: kFontSizeButton, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor, // Or a lighter shade for dark mode
          textStyle: GoogleFonts.lato(fontSize: kFontSizeBody, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: BorderSide(color: kNeutralLightGrayColor.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: BorderSide(color: kNeutralLightGrayColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: const BorderSide(color: kErrorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusStandard),
          borderSide: const BorderSide(color: kErrorColor, width: 1.5),
        ),
        labelStyle: GoogleFonts.lato(color: kNeutralLightGrayColor.withOpacity(0.7)),
        hintStyle: GoogleFonts.lato(color: kNeutralLightGrayColor.withOpacity(0.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.9),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadiusStandard)),
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 4),
        color: const Color(0xFF1E1E1E), // Darker card color
      ),
      iconTheme: const IconThemeData(color: kNeutralLightGrayColor, size: 24.0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF121212), // Dark bottom nav
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kNeutralLightGrayColor.withOpacity(0.6),
        selectedLabelStyle: GoogleFonts.lato(fontSize: kFontSizeCaption, fontWeight: FontWeight.w500),
        unselectedLabelStyle: GoogleFonts.lato(fontSize: kFontSizeCaption, fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: kNeutralDarkGrayColor, // Darker chip
        selectedColor: kPrimaryColor,
        labelStyle: GoogleFonts.lato(color: kNeutralLightGrayColor, fontSize: kFontSizeCaption),
        secondaryLabelStyle: GoogleFonts.lato(color: kNeutralWhiteColor, fontSize: kFontSizeCaption),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadiusStandard)),
      ),
    );
  }
}
