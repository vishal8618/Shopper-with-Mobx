import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/models/receipt/receipt_model.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/receipt_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/no_data_error.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class ReceiptsScreen extends StatefulWidget {
  @override
  _ReceiptsScreenState createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  ScreenScaler _scaler;
  UserStore _userStore;
  CartStore _cartStore;
  ReceiptStore _receiptStore;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        // if (!_merchantStore.loading) {
        //   _merchantStore.getMerchants(tab: "Online", paginated: true);
        // }
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //  initialising stores
    _cartStore = Provider.of<CartStore>(context);
    _userStore = Provider.of<UserStore>(context);
    _receiptStore = Provider.of<ReceiptStore>(context);

    if (!_receiptStore.loading && Routes.currentRoute == Routes.receipt)
      _cartStore.getCart(uid: _userStore.uid);
  }

  @override
  Widget build(BuildContext context) {
    if (_scaler == null) {
      _scaler = ScreenScaler()..init(context);
      if (!_receiptStore.loading) _receiptStore.getReceipt(uid:_userStore.uid,paginated: false);
    }

    return Scaffold(backgroundColor: AppColors.bg, body: _buildBody());
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: <Widget>[
              _handleErrorMessage(),
              _buildMainContent(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _receiptStore.loading
            ? CustomProgressIndicatorWidget()
            : _buildListView();
      },
    );
  }

  Widget _buildListView() {
    return _receiptStore.receiptList != null &&
            _receiptStore.receiptList.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            itemBuilder: (context, position) {
              return _buildListItem(_receiptStore.receiptList[position]);
            },
            itemCount: _receiptStore.receiptList.length,
          )
        : Center(
            child: NoDataError(),
          );
  }

  Widget _buildListItem(ReceiptModel receipt) {
    return Container(
      margin: _scaler.getMarginLTRB(2, 1, 2, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _scaler.getBorderRadiusCircular(6)),
      padding: _scaler.getPadding(0.5, 3),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.receiptDetail, arguments: receipt);

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: _scaler.getWidth(20),
                    height: _scaler.getHeight(10),
                    decoration: BoxDecoration(
                        gradient: AppColors.transParentGradient,
                        image: DecorationImage(
                            image: receipt.orderItems.productPhoto != null
                                ? NetworkImage(receipt.orderItems.productPhoto)
                                : AssetImage(Assets.logo),
                            fit: BoxFit.cover))),
                SizedBox(
                  width: _scaler.getWidth(2),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: AppText(
                    text: "Receipt #${receipt.id.toString()}",
                    style: AppTextStyle.medium,
                    size: _scaler.getTextSize(11),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline_rounded,
                    color: AppColors.primaryColor,
                    size: _scaler.getTextSize(14)),
                SizedBox(
                  width: _scaler.getWidth(1),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: _scaler.getPadding(0.3, 0.3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2)),
                  child: InkWell(
                    onTap: () async {
                      await FlutterShare.share(
                          title: 'Shopper share to',
                          linkUrl: receipt.url,
                          chooserTitle: 'Shopper share to');
                    },
                    child: Icon(
                      Icons.share,
                      color: AppColors.primaryColor,
                      size: _scaler.getTextSize(10.5),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_receiptStore.errorStore.errorMessage.isNotEmpty) {
          return ErrorBar.showMessage(
              _receiptStore.errorStore.errorMessage, context);
        }

        return SizedBox.shrink();
      },
    );
  }

/* @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: ListView(
        padding: _scaler.getPadding(1, 2),
        children: [getItem(), getItem(), getItem()],
      ),
    );
  }

  */
}
