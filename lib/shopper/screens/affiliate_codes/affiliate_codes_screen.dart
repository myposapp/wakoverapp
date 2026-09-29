import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/affiliate_code_model.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/shopper/widgets/hub/paged_list_view.dart';

import 'widgets/affiliate_code_card.dart';

class AffiliateCodesScreen extends StatelessWidget {
  const AffiliateCodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Affiliate Codes')),
      body: SafeArea(
        child: PagedListView<AffiliateCode>(
          feature: 'affiliate codes',
          fetchPage: (repo, page) => repo.getAffiliateCodes(page: page),
          emptyState: const _RequestAffiliateState(),
          itemBuilder: (context, code) => AffiliateCodeCard(code: code),
        ),
      ),
    );
  }
}

class _RequestAffiliateState extends StatefulWidget {
  const _RequestAffiliateState();

  @override
  State<_RequestAffiliateState> createState() => _RequestAffiliateStateState();
}

class _RequestAffiliateStateState extends State<_RequestAffiliateState> {
  bool _isRequesting = false;

  Future<void> _request() async {
    setState(() => _isRequesting = true);
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.requestAffiliateCode();
      if (!mounted) return;
      showHubSnack(
        context,
        response.message ??
            (response.success == true
                ? 'Your request has been sent.'
                : 'Request failed.'),
      );
    } catch (e) {
      if (mounted) showHubSnack(context, e.toString());
    } finally {
      if (mounted) setState(() => _isRequesting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HubMessage(
      icon: Icons.percent_rounded,
      title: 'Earn with this store',
      message:
          'You don\'t have any affiliate codes yet. Request to become an '
          'affiliate and earn commission when people buy with your code.',
      actionLabel: 'Request to be an affiliate',
      isBusy: _isRequesting,
      onAction: _request,
    );
  }
}
