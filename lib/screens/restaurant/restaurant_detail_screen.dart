import 'package:flutter/material.dart';
import 'package:delivery_client/models/restaurant_model.dart';
import 'package:delivery_client/models/menu_category_model.dart';
import 'package:delivery_client/models/menu_item_model.dart';
import 'package:delivery_client/utils/constants.dart';
import 'package:delivery_client/services/repositories/mock_restaurant_repository_impl.dart'; // Temporary for mock data
import 'package:delivery_client/widgets/restaurant/menu_item_detail_modal.dart'; // Import the modal
// import 'package:delivery_client/widgets/restaurant/menu_item_card.dart'; // To be created
// import 'package:delivery_client/widgets/common/sticky_tabs_delegate.dart'; // To be created for sticky tabs

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId; // Or pass the full Restaurant object if already fetched

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> with SingleTickerProviderStateMixin {
  // TODO: Replace with actual repository and use case injection (e.g., via Provider)
  final MockRestaurantRepositoryImpl _restaurantRepository = MockRestaurantRepositoryImpl();

  Restaurant? _restaurant;
  bool _isLoading = true;
  bool _isFavorite = false; // Mock state
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchRestaurantDetails();
  }

  Future<void> _fetchRestaurantDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // In a real app, use GetRestaurantDetailsUseCase
      final restaurant = await _restaurantRepository.getRestaurantDetails(widget.restaurantId);
      setState(() {
        _restaurant = restaurant;
        _isFavorite = restaurant.isFavorite; // Assuming isFavorite is part of the model
        _isLoading = false;
        if (restaurant.menuCategories.isNotEmpty) {
          _tabController = TabController(length: restaurant.menuCategories.length, vsync: this);
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error, e.g., show a snackbar or an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching restaurant details: $e')));
      print("Error fetching restaurant: $e");
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      // TODO: Add logic to update backend/local storage for favorites
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? '${_restaurant?.name} added to favorites' : '${_restaurant?.name} removed from favorites',
        ),
      ),
    );
  }

  // Placeholder for Menu Item Card - to be moved to its own widget
  Widget _buildMenuItem(MenuItem item, BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Row(
          children: [
            item.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(kBorderRadiusStandard / 2),
                    child: Image.network(
                      item.imageUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80),
                    ),
                  )
                : Container(
                    width: 80,
                    height: 80,
                    color: kNeutralLightGrayColor,
                    child: const Icon(Icons.image_not_supported),
                  ),
            const SizedBox(width: kDefaultPadding / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  if (item.description != null)
                    Text(
                      item.description!,
                      style: theme.textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  // Add popular/spicy/dietary icons here
                ],
              ),
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
                ),
                const SizedBox(height: kDefaultPadding / 4),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text("Add"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 4),
                    textStyle: theme.textTheme.labelSmall?.copyWith(color: kNeutralWhiteColor),
                    minimumSize: const Size(60, 30),
                  ),
                  onPressed: item.isAvailable
                      ? () {
                          showMenuItemDetailModal(context, item);
                        }
                      : null, // Disabled if not available
                ),
                if (!item.isAvailable) Text("Sold Out", style: theme.textTheme.bodySmall?.copyWith(color: kErrorColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(leading: BackButton(onPressed: () => Navigator.pop(context))),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_restaurant == null) {
      return Scaffold(
        appBar: AppBar(leading: BackButton(onPressed: () => Navigator.pop(context))),
        body: const Center(child: Text('Restaurant not found.')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          // Header Section (SliverAppBar for collapsing effect)
          SliverAppBar(
            expandedHeight: 200.0, // Height of the hero image
            floating: false,
            pinned: true, // Keeps app bar visible when scrolling
            leading: BackButton(color: kNeutralWhiteColor, onPressed: () => Navigator.pop(context)),
            actions: [
              IconButton(
                icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: kNeutralWhiteColor),
                onPressed: _toggleFavorite,
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: kNeutralWhiteColor),
                onPressed: () {
                  /* TODO: Implement share functionality */
                  print("Share tapped");
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: kDefaultPadding,
                bottom: kDefaultPadding,
                right: kDefaultPadding,
              ),
              title: Text(
                _restaurant!.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: kNeutralWhiteColor,
                  shadows: [Shadow(blurRadius: 2, color: Colors.black.withOpacity(0.5))],
                ),
                overflow: TextOverflow.ellipsis,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  _restaurant!.heroImageUrl != null
                      ? Image.network(
                          _restaurant!.heroImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: kPrimaryColor.withOpacity(0.7),
                            child: const Icon(Icons.restaurant_menu, size: 100, color: kNeutralWhiteColor),
                          ),
                        )
                      : Container(
                          color: kPrimaryColor,
                          child: const Icon(Icons.restaurant_menu, size: 100, color: kNeutralWhiteColor),
                        ),
                  // Gradient overlay for better text visibility on image
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                  // Restaurant Info Overlay (name, rating, delivery time, fee) - Part of FlexibleSpaceBar title or positioned separately
                  Positioned(
                    bottom: kDefaultPadding * 2.5, // Adjust as needed
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name is in title
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${_restaurant!.averageRating.toStringAsFixed(1)} (${_restaurant!.totalReviews} reviews)',
                              style: theme.textTheme.bodySmall?.copyWith(color: kNeutralWhiteColor),
                            ),
                            const SizedBox(width: kDefaultPadding / 2),
                            Text(
                              '· ${_restaurant!.deliveryTimeEstimateMinutes ?? 'N/A'} min · \$${_restaurant!.deliveryFee?.toStringAsFixed(2) ?? 'N/A'}',
                              style: theme.textTheme.bodySmall?.copyWith(color: kNeutralWhiteColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Restaurant Info Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_restaurant!.name, style: theme.textTheme.headlineMedium),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: kDefaultPadding / 2),
                      Expanded(child: Text(_restaurant!.address, style: theme.textTheme.bodyMedium)),
                      TextButton(
                        onPressed: () {
                          /* TODO: Implement Get Directions */
                        },
                        child: const Text("Directions"),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      Icon(Icons.phone_outlined, size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Text(_restaurant!.ownerName, style: theme.textTheme.bodyMedium),
                      ), // Assuming ownerName is contact person
                      TextButton(
                        onPressed: () {
                          /* TODO: Implement Call */
                        },
                        child: const Text("Call"),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: kDefaultPadding / 2),
                      Text(
                        _restaurant!.isOpen
                            ? 'Open: ${_restaurant!.openingTime?.format(context) ?? 'N/A'} - ${_restaurant!.closingTime?.format(context) ?? 'N/A'}'
                            : 'Closed. Opens at ${_restaurant!.openingTime?.format(context) ?? 'N/A'}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _restaurant!.isOpen ? kSuccessColor : kErrorColor,
                        ),
                      ),
                    ],
                  ),
                  if (_restaurant!.description != null && _restaurant!.description!.isNotEmpty) ...[
                    const SizedBox(height: kDefaultPadding),
                    Text("About Restaurant", style: theme.textTheme.titleMedium),
                    const SizedBox(height: kDefaultPadding / 2),
                    Text(_restaurant!.description!, style: theme.textTheme.bodyMedium),
                  ],
                  const SizedBox(height: kDefaultPadding),
                  // Review Summary (Placeholder)
                  Row(
                    children: [
                      Text("Reviews (${_restaurant!.totalReviews})", style: theme.textTheme.titleMedium),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          /* TODO: Navigate to all reviews screen */
                        },
                        child: const Text("See All"),
                      ),
                    ],
                  ),
                  // Placeholder for a few review snippets or average rating display
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < _restaurant!.averageRating.round() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
          ),

          // Menu Categories (Sticky horizontal tabs)
          if (_tabController != null && _restaurant!.menuCategories.isNotEmpty)
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyTabsDelegate(
                tabBar: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: theme.primaryColor,
                  unselectedLabelColor: kNeutralDarkGrayColor.withOpacity(0.7),
                  indicatorColor: theme.primaryColor,
                  indicatorWeight: 2.5,
                  tabs: _restaurant!.menuCategories.map((category) => Tab(text: category.name)).toList(),
                  onTap: (index) {
                    // TODO: Implement scroll to section
                  },
                ),
              ),
            ),

          // Menu Items Section
          if (_tabController != null && _restaurant!.menuCategories.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                final category = _restaurant!.menuCategories[index];
                // This is a simplified approach. For true tab-based content switching,
                // you'd use TabBarView or filter items based on selected tab.
                // For now, just listing all items under their category headers.
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index > 0)
                        const SizedBox(height: kDefaultPadding), // Space between categories if not using TabBarView
                      // Text(category.name, style: theme.textTheme.headlineSmall), // Category name as header
                      // const SizedBox(height: kDefaultPadding / 2),
                      ...category.items.map((item) => _buildMenuItem(item, context)).toList(),
                    ],
                  ),
                );
              }, childCount: _restaurant!.menuCategories.length),
            )
          else if (_restaurant!.menuItems.isNotEmpty) // Fallback if no categories but items exist
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                final item = _restaurant!.menuItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: _buildMenuItem(item, context),
                );
              }, childCount: _restaurant!.menuItems.length),
            )
          else
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding * 2),
                child: Center(child: Text("Menu not available.")),
              ),
            ),
        ],
      ),
    );
  }
}

// Helper for Sticky Tabs - Can be moved to a common widgets folder
class _StickyTabsDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _StickyTabsDelegate({required this.tabBar});

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor, // Or another appropriate background color
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabsDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
