import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/shopper/models/shopper_user_model.dart';
import 'package:wakover/shopper/providers/user_session_provider.dart';
import 'package:wakover/shopper/models/wallet_transaction_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/shopper/widgets/hub/paged_list_view.dart';
import 'package:wakover/theme/app_theme.dart';

import 'widgets/withdraw_sheet.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _listKey = GlobalKey<PagedListViewState<WalletTransaction>>();

  @override
  void initState() {
    super.initState();
    // Refresh so the balance reflects the latest wallet activity.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<UserSessionProvider>().refreshProfile(),
    );
  }

  Future<void> _withdraw(ShopperUser user) async {
    final completed = await showWithdrawSheet(context, user: user);
    if (completed == true && mounted) {
      showHubSnack(context, 'Money has been sent to the provided account.');
      context.read<UserSessionProvider>().refreshProfile();
      _listKey.currentState?.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserSessionProvider>().user;
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: SafeArea(
        child: PagedListView<WalletTransaction>(
          key: _listKey,
          feature: 'transactions',
          fetchPage: (repo, page) => repo.getWalletTransactions(page: page),
          header: user == null
              ? null
              : _WalletCard(user: user, onWithdraw: () => _withdraw(user)),
          emptyState: const HubMessage(
            icon: Icons.swap_horiz_rounded,
            title: 'No transactions yet',
            message: 'Wallet credits, debits and refunds will appear here.',
          ),
          itemBuilder: (context, tx) => _TransactionTile(transaction: tx),
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  const _WalletCard({required this.user, required this.onWithdraw});

  final ShopperUser user;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    final balance = user.walletBalance ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.navyDark, Color(0xFF102468), AppTheme.primaryBlue],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 12,
                      color: AppTheme.accentCyan,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'WALLET',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (user.walletId != null)
                Text(
                  user.walletId!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Available Balance',
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 2),
          Text(
            formatNaira(balance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              if ((user.points ?? 0) > 0)
                Text(
                  '${user.points} points',
                  style: const TextStyle(
                    color: AppTheme.accentCyan,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: balance > 0 ? onWithdraw : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.navyDark,
                  disabledBackgroundColor: Colors.white24,
                  disabledForegroundColor: Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.north_east_rounded, size: 16),
                label: const Text(
                  'Withdraw',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final WalletTransaction transaction;

  static const _credit = Color(0xFF2F855A);
  static const _debit = Color(0xFFC53030);

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;
    final color = isCredit ? _credit : _debit;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final status = transaction.paymentStatus;

    return HubCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.22 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit ? Icons.south_west_rounded : Icons.north_east_rounded,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.product ??
                      transaction.description ??
                      'Transaction',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (transaction.remark?.isNotEmpty == true)
                  Text(
                    transaction.remark!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11),
                  ),
                Text(
                  formatDateTime(transaction.createdAt),
                  style: TextStyle(fontSize: 10, color: hubMutedText(context)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCredit ? '+' : '−'}${formatNaira(transaction.amount)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (status != null && status.toUpperCase() != 'SUCCESS')
                Text(
                  status[0] + status.substring(1).toLowerCase(),
                  style: TextStyle(fontSize: 10, color: hubMutedText(context)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
