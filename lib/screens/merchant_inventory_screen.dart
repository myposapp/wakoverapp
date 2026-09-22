import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../models/product.dart';
import '../widgets/custom_bottom_nav.dart';

class MerchantInventoryScreen extends StatelessWidget {
  const MerchantInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    final filteredProducts = provider.products.where((p) {
      if (provider.inventoryFilter == 'low_stock' && p.status != 'low_stock') {
        return false;
      }
      if (provider.inventoryFilter == 'out_of_stock' &&
          p.status != 'out_of_stock') {
        return false;
      }
      if (provider.searchQuery.isNotEmpty &&
          !p.name.toLowerCase().contains(provider.searchQuery.toLowerCase()) &&
          !p.sku.toLowerCase().contains(provider.searchQuery.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Vault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () => _showAddProductModal(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Search Input
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.06)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, size: 20, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (val) => provider.setSearchQuery(val),
                        decoration: const InputDecoration(
                          hintText: 'Search SKU, product title, category...',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Filter Pills
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    _buildFilterPill(context, 'All Stock', 'all'),
                    _buildFilterPill(context, 'Low Stock', 'low_stock'),
                    _buildFilterPill(context, 'Out of Stock', 'out_of_stock'),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Products List
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(
                        child: Text('No inventory matching selected filters.'),
                      )
                    : ListView.separated(
                        itemCount: filteredProducts.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, idx) {
                          final product = filteredProducts[idx];
                          return _buildProductRow(context, product);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          const MerchantBottomNavBar(activeRoute: 'merchant_inventory'),
    );
  }

  Widget _buildFilterPill(BuildContext context, String label, String value) {
    final provider = context.watch<AppProvider>();
    final isSelected = provider.inventoryFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => provider.setInventoryFilter(value),
        selectedColor: AppTheme.navyDark,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade700,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildProductRow(BuildContext context, Product product) {
    final isLow = product.status == 'low_stock';
    final isOut = product.status == 'out_of_stock';
    final badgeColor = isOut
        ? Colors.red
        : isLow
            ? Colors.orange
            : Colors.green;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.image,
              width: 58,
              height: 58,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        product.status.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: badgeColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      product.sku,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${product.price.toStringAsFixed(2)} • ${product.stock} in warehouse',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, color: AppTheme.primaryBlue),
            onPressed: () => _showStockAdjustSheet(context, product),
          ),
        ],
      ),
    );
  }

  void _showStockAdjustSheet(BuildContext context, Product product) {
    int current = product.stock;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Adjust Stock: ${product.name}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle, size: 32),
                    onPressed: () => setState(() => current = current > 0 ? current - 1 : 0),
                  ),
                  const SizedBox(width: 16),
                  Text('$current',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.add_circle, size: 32),
                    onPressed: () => setState(() => current++),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AppProvider>().updateProductStock(product.id, current);
                    Navigator.pop(context);
                  },
                  child: const Text('Confirm Inventory Level'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddProductModal(BuildContext context) {
    context.read<AppProvider>().showToast('Add product dialog ready.');
  }
}
