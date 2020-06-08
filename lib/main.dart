import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:gdziemojhajsapp/pages/Account/forget_password_page.dart';
import 'package:gdziemojhajsapp/pages/Account/login_page.dart';
import 'package:gdziemojhajsapp/pages/Account/register_page.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/admin_modify_user_page.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/change_password_page.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/change_question_answer_page.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/settings_page.dart';
import 'package:gdziemojhajsapp/pages/Categories/categories.dart';
import 'package:gdziemojhajsapp/pages/Categories/categoryPage.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_state.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_transfer.dart';
import 'package:gdziemojhajsapp/pages/Home/home_screen.dart';
import 'package:gdziemojhajsapp/pages/Menu/budget_limites.dart';
import 'package:gdziemojhajsapp/pages/Menu/budget_limits_state.dart';
import 'package:gdziemojhajsapp/pages/Receipt/createReceipt.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(fallbackLocale: 'en_US', supportedLocales: ['en_US', 'pl'],preferences: TranslatePreferences());
  runApp(LocalizedApp(delegate, MyApp()));
}

class TranslatePreferences implements ITranslatePreferences{
  static const String _selectedLocaleKey = 'selected_locale';

  @override
  Future<Locale> getPreferredLocale() async{
    final preferences = await SharedPreferences.getInstance();
    if(!preferences.containsKey(_selectedLocaleKey)) return null;
    var locale = preferences.getString(_selectedLocaleKey);
    return localeFromString(locale);
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_selectedLocaleKey, localeToString(locale));
  }
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    RegisterPage.tag: (context) => RegisterPage(),
    ForgetPasswordPage.tag: (context) => ForgetPasswordPage(),
    ForgetPasswordQuestionPage.tag: (context) => ForgetPasswordQuestionPage(),
    ForgetPasswordSuccessPage.tag: (context) => ForgetPasswordSuccessPage(),
    UserSettingsPage.tag: (context) => UserSettingsPage(),
    ChangePasswordPage.tag: (context) => ChangePasswordPage(),
    ChangeQuestionAnswerPage.tag: (context) => ChangeQuestionAnswerPage(),
    AdminModifyUserPage.tag: (context) => AdminModifyUserPage(),
    HomeScreen.tag: (context) => HomeScreen(),
    CreateReceipt.tag: (context) => CreateReceipt(),
    CategoryPage.tag: (context) => CategoryPage(),
    Categories.tag: (context) => Categories(),
    LimitTransfer.tag: (context) => LimitTransfer(),
    SetLimits.tag: (context) => SetLimits()
  };

  static final String serverAddress = 'http://10.0.2.2:5000';
  static Map activeUser;
  static Text activeUserNameTextWidget = Text("no_user");

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LimitsState>.value(
          value: LimitsState(),
        ),
        ChangeNotifierProvider<CategoriesState>.value(
          value: CategoriesState(),
        )
      ],
      child: LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
          title: 'GdzieMojHajs',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            fontFamily: 'Nunito',
          ),
          home: LoginPage(),
          routes: routes,
        ),
      ),
    );
  }
}
