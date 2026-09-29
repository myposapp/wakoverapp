import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/affiliate_code_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/status_badge.dart';
import 'package:wakover/theme/app_theme.dart';

class AffiliateCodeCard extends StatelessWidget {
  const AffiliateCodeCard({super.key, required this.code});

  final AffiliateCode code;

  String? get _commission {
    switch (code.commType) {
      case 'percent':
        final cap = code.commMax;
        return '${code.commAmount ?? 0}% commission'
            '${cap != null && cap > 0 ? ' · up to ${formatNaira(cap)}' : ''}';
      case 'flat':
        return '${formatNaira(code.commAmount)} per sale';
      default:
        return null;
    }
  }

  void _copy(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    showHubSnack(context, '$label copied');
  }

  @override
  Widget build(BuildContext context) {
    final origin = context.read<NetworkProvider>().storeOrigin;
    final codeText = code.code ?? '';
    final blacklist = code.blacklist ?? const [];
    final whitelist = code.whitelist ?? const [];
    final commission = _commission;

    return HubCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ticket header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.navyDark,
                  Color(0xFF102468),
                  AppTheme.primaryBlue,
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'YOUR CODE',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        codeText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: code.status),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (code.name != null)
                  Text(
                    code.name!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (commission != null) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: hubTint(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      commission,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ),
                ],
                if (code.description?.isNotEmpty == true) ...[
                  const SizedBox(height: 8),
                  Text(
                    code.description!,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: hubMutedText(context),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Divider(height: 1, color: hubBorder(context)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Earned',
                          style: TextStyle(
                            fontSize: 10,
                            color: hubMutedText(context),
                          ),
                        ),
                        Text(
                          formatNaira(code.totalEarning),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F855A),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (blacklist.isNotEmpty) ...[
                      HubIconAction(
                        icon: Icons.block_rounded,
                        tooltip: 'Excluded products',
                        onTap: () => _showProducts(
                          context,
                          'Excluded Products',
                          'Your code can\'t be used on these products.',
                          blacklist,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (whitelist.isNotEmpty) ...[
                      HubIconAction(
                        icon: Icons.checklist_rounded,
                        tooltip: 'Eligible products',
                        onTap: () => _showProducts(
                          context,
                          'Eligible Products',
                          'Your code only applies to these products.',
                          whitelist,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    HubIconAction(
                      icon: Icons.copy_rounded,
                      tooltip: 'Copy code',
                      onTap: () => _copy(context, codeText, 'Code'),
                    ),
                    if (origin != null) ...[
                      const SizedBox(width: 8),
                      HubIconAction(
                        icon: Icons.link_rounded,
                        tooltip: 'Copy affiliate link',
                        onTap: () => _copy(
                          context,
                          '$origin/$codeText',
                          'Affiliate link',
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProducts(
    BuildContext context,
    String title,
    String subtitle,
    List<AffiliateProduct> products,
  ) {
    showHubSheet(
      context,
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: hubMutedText(context)),
          ),
          const SizedBox(height: 12),
          for (final product in products)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  HubImage(path: product.image?.url, size: 46),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      product.name ?? 'Product',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (product.price != null)
                    Text(
                      formatNaira(product.price),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
