import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:skribex_app/bindings/expense_binding.dart';
import 'package:skribex_app/bindings/invite_employee_binding.dart';
import 'package:skribex_app/bindings/map_tracking_binding.dart';
import 'package:skribex_app/bindings/navigation_binding.dart';
import 'package:skribex_app/bindings/profile_binding.dart';
import 'package:skribex_app/screens/auth/confirm_register.dart';
import 'package:skribex_app/screens/auth/confirm_reset_password.dart';
import 'package:skribex_app/screens/expense/expense_deetail_screen.dart';
import 'package:skribex_app/screens/expense/expense_screen.dart';
import 'package:skribex_app/screens/invite_team/invite_team.dart';
import 'package:skribex_app/screens/map_tracking/map_tracking_screen.dart.dart';
import 'package:skribex_app/screens/navigation/navigation_screen.dart';
import 'package:skribex_app/screens/profile/feedback_form.dart';
import 'package:skribex_app/screens/profile/profile_screen.dart';
import 'package:skribex_app/screens/profile/update_pofile.dart';
import '../bindings/forgot_password_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/onboard_binding.dart';
import '../bindings/splash_binding.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/boarding/onboard_screen.dart';
import '../screens/home/home_sceen.dart';
import '../screens/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = RouteName.splash;
  // static const initial = RouteName.feedbackForm;

  static final pages = [
    //Welcome Page
    GetPage(
      name: RouteName.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteName.navigation,
      page: () => NavigationScreen(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: RouteName.onBoard,
      page: () => const OnBoarding(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: RouteName.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: RouteName.companyRegister,
      page: () => CompanyRegistration(),
    ),
    GetPage(
      name: RouteName.individualRegister,
      page: () => IndividualRegistration(),
    ),
    GetPage(
      name: RouteName.selecAccount,
      page: () => SelectUserAccount(),
    ),
    GetPage(
      name: RouteName.inviteEmployee,
      page: () => InviteTeam(),
      binding: InviteEmployeeBinding(),
    ),
    GetPage(
      name: RouteName.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: RouteName.confirmResetPassword,
      page: () => const ConfirmResetPassword(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: RouteName.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: RouteName.updateProfileIndividual,
      page: () => UpdatePofileIndividual(),
    ),
    GetPage(
      name: RouteName.feedbackForm,
      page: () => FeedbackForm(),
    ),
    GetPage(
      name: RouteName.updateProfileCompany,
      page: () => UpdatePofileCompany(),
    ),
    GetPage(
      name: RouteName.expense,
      page: () => ExpenseScreen(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: RouteName.expenseDetail,
      page: () => ExpenseDetailScreen(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: RouteName.confirmRegister,
      page: () => ConfirmRegisterScreen(),
    ),
    // GetPage(
    //   name: RouteName.mapTracking,
    //   page: () => MapTrackScreen(),
    //   binding: MapTrackingBinding(),
    // ),
    GetPage(
      name: RouteName.mapTracking,
      page: () => MapTrackScreen(),
      binding: MapTrackingBinding(),
    ),
  ];
}
