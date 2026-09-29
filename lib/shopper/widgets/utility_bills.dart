import 'package:flutter/material.dart';
import 'package:wakover/shopper/constants/constants.dart';
import 'package:wakover/shopper/screens/utility/buyer_utility_products_screen.dart';
import 'package:wakover/theme/app_theme.dart';

class UtilityBillsWidget extends StatelessWidget {
  const UtilityBillsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.air, color: AppTheme.primaryBlue),
            title: Text('Buy Airtime'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => BuyerUtilityProductsScreen(
                  utilityType: ShopperConstants.buyAirtime,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.router, color: AppTheme.primaryBlue),
            title: Text('Buy Data Bundle'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => BuyerUtilityProductsScreen(
                  utilityType: ShopperConstants.buyDataBundle,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.power_rounded, color: AppTheme.primaryBlue),
            title: Text('Pay Electricity Bill'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => BuyerUtilityProductsScreen(
                  utilityType: ShopperConstants.payElectricityBill,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.tv, color: AppTheme.primaryBlue),
            title: Text('Pay TV Subscription'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
