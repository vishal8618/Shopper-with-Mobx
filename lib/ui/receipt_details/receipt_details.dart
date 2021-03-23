import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/models/receipt/receipt_model.dart';
import 'package:greetings_world_shopper/stores/receipt_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceiptDetailScreen extends StatefulWidget {
  final ReceiptModel receiptInfo;

  ReceiptDetailScreen({this.receiptInfo});
  @override
  _ReceiptDetailState createState() => _ReceiptDetailState();
}

class _ReceiptDetailState extends State<ReceiptDetailScreen> {
  ScreenScaler _scaler;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserStore _userStore;
  ReceiptStore _receiptStore;
 String orderPlaceTime='';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _receiptStore = Provider.of<ReceiptStore>(context);
    if (!_receiptStore.loading)
       _receiptStore.getReceiptDetail(id: widget.receiptInfo.id.toString(),uid: _userStore.uid);

    timeConverter(widget.receiptInfo.createdAt.toString());

  }

  @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);
    return WillPopScope(
        child: Observer(builder: (context) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: AppText(
                text: Strings.transactionInfo,
                style: AppTextStyle.medium,
                color: Colors.white,
              ),
              centerTitle: true,
            ),
            backgroundColor: AppColors.bg,
            body: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    margin: _scaler.getMargin(1, 2),
                    child: Column(
                      children: [
                        Container(
                          padding: _scaler.getPadding(1, 2),
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.reciepts_bg),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            children: [
                              _buildReceiptDetailInfo(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _scaler.getHeight(16),
                        )
                      ],
                    ),
                  ),
                ),
                _buildButtons()
              ],
            ),
          );
        }),
        onWillPop: pop);
  }

  Widget _buildReceiptDetailInfo() {
    return Container(
      height: _scaler.getHeight(50),
      width: _scaler.getWidth(80),
      child: Column(
        children: [
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          Container(
            child: Container(
              height: _scaler.getHeight(20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: widget.receiptInfo.orderItems.productPhoto != null
                          ? NetworkImage(widget.receiptInfo.orderItems.productPhoto)
                          : AssetImage(Assets.logo), fit: BoxFit.cover)
              ),
            ),
          ),
          SizedBox(
            height: _scaler.getHeight(4),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: AppText(
              text: widget.receiptInfo.orderItems.product,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(12),
            ),
          ),
          Divider(
            height: _scaler.getHeight(2),
          ),
          SizedBox(
            height: _scaler.getHeight(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Order Placed",
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: AppText(
                  text: orderPlaceTime,
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _scaler.getHeight(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Cost",
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: AppText(
                  text: "\$${widget.receiptInfo.totalAmount.toString()}",
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _scaler.getHeight(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Tracking ID",
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: AppText(
                  text:widget.receiptInfo.trackingNumber,
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Positioned(
      bottom: _scaler.getHeight(2),
      left: 0,
      right: 0,
      child: Column(
        children: [
          SizedBox(
            height: _scaler.getHeight(1),
          ),
          Container(
            width: _scaler.getWidth(100),
            margin: _scaler.getMargin(0, 3),
            child: MaterialButton(
              height: _scaler.getHeight(3.5),
              padding: _scaler.getPadding(1, 0),
              color: AppColors.buttonBg,
              onPressed: () {
                //  Navigator.of(context).pushNamed(Routes.creditCard);
              },
              child: AppText(
                text: Strings.viewReturnPolicy,
                color: Colors.white,
                style: AppTextStyle.medium,
                size: _scaler.getTextSize(11),
              ),
            ),
          ),
          Container(
            width: _scaler.getWidth(100),
            margin: _scaler.getMargin(0, 3),
            child: MaterialButton(
              height: _scaler.getHeight(3.5),
              padding: _scaler.getPadding(1, 0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                width: 1,
                color: AppColors.buttonBg,
              )),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: AppText(
                text: Strings.returnProduct,
                color: AppColors.buttonBg,
                style: AppTextStyle.medium,
                size: _scaler.getTextSize(11),
              ),
            ),
          ),
          Container(
            width: _scaler.getWidth(100),
            margin: _scaler.getMargin(0, 3),
            child: MaterialButton(
              height: _scaler.getHeight(3.5),
              padding: _scaler.getPadding(1, 0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                width: 1,
                color: AppColors.buttonBg,
              )),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: AppText(
                text: Strings.exportReceipt,
                color: AppColors.buttonBg,
                style: AppTextStyle.medium,
                size: _scaler.getTextSize(11),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> pop() async {
    Navigator.of(context).pop();
  }

  void timeConverter(String date){
   // var  date = '2021-01-26T03:17:00.000000Z';
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm aa');
    orderPlaceTime = outputFormat.format(inputDate).split(" ")[0]+ " at " + outputFormat.format(inputDate).split(" ")[1] + " " + outputFormat.format(inputDate).split(" ")[2];
    print("===Time====$orderPlaceTime");
  }


}
