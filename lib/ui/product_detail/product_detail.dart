import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/menu_options/product_options.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
import 'package:greetings_world_shopper/models/products/product_model.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/product_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/common_dialogs.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/utils/success_bar.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/common_message_dialog.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/like_button.dart';
import 'package:greetings_world_shopper/widgets/nav_cart_button.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductDetailArgs args;

  ProductDetailScreen({this.args});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ScreenScaler _scaler;
  UserStore _userStore;
  CartStore _cartStore;
  ProductStore _productStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();



    _userStore = Provider.of<UserStore>(context);
    _cartStore = Provider.of<CartStore>(context);
    _productStore = Provider.of<ProductStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    Routes.context = context;
    _scaler = ScreenScaler()..init(context);
    return WillPopScope(
      child: Observer(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              actions: [
                NavCartButton(
                  items: _cartStore.cartItems,
                  callback: () {
                    DeviceUtils.hideKeyboard(context);
                    Navigator.of(context).pushNamed(Routes.cart).then((value) {
                      setState(() {});
                    });
                  },
                )
              ],
            ),
            body: Material(
              color: Colors.white,
              child: Stack(
                children: [
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      _buildInfoCard(),
                      _buildSellerInfo(),
                      _buildButtons()
                    ],
                  ),
                  _handleErrorMessage(),
                  _handleSuccessMessage(),
                  _cartStore.loading
                      ? CustomProgressIndicatorWidget()
                      : Container(),
                ],
              ),
            ));
      }),
      onWillPop: pop,
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: _scaler.getMarginLTRB(0, 0, 0, 2),
      decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: _scaler.getBorderRadiusCircular(0)),
      child: Column(
        children: [
          Container(
            color: AppColors.bg,
            width: _scaler.getWidth(100),
            child: Stack(
              children: [
                Hero(
                  tag: "product_${widget.args.productModel.id.toString()}",
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.imagePreview,
                          arguments: widget.args.productModel.productPhoto);
                    },
                    child: ImageView(
                      path: widget.args.productModel.productPhoto,
                      height: _scaler.getHeight(27),
                      width: _scaler.getWidth(100),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: _scaler.getWidth(14),
                      height: _scaler.getWidth(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: _scaler.getBorderRadiusCircular(4)),
                      child: AppText(
                        text: "\$${widget.args.productModel.price}",
                        style: AppTextStyle.medium,
                        size: _scaler.getTextSize(11),
                      ),
                    ))
              ],
            ),
          ),
          Container(
            width: _scaler.getWidth(100),
            padding: _scaler.getPadding(0.3, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _scaler.getHeight(0.5),
                ),
                AppText(
                  text: widget.args.productModel.name,
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11),
                ),
                SizedBox(
                  height: _scaler.getHeight(0.5),
                ),
                AppText(
                  text: Strings.description,
                  style: AppTextStyle.regular,
                  size: _scaler.getTextSize(10),
                ),
                SizedBox(
                  height: _scaler.getHeight(0.2),
                ),
                AppText(
                  text: widget.args.productModel.description,
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11),
                  color: AppColors.textColorDark.withOpacity(0.8),
                ),
              ],
            ),
          ),
          Divider(
            height: _scaler.getHeight(2),
          ),
          Container(
            padding: _scaler.getPadding(0.3, 3),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    !_userStore.isLoggedIn
                        ? GestureDetector(
                            onTap: () {
                              CommonDialogs.showLoginDialog(context);
                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: AppColors.textColorDark,
                              size: _scaler.getTextSize(14),
                            ),
                          )
                        : LikeWidget(
                            liked:
                                (widget.args.productModel.likedByCurrentUser !=
                                        null) &&
                                    widget.args.productModel.likedByCurrentUser,
                            likeCallback: (isLiked) {
                              Future.delayed(Duration(
                                milliseconds: 1,
                              )).then((value) {
                                setState(() {
                                  if (widget.args.productModel
                                          .likedByCurrentUser ==
                                      null) {
                                    widget.args.productModel
                                        .likedByCurrentUser = false;
                                    // widget.args.productModel.likes=Likes(id: 0,buyerId: int.parse( _userStore.uid), isLiked: false,productId: int.parse(widget.args.productModel.id.toString()));
                                  }
                                  widget.args.productModel.likedByCurrentUser =
                                      isLiked;
                                });
                                isLiked
                                    ? _productStore.addWish(
                                        productId: widget.args.productModel.id
                                            .toString(),
                                        uid: _userStore.uid)
                                    : _productStore.removeWish(
                                        productId: widget.args.productModel.id
                                            .toString(),
                                        uid: _userStore.uid);
                              });
                            },
                          ),
                    SizedBox(
                      width: _scaler.getWidth(1),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.share_outlined,
                        color: AppColors.textColorDark,
                        size: _scaler.getTextSize(14),
                      ),
                      onTap: () async {
                        await FlutterShare.share(
                            title: 'Shopper share to',
                            linkUrl: "https://greetingsworld.page.link/?link=https://greetingsworld.page/?link%3Dproductid=${ widget.args.productModel.merchantId }${"_"}${widget.args.productModel.id}%26apn%3Dcom.greetingsworld.greetings_world_shopper%255B%26ibi%3Dcom.hashtag.shopper%255D%255B%26isi%3D1547560234%255D&apn=com.greetingsworld.greetings_world_shopper&isi=1547560234&ibi=com.hashtag.shopper",
                            chooserTitle: 'Shopper share to');
                      },
                    ),
                    SizedBox(
                      width: _scaler.getWidth(1),
                    ),
                    ImageView(
                      path: Assets.badge,
                      color: AppColors.textColorDark,
                      width: _scaler.getTextSize(14),
                    )
                  ],
                ),
                getProductOptions(widget.args.productModel)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerInfo() {
    return Container(
      padding: _scaler.getPadding(0, 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: Strings.store,
            size: _scaler.getTextSize(11),
            style: AppTextStyle.regular,
          ),
          SizedBox(
            height: _scaler.getHeight(0.3),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: widget.args.merchantModel.name,
                size: _scaler.getTextSize(11),
                style: AppTextStyle.medium,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: AppText(
                  text: Strings.viewSellerProfile,
                  size: _scaler.getTextSize(11),
                  style: AppTextStyle.medium,
                  underline: true,
                  color: AppColors.starYellow,
                ),
              ),
            ],
          ),
          SizedBox(
            height: _scaler.getHeight(0.6),
          ),
          AppText(
            text: widget.args.merchantModel.tagline,
            size: _scaler.getTextSize(10.5),
            style: AppTextStyle.regular,
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        SizedBox(
          height: _scaler.getHeight(4),
        ),
        Container(
          width: _scaler.getWidth(100),
          margin: _scaler.getMargin(1, 3),
          child: MaterialButton(
            height: _scaler.getHeight(3.5),
            padding: _scaler.getPadding(1, 0),
            color: AppColors.buttonBg,
            onPressed: () {
              if (!_userStore.isLoggedIn)
                CommonDialogs.showLoginDialog(context);
              else
                showDeliveryDialog(widget.args.productModel);
            },
            child: AppText(
              text: Strings.addToCart,
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
            shape: RoundedRectangleBorder(
                side: BorderSide(
              width: 1,
              color: AppColors.buttonBg,
            )),
            onPressed: () {
              showReturnPolicyDialog();
            },
            child: AppText(
              text: Strings.viewReturnPolicy,
              color: AppColors.buttonBg,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(11),
            ),
          ),
        )
      ],
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        return _cartStore.errorStore.errorMessage.isNotEmpty
            ? ErrorBar.showMessage(_cartStore.errorStore.errorMessage, context)
            : SizedBox.shrink();
      },
    );
  }

  Widget _handleSuccessMessage() {
    return Observer(
      builder: (context) {
        return _cartStore.successStore.successMessage.isNotEmpty
            ? SuccessBar.showMessage(
                _cartStore.successStore.successMessage, context)
            : SizedBox.shrink();
      },
    );
  }

  showReturnPolicyDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CommonMessageDialog(
              message: widget.args.merchantModel.returnPolicy == null ||
                      widget.args.merchantModel.returnPolicy.name == null
                  ? "No returns for this product"
                  : widget.args.merchantModel.returnPolicy.name,
              title: Strings.returnPolicy,
            ));
  }

  Widget getProductOptions(ProductModel model) {
    return Center(
      child: PopupMenuButton<ProductOptions>(
        onSelected: (selected) {
          if (selected == ProductOptions.favourite) {
            if (!_userStore.isLoggedIn)
              CommonDialogs.showLoginDialog(context);
            else {
              setState(() {
                if (model.favoriteByCurrentUser == null) {
                  model.favoriteByCurrentUser = false;
                  //model.favorites=Favorites(id: 0,buyerId: int.parse( _userStore.uid), isFavorite: false,productId: int.parse(model.id.toString()));
                }

                model.favoriteByCurrentUser = !model.favoriteByCurrentUser;
              });

              model.favoriteByCurrentUser
                  ? _productStore.addFavourite(
                      uid: _userStore.uid, productId: model.id.toString())
                  : _productStore.removeFavourite(
                      uid: _userStore.uid, productId: model.id.toString());
            }
          } else if (selected == ProductOptions.cart) {
            if (!_userStore.isLoggedIn)
              CommonDialogs.showLoginDialog(context);
            else
              showDeliveryDialog(model);
          } else if (selected == ProductOptions.report) {
            if (_userStore.isLoggedIn) {
              setState(() {
                CommonDialogs.showReportDialog(context, (text) {
                  _productStore.addProductReport(
                      uid: _userStore.uid,
                      productId: model.id.toString(),
                      reason: text);
                });
              });
            } else {
              CommonDialogs.showLoginDialog(context);
            }
          }
        },
        child: ImageView(
          path: Assets.more,
          width: _scaler.getTextSize(14),
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<ProductOptions>>[
          PopupMenuItem<ProductOptions>(
            value: ProductOptions.favourite,
            child: AppText(
              text: _userStore.isLoggedIn && model.favoriteByCurrentUser
                  ? 'Remove from favourites'
                  : 'Add to favourites',
            ),
          ),
          PopupMenuItem<ProductOptions>(
            value: ProductOptions.cart,
            child: AppText(
              text: 'Add to cart',
            ),
          ),
          PopupMenuItem<ProductOptions>(
            value: ProductOptions.report,
            child: AppText(
              text: 'Report',
            ),
          )
        ],
      ),
    );
  }

  Future<bool> pop() async {
    Navigator.of(context).pop(widget.args.productModel);
  }

  void showDeliveryDialog(ProductModel model) {
    if (model.deliverTypes != null && model.deliverTypes.isNotEmpty) {
      CommonDialogs.showDeliveryTypeDialog(context, (value) {
        Navigator.pop(context);
        addToCart(value, model);
      }, model.deliverTypes);
    } else {
      addToCart("", model);
    }
  }

  void addToCart(value, ProductModel model) {
    _cartStore.addCart(
        uid: _userStore.uid,
        productId: model.id.toString(),
        deliveryType: value);
  }
}

class ProductDetailArgs {
  final ProductModel productModel;
  final MerchantModel merchantModel;

  ProductDetailArgs({this.merchantModel, this.productModel});
}
