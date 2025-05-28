# Delivery Platform Network Layer

A comprehensive network layer implementation for the Flutter delivery platform application, featuring:

- **Clean Architecture** with separated layers (Data, Domain, Core)
- **Type-safe DTOs** that match the API exactly
- **Domain entities** for clean business logic
- **Automatic mapping** between DTOs and domain entities
- **Centralized error handling** with specific exception types
- **JWT authentication** with automatic token refresh
- **Repository pattern** for data access abstraction

## Setup

### 1. Initialize the Network Manager

In your `main.dart`, initialize the network manager before running the app:

```dart
import 'package:delivery_client/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the network layer
  await NetworkManager().initialize();
  
  runApp(MyApp());
}
```

### 2. Configure API Base URL

Update the base URL in `lib/core/network/api_client.dart`:

```dart
static const String _baseUrl = 'https://your-api-domain.com'; // Replace with your actual API URL
```

## Usage Examples

### Authentication

```dart
import 'package:delivery_client/core/core.dart';
import 'package:delivery_client/domain/domain.dart';

// Get the auth repository
final authRepo = NetworkManager().authRepository;

// Register a new user
try {
  final user = await authRepo.register(
    email: 'user@example.com',
    fullName: 'John Doe',
    password: 'password123',
    passwordConfirm: 'password123',
    role: UserRole.customer,
    customerProfile: CustomerProfile(
      defaultAddress: '123 Main St',
      defaultLocationLat: 40.7128,
      defaultLocationLng: -74.0060,
    ),
  );
  print('User registered: ${user.fullName}');
} on NetworkException catch (e) {
  print('Registration failed: ${e.message}');
}

// Login
try {
  final tokens = await authRepo.login(
    email: 'user@example.com',
    password: 'password123',
  );
  
  // Save tokens for automatic authentication
  NetworkManager().setAuthTokens(
    tokens.accessToken,
    tokens.refreshToken,
  );
  
  print('Login successful');
} on NetworkException catch (e) {
  print('Login failed: ${e.message}');
}

// Get user profile
try {
  final user = await authRepo.getUserProfile();
  print('Welcome, ${user.fullName}!');
} on NetworkException catch (e) {
  print('Failed to get profile: ${e.message}');
}

// Logout
try {
  await authRepo.logout();
  NetworkManager().clearAuthTokens();
  print('Logged out successfully');
} on NetworkException catch (e) {
  print('Logout failed: ${e.message}');
}
```

### Restaurant Operations

```dart
import 'package:delivery_client/core/core.dart';
import 'package:delivery_client/domain/domain.dart';

// Get the restaurant repository
final restaurantRepo = NetworkManager().restaurantRepository;

// Get list of restaurants
try {
  final restaurants = await restaurantRepo.getRestaurants(
    isOpen: true,
    search: 'pizza',
    page: 1,
  );
  
  for (final restaurant in restaurants) {
    print('${restaurant.name} - Rating: ${restaurant.averageRating}');
  }
} on NetworkException catch (e) {
  print('Failed to get restaurants: ${e.message}');
}

// Get restaurant details with menu
try {
  final restaurant = await restaurantRepo.getRestaurantDetails('restaurant-id');
  
  print('Restaurant: ${restaurant.name}');
  print('Menu categories: ${restaurant.menuCategories.length}');
  
  for (final category in restaurant.menuCategories) {
    print('Category: ${category.name}');
    for (final item in category.items) {
      print('  - ${item.name}: \$${item.price}');
    }
  }
} on NetworkException catch (e) {
  print('Failed to get restaurant details: ${e.message}');
}

// Create a review
try {
  final review = await restaurantRepo.createReview(
    restaurantId: 'restaurant-id',
    rating: 5,
    comment: 'Great food and service!',
  );
  print('Review created: ${review.comment}');
} on NetworkException catch (e) {
  print('Failed to create review: ${e.message}');
}
```

### Order Management

```dart
import 'package:delivery_client/core/core.dart';
import 'package:delivery_client/domain/domain.dart';
import 'package:delivery_client/core/mappers/order_mapper.dart';

// Get the order repository
final orderRepo = NetworkManager().orderRepository;

// Create a new order
try {
  final order = await orderRepo.createOrder(
    restaurantId: 'restaurant-id',
    deliveryAddress: '456 Oak St, City, State 12345',
    deliveryLat: 40.7589,
    deliveryLng: -73.9851,
    notes: 'Please ring the bell',
    items: [
      OrderItemRequest(
        menuItemId: 'menu-item-1',
        quantity: 2,
        notes: 'Extra cheese',
      ),
      OrderItemRequest(
        menuItemId: 'menu-item-2',
        quantity: 1,
      ),
    ],
  );
  
  print('Order created: ${order.id}');
  print('Total: \$${order.totalPrice}');
} on NetworkException catch (e) {
  print('Failed to create order: ${e.message}');
}

// Get user's orders
try {
  final orders = await orderRepo.getOrders(
    ordering: '-created_at', // Most recent first
    page: 1,
  );
  
  for (final order in orders) {
    print('Order ${order.id}: ${order.status} - \$${order.totalPrice}');
  }
} on NetworkException catch (e) {
  print('Failed to get orders: ${e.message}');
}
```

### Driver Operations (for driver app)

```dart
import 'package:delivery_client/core/core.dart';
import 'package:delivery_client/domain/domain.dart';

// Get the driver repository
final driverRepo = NetworkManager().driverRepository;

// Update driver availability
try {
  final availability = await driverRepo.updateDriverAvailability(
    id: 'availability-id',
    status: DriverAvailabilityStatus.available,
  );
  print('Driver status: ${availability.status}');
} on NetworkException catch (e) {
  print('Failed to update availability: ${e.message}');
}

// Update driver location
try {
  final location = await driverRepo.createLocationUpdate(
    driverId: 123,
    latitude: 40.7128,
    longitude: -74.0060,
    accuracy: 10.0,
  );
  print('Location updated: ${location.latitude}, ${location.longitude}');
} on NetworkException catch (e) {
  print('Failed to update location: ${e.message}');
}
```

## Error Handling

The network layer provides comprehensive error handling with specific exception types:

```dart
import 'package:delivery_client/core/core.dart';

try {
  // Some network operation
  final result = await someNetworkCall();
} on ValidationException catch (e) {
  // Handle validation errors (400 Bad Request)
  print('Validation error: ${e.message}');
  
  // Get specific field errors
  final emailError = e.getFieldError('email');
  if (emailError != null) {
    print('Email error: $emailError');
  }
  
  // Get all field errors
  for (final field in e.fieldErrors.keys) {
    final errors = e.fieldErrors[field]!;
    print('$field: ${errors.join(', ')}');
  }
} on UnauthorizedException catch (e) {
  // Handle authentication errors (401)
  print('Authentication required: ${e.message}');
  // Redirect to login
} on ForbiddenException catch (e) {
  // Handle permission errors (403)
  print('Access forbidden: ${e.message}');
} on NotFoundException catch (e) {
  // Handle not found errors (404)
  print('Resource not found: ${e.message}');
} on ServerException catch (e) {
  // Handle server errors (500+)
  print('Server error: ${e.message}');
} on NetworkException catch (e) {
  // Handle any other network errors
  print('Network error: ${e.message}');
  print('Status code: ${e.statusCode}');
  
  // Access additional error details if available
  if (e.details != null) {
    print('Error details: ${e.details}');
  }
} catch (e) {
  // Handle any other unexpected errors
  print('Unexpected error: $e');
}
```

## Architecture Overview

### Core Layer (`lib/core/`)
- **`network/`**: HTTP client, API services, DTOs
- **`mappers/`**: Convert between DTOs and domain entities
- **`errors/`**: Network exception definitions
- **`di/`**: Dependency injection setup

### Domain Layer (`lib/domain/`)
- **`entities/`**: Clean domain models
- **Pure business logic** with no external dependencies

### Data Layer (`lib/data/`)
- **`repositories/`**: Repository implementations
- **Handles data transformation** and caching logic

## Key Features

### 1. Type Safety
All API responses are mapped to strongly-typed Dart objects, preventing runtime errors from API changes.

### 2. Automatic Token Management
The `ApiClient` automatically:
- Stores JWT tokens securely
- Includes tokens in requests
- Refreshes expired tokens
- Handles authentication failures

### 3. Clean Error Handling
Specific exception types for different HTTP status codes make error handling predictable and maintainable.

### 4. Pagination Support
Built-in support for paginated responses with the `PaginatedResponseDto` class.

### 5. Role-Based Features
The API supports different user roles (Customer, Driver, Restaurant, Admin) with appropriate permissions.

## Testing

The network layer is designed to be easily testable:

```dart
// Mock the repositories for unit testing
class MockAuthRepository implements AuthRepository {
  @override
  Future<User> login({required String email, required String password}) async {
    // Return mock data
    return User(
      id: 'mock-id',
      email: email,
      fullName: 'Mock User',
      role: UserRole.customer,
      isActive: true,
      dateJoined: DateTime.now(),
    );
  }
  
  // Implement other methods...
}

// Use in tests
final mockAuthRepo = MockAuthRepository();
// Test your business logic with mock data
```

## File Upload Support

The network layer supports file uploads through multipart requests:

```dart
// Example: Upload restaurant logo
final imageFile = File('/path/to/image.jpg');
final response = await NetworkManager().apiClient.multipartRequest(
  '/restaurants/list/$restaurantId/',
  'PATCH',
  files: {'logo': imageFile},
  fields: {
    'name': 'Updated Restaurant Name',
    'description': 'Updated description',
  },
);
```

## Next Steps

1. **Update the API base URL** in `api_client.dart`
2. **Initialize the network manager** in your `main.dart`
3. **Start using the repositories** in your UI layer
4. **Add proper error handling** throughout your app
5. **Consider adding caching** for frequently accessed data
6. **Add logging** for debugging network requests

The network layer is production-ready and follows Flutter best practices for scalable, maintainable code.
