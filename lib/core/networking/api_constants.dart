class ApiConstants {

  static const String baseUrl = "https://codingarabic.online/api/";

  // Auth
  static const String login = "login";
  static const String register = "register";
  static const String logout = "logout";

  // Forget Password Flow
  static const String sendForgetPasswordLink = "forget-password";
  static const String checkForgetPasswordCode = "check-forget-password";
  static const String resetPassword = "reset-password";

  // Email Verification
  static const String resendVerifyLink = "resend-verify-code";
  static const String verifyEmail = "verify-email";


  // Home
  static const String slider = "sliders";
  static const String bestSeller = "products-bestseller";
  static const String newArrivals = "products-new-arrivals";
  static const String categories = "categories";
  static const String showCategories="categories/100";

  // Products
  static const String search = "products-search?name=aqaaaq";
  static const String productDetails = "products/1";
  static const String filterProducts="products-filter?max=300&min=100&search=v&is_bestseller=1&category_id=10&limit=2";
  static const String getNewArrivals="products-new-arrivals";
  static const String getBestSeller="products-bestseller";

  // Cart
  static const String addToCart = "add-to-cart";
  static const String getCart = "cart";
  static const String updateCart = "update-cart";
  static const String removeFromCart = "remove-from-cart";
  static const String submitOrder = "checkout";
  static const String orderHistory="order-history";
  static const String governorates="governorates";
  static const String placeOrder="place-order";


  // Wishlist
  static const String addToWishlist = "add-to-wishlist";
  static const String getWishlist = "wishlist";
  static const String removeFromWishlist = "remove-from-wishlist";

  // Profile
  static const String profile = "profile";
  static const String updateProfile = "update-profile";
  static const String deleteProfile="delete-profile";

}