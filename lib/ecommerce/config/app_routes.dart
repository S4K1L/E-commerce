import 'package:get/get.dart';

import '../views/auth/complete_profile_screen.dart';
import '../views/auth/forgot_password_screen.dart';
import '../views/auth/location_access_screen.dart';
import '../views/auth/new_password_screen.dart';
import '../views/auth/notification_access_screen.dart';
import '../views/auth/sign_in_screen.dart';
import '../views/auth/sign_up_screen.dart';
import '../views/auth/verify_code_screen.dart';
import '../views/cart/cart_screen.dart';
import '../views/cart/checkout_screen.dart';
import '../views/cart/choose_shipping_screen.dart';
import '../views/cart/payment_methods_screen.dart';
import '../views/cart/shipping_address_screen.dart';
import '../views/category/category_products_screen.dart';
import '../views/chat/chat_screen.dart';
import '../views/home/home_screen.dart';
import '../views/home/search_screen.dart';
import '../views/main_navigation.dart';
import '../views/onboarding/onboarding_screen.dart';
import '../views/order/order_tracking_screen.dart';
import '../views/product/leave_review_screen.dart';
import '../views/product/product_details_screen.dart';
import '../views/product/reviews_screen.dart';
import '../views/profile/edit_profile_screen.dart';
import '../views/profile/help_center_screen.dart';
import '../views/profile/manage_addresses_screen.dart';
import '../views/profile/my_coupons_screen.dart';
import '../views/profile/my_orders_screen.dart';
import '../views/profile/my_wallet_screen.dart';
import '../views/profile/payment_methods_profile_screen.dart';
import '../views/profile/settings_screen.dart';
import '../views/splash/splash_screen.dart';
import '../views/wishlist/wishlist_screen.dart';

class Routes {
  Routes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgot = '/forgot-password';
  static const String verify = '/verify-code';
  static const String newPassword = '/new-password';
  static const String completeProfile = '/complete-profile';
  static const String locationAccess = '/location-access';
  static const String notificationAccess = '/notification-access';

  static const String main = '/main';
  static const String home = '/home';
  static const String search = '/search';
  static const String category = '/category';
  static const String productDetails = '/product-details';
  static const String reviews = '/reviews';
  static const String leaveReview = '/leave-review';

  static const String wishlist = '/wishlist';
  static const String cart = '/cart';
  static const String shippingAddress = '/shipping-address';
  static const String chooseShipping = '/choose-shipping';
  static const String checkout = '/checkout';
  static const String paymentMethods = '/payment-methods';

  static const String orderTracking = '/order-tracking';
  static const String chat = '/chat';

  static const String editProfile = '/edit-profile';
  static const String manageAddresses = '/manage-addresses';
  static const String paymentMethodsProfile = '/profile-payment-methods';
  static const String myOrders = '/my-orders';
  static const String myCoupons = '/my-coupons';
  static const String myWallet = '/my-wallet';
  static const String settings = '/settings';
  static const String helpCenter = '/help-center';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: forgot, page: () => const ForgotPasswordScreen()),
    GetPage(name: verify, page: () => const VerifyCodeScreen()),
    GetPage(name: newPassword, page: () => const NewPasswordScreen()),
    GetPage(
        name: completeProfile, page: () => const CompleteProfileScreen()),
    GetPage(name: locationAccess, page: () => const LocationAccessScreen()),
    GetPage(
        name: notificationAccess,
        page: () => const NotificationAccessScreen()),
    GetPage(name: main, page: () => const MainNavigation()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: search, page: () => const SearchScreen()),
    GetPage(name: category, page: () => const CategoryProductsScreen()),
    GetPage(
        name: productDetails, page: () => const ProductDetailsScreen()),
    GetPage(name: reviews, page: () => const ReviewsScreen()),
    GetPage(name: leaveReview, page: () => const LeaveReviewScreen()),
    GetPage(name: wishlist, page: () => const WishlistScreen()),
    GetPage(name: cart, page: () => const CartScreen()),
    GetPage(
        name: shippingAddress, page: () => const ShippingAddressScreen()),
    GetPage(name: chooseShipping, page: () => const ChooseShippingScreen()),
    GetPage(name: checkout, page: () => const CheckoutScreen()),
    GetPage(name: paymentMethods, page: () => const PaymentMethodsScreen()),
    GetPage(name: orderTracking, page: () => const OrderTrackingScreen()),
    GetPage(name: chat, page: () => const ChatScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(
        name: manageAddresses, page: () => const ManageAddressesScreen()),
    GetPage(
        name: paymentMethodsProfile,
        page: () => const PaymentMethodsProfileScreen()),
    GetPage(name: myOrders, page: () => const MyOrdersScreen()),
    GetPage(name: myCoupons, page: () => const MyCouponsScreen()),
    GetPage(name: myWallet, page: () => const MyWalletScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
    GetPage(name: helpCenter, page: () => const HelpCenterScreen()),
  ];
}
