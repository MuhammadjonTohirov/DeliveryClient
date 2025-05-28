import '../network/api_client.dart';
import '../network/services/auth_api_service.dart';
import '../network/services/restaurant_api_service.dart';
import '../network/services/order_api_service.dart';
import '../network/services/driver_api_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/restaurant_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/driver_repository_impl.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;
  NetworkManager._internal();

  late final ApiClient _apiClient;
  late final AuthApiService _authApiService;
  late final RestaurantApiService _restaurantApiService;
  late final OrderApiService _orderApiService;
  late final DriverApiService _driverApiService;
  late final AuthRepositoryImpl _authRepository;
  late final RestaurantRepositoryImpl _restaurantRepository;
  late final OrderRepositoryImpl _orderRepository;
  late final DriverRepositoryImpl _driverRepository;

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize API client
    _apiClient = ApiClient();
    
    // Load tokens from storage
    await _apiClient.loadTokensFromStorage();

    // Initialize API services
    _authApiService = AuthApiService(_apiClient);
    _restaurantApiService = RestaurantApiService(_apiClient);
    _orderApiService = OrderApiService(_apiClient);
    _driverApiService = DriverApiService(_apiClient);

    // Initialize repositories
    _authRepository = AuthRepositoryImpl(_authApiService);
    _restaurantRepository = RestaurantRepositoryImpl(_restaurantApiService);
    _orderRepository = OrderRepositoryImpl(_orderApiService);
    _driverRepository = DriverRepositoryImpl(_driverApiService);

    _isInitialized = true;
  }

  // Getters for accessing services and repositories
  ApiClient get apiClient {
    _ensureInitialized();
    return _apiClient;
  }

  AuthApiService get authApiService {
    _ensureInitialized();
    return _authApiService;
  }

  RestaurantApiService get restaurantApiService {
    _ensureInitialized();
    return _restaurantApiService;
  }

  OrderApiService get orderApiService {
    _ensureInitialized();
    return _orderApiService;
  }

  DriverApiService get driverApiService {
    _ensureInitialized();
    return _driverApiService;
  }

  AuthRepositoryImpl get authRepository {
    _ensureInitialized();
    return _authRepository;
  }

  RestaurantRepositoryImpl get restaurantRepository {
    _ensureInitialized();
    return _restaurantRepository;
  }

  OrderRepositoryImpl get orderRepository {
    _ensureInitialized();
    return _orderRepository;
  }

  DriverRepositoryImpl get driverRepository {
    _ensureInitialized();
    return _driverRepository;
  }

  // Helper method to set authentication tokens
  void setAuthTokens(String accessToken, String refreshToken) {
    _ensureInitialized();
    _apiClient.setTokens(accessToken, refreshToken);
    _apiClient.saveTokensToStorage();
  }

  // Helper method to clear authentication tokens
  void clearAuthTokens() {
    _ensureInitialized();
    _apiClient.clearTokens();
  }

  // Helper method to refresh access token
  Future<void> refreshAccessToken() async {
    _ensureInitialized();
    await _apiClient.refreshAccessToken();
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError('NetworkManager must be initialized before use. Call initialize() first.');
    }
  }

  void dispose() {
    if (_isInitialized) {
      _apiClient.dispose();
      _isInitialized = false;
    }
  }
}
