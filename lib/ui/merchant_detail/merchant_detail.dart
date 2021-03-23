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
import 'package:greetings_world_shopper/stores/merchant_detail_store.dart';
import 'package:greetings_world_shopper/stores/merchants_store.dart';
import 'package:greetings_world_shopper/stores/product_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/product_detail/product_detail.dart';
import 'package:greetings_world_shopper/utils/common_decorations.dart';
import 'package:greetings_world_shopper/utils/common_dialogs.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/utils/success_bar.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/call_sms_dialog.dart';
import 'package:greetings_world_shopper/widgets/common_message_dialog.dart';
import 'package:greetings_world_shopper/widgets/detail_tab_button.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/like_button.dart';
import 'package:greetings_world_shopper/widgets/nav_cart_button.dart';
import 'package:greetings_world_shopper/widgets/no_data_error.dart';
import 'package:greetings_world_shopper/widgets/polygon_clipper/polygon_clipper.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:greetings_world_shopper/widgets/shape_of_view/shape/arc.dart';
import 'package:greetings_world_shopper/widgets/shape_of_view/shape_of_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MerchantDetailScreen extends StatefulWidget {
  final MerchantModel merchantInfo;

  MerchantDetailScreen({this.merchantInfo});

  @override
  _MerchantDetailScreenState createState() => _MerchantDetailScreenState();
}

class _MerchantDetailScreenState extends State<MerchantDetailScreen> {
  ScreenScaler _scaler;

  MerchantDetailStore _merchantDetailStore;
  MerchantStore _merchantStore;
  CartStore _cartStore;
  UserStore _userStore;
  ProductStore _productStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _merchantDetailStore = Provider.of<MerchantDetailStore>(context);
    _cartStore = Provider.of<CartStore>(context);
    _userStore = Provider.of<UserStore>(context);
    _productStore = Provider.of<ProductStore>(context);
    _merchantStore = Provider.of<MerchantStore>(context);
    if (!_merchantDetailStore.loading)
      _merchantDetailStore.getProducts(id: widget.merchantInfo.id.toString(),uid: _userStore.uid);
    _merchantDetailStore.updateTab(0);
  }

  @override
  Widget build(BuildContext context) {
    if (_scaler == null) _scaler = ScreenScaler()..init(context);

    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          actions: [
            NavCartButton(
              items: _cartStore.cartItems,
            )
          ],
        ),
        body: Material(
          color: Colors.white,
          child: Stack(
            children: [
              _handleErrorMessage(),
              _handleSuccessMessage(),
              Column(
                children: [_buildHeader(), Expanded(child: _buildBody())],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Container(
      height: _scaler.getHeight(22),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.merchantInfo.merchantPhoto != null)
                Navigator.of(context).pushNamed(Routes.imagePreview,
                    arguments: widget.merchantInfo.merchantPhoto);
            },
            child: ShapeOfView(
              elevation: 4,
              bgColor: AppColors.primaryColor,
              shape: ArcShape(
                height: _scaler.getHeight(5),
                position: ArcPosition.Bottom,
                direction: ArcDirection.Outside,
              ),
              height: _scaler.getHeight(14),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: AppColors.transParentGradient,
                        image: DecorationImage(
                            image: widget.merchantInfo.merchantPhoto != null
                                ? NetworkImage(
                                widget.merchantInfo.merchantPhoto)
                                : AssetImage(
                              Assets.logo,
                            ),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration:
                    BoxDecoration(gradient: AppColors.primaryGradient),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              // top: _scaler.getHeight(7),
              // height: _scaler.getHeight(12),
              // width: _scaler.getHeight(12),
              //  right: 0,
              width: _scaler.getHeight(12),
              height: _scaler.getHeight(12),
              margin: _scaler.getMarginLTRB(0, 6, 0, 0),

              child: Hero(
                tag: widget.merchantInfo.id.toString(),
                child: GestureDetector(
                  onTap: () {
                    if (widget.merchantInfo.logo != null)
                      Navigator.of(context).pushNamed(Routes.imagePreview,
                          arguments: widget.merchantInfo.logo);
                  },
                  child: ClipPolygon(
                    sides: 6,
                    borderRadius: 5.0,
                    child: ImageView(
                      path: widget.merchantInfo.logo ?? Assets.logo,
                      fit: widget.merchantInfo.logo == null
                          ? BoxFit.scaleDown
                          : BoxFit.cover,
                      color: widget.merchantInfo.logo == null
                          ? AppColors.textColorLight
                          : null,
                      height: _scaler.getHeight(12),
                      width: _scaler.getHeight(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildHeaderButtons()
        ],
      ),
    );
  }

  Widget _buildHeaderButtons() {
    return Positioned(
      top: _scaler.getHeight(1),
      left: 0,
      right: 0,
      child: Container(
        width: _scaler.getWidth(100),
        margin: _scaler.getMarginLTRB(12, 0, 4, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _handleErrorFollowMessage(),
            _handleSuccessFollowMessage(),
            GestureDetector(
              onTap: () {
                if (_userStore.isLoggedIn) {
                  setState(() {
                    if (widget.merchantInfo.followers
                        .contains(int.parse(_userStore.uid))) {
                      widget.merchantInfo.followers
                          .remove(int.parse(_userStore.uid));
                    } else {
                      widget.merchantInfo.followers
                          .add(int.parse(_userStore.uid));
                    }
                  });

                  widget.merchantInfo.followers
                      .contains(int.parse(_userStore.uid))
                      ? _merchantStore.followMerchant(
                      merchantId: widget.merchantInfo.id.toString(),
                      uid: _userStore.uid)
                      : _merchantStore.unFollowMerchant(
                      merchantId: widget.merchantInfo.id.toString(),
                      uid: _userStore.uid);
                } else {
                  CommonDialogs.showLoginDialog(context);
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                curve: Curves.linearToEaseOut,
                width: !_userStore.isLoggedIn
                    ? _scaler.getWidth(22)
                    : !widget.merchantInfo.followers
                    .contains(int.parse(_userStore.uid))
                    ? _scaler.getWidth(22)
                    : _scaler.getWidth(25),
                padding: _scaler.getPadding(0.4, 0.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: _scaler.getBorderRadiusCircular(12),
                    border: Border.all(width: 2.0, color: Colors.white),
                    color: !_userStore.isLoggedIn
                        ? Colors.transparent
                        : !widget.merchantInfo.followers
                        .contains(int.parse(_userStore.uid))
                        ? Colors.transparent
                        : AppColors.primaryColor),
                child: AppText(
                  text: !_userStore.isLoggedIn
                      ? Strings.follow
                      : !widget.merchantInfo.followers
                      .contains(int.parse(_userStore.uid))
                      ? Strings.follow
                      : Strings.following,
                  color: Colors.white,
                  style: AppTextStyle.medium,
                  maxLine: 1,
                  size: _scaler.getTextSize(11),
                ),
              ),
            ),
            Row(
              children: [
                CommonDecorations.getSocialIcon(_scaler, Assets.ggIcon),
                SizedBox(
                  width: _scaler.getWidth(1),
                ),
                CommonDecorations.getSocialIcon(_scaler, Assets.twIcon),
                SizedBox(
                  width: _scaler.getWidth(1),
                ),
                CommonDecorations.getSocialIcon(_scaler, Assets.fbIcon),
                SizedBox(
                  width: _scaler.getWidth(1),
                ),
                CommonDecorations.getSocialIcon(_scaler, Assets.igIcon),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Column(
          children: [
            AppText(
              text: widget.merchantInfo.name,
              style: AppTextStyle.title,
              size: _scaler.getTextSize(14),
            ),
            SizedBox(
              height: _scaler.getHeight(0.5),
            ),
            AppText(
              text: widget.merchantInfo.mtype,
              style: AppTextStyle.regular,
              color: AppColors.textColorLight,
              size: _scaler.getTextSize(10),
            ),
            SizedBox(
              height: _scaler.getHeight(
                  widget.merchantInfo.phoneNumber != null &&
                      widget.merchantInfo.phoneNumber != ""
                      ? 0.5
                      : 0),
            ),
            widget.merchantInfo.phoneNumber != null &&
                widget.merchantInfo.phoneNumber != ""
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.call,
                  size: _scaler.getTextSize(11),
                  color: AppColors.starYellow,
                ),
                SizedBox(
                  width: _scaler.getWidth(0.5),
                ),
                GestureDetector(
                  onTap: phoneClick,
                  child: AppText(
                    text: widget.merchantInfo.phoneNumber,
                    style: AppTextStyle.medium,
                    color: AppColors.starYellow,
                    size: _scaler.getTextSize(10),
                  ),
                ),
              ],
            )
                : Container(),
            SizedBox(
              height: _scaler.getHeight(1),
            ),
            Divider(
              thickness: 0.4,
              height: _scaler.getHeight(0.1),
              color: AppColors.bg,
            ),
          ],
        ),
        _buildAnimatedTabs(),
      ],
    );
  }

  Widget _buildAnimatedTabs() {
    return Observer(builder: (context) {
      return Column(
        children: [
          Container(
            width: _scaler.getWidth(100),
            height: _scaler.getHeight(0.8),
            child: Stack(
              children: [
                AnimatedPositioned(
                  height: _scaler.getHeight(0.8),
                  left: _merchantDetailStore.tab == 0
                      ? _scaler.getWidth(20)
                      : _scaler.getWidth(60),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutQuint,
                  child: Container(
                    height: _scaler.getHeight(1),
                    width: _scaler.getWidth(10),
                    decoration: BoxDecoration(
                      borderRadius: _scaler.getBorderRadiusCircular(8.0),
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 0.4,
            height: _scaler.getHeight(0.1),
            color: AppColors.bg,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _scaler.getWidth(35),
                child: DetailTabButton(
                  text: "Information",
                  selected: _merchantDetailStore.tab == 0,
                  onPressed: () {
                    _merchantDetailStore.updateTab(0);
                  },
                ),
              ),
              Container(
                width: _scaler.getWidth(35),
                child: DetailTabButton(
                  text: "Products",
                  selected: _merchantDetailStore.tab == 1,
                  onPressed: () {
                    _merchantDetailStore.updateTab(1);
                  },
                ),
              )
            ],
          ),
          _merchantDetailStore.tab == 0
              ? _buildInformationTab()
              : _buildProductsTab()
        ],
      );
    });
  }

  Widget _buildInformationTab() {
    return Padding(
      padding: _scaler.getPadding(2, 4),
      child: Column(
        children: [
          _buildDetailRow(
              title: "Ratings",
              desc: Row(
                children: [
                  /*RatingBar.builder(
                    initialRating: 4.5,
                    minRating: 0.5,
                    itemSize: 12,
                    direction: Axis.horizontal,
                    unratedColor: AppColors.textColorLight,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                    itemBuilder: (context, _) => ImageView(
                      height: _scaler.getWidth(1),
                      width: _scaler.getWidth(1),
                      path: Assets.star,
                      color: AppColors.starYellow,
                    ),
                  ),
                  SizedBox(
                    width: _scaler.getWidth(1),
                  ),*/
                  AppText(
                    text: "Not available yet",
                    style: AppTextStyle.medium,
                    size: _scaler.getTextSize(10),
                  ),
                ],
              ),
              colorFull: true),
          _buildDetailRow(
              title: "Name",
              desc: Row(
                children: [
                  AppText(
                    text: widget.merchantInfo.name,
                    style: AppTextStyle.medium,
                    size: _scaler.getTextSize(10),
                  ),
                ],
              ),
              colorFull: false),
          _buildDetailRow(
              title: "Tagline",
              desc: AppText(
                text: widget.merchantInfo.tagline,
                style: AppTextStyle.medium,
                size: _scaler.getTextSize(10),
              ),
              colorFull: true),
          widget.merchantInfo.mtype.toLowerCase() != "online"
              ? _buildDetailRow(
              title: "Location",
              desc: Row(
                children: [
                  Expanded(
                    child: AppText(
                      text: widget.merchantInfo.address ?? "",
                      style: AppTextStyle.medium,
                      size: _scaler.getTextSize(10),
                    ),
                  ),
                  InkWell(
                    onTap:(){
                      _launchMapsUrl(35.045631, -85.309677);

                    },
                    child:  ImageView(
                      path: Assets.navigate,
                      width: _scaler.getTextSize(14),
                      color: AppColors.primaryColor1,) ,
                  )


                ],
              ),
              colorFull: false)
              : Container(
            width: 0,
          ),
          _buildDetailRow(
              title: "Website",
              desc: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.webView,
                      arguments: widget.merchantInfo.website);
                },
                child: AppText(
                  text: widget.merchantInfo.website ?? "",
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(10),
                  underline: true,
                ),
              ),
              colorFull: widget.merchantInfo.mtype.toLowerCase() != "online"),
        ],
      ),
    );
  }

  Widget _buildDetailRow({String title, Widget desc, bool colorFull}) {
    return Container(
      color:
      colorFull ? AppColors.textColorLight.withOpacity(0.1) : Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 3,
              child: Container(
                padding: _scaler.getPadding(0.7, 0),
                alignment: Alignment.center,
                child: AppText(
                  text: title,
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(10),
                ),
              )),
          Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: AppColors.textColorLight, width: 0.5))),
                padding: _scaler.getPadding(0.7, 2),
                alignment: Alignment.centerLeft,
                child: desc,
              ))
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return Observer(
      builder: (context) {
        return _merchantDetailStore.loading
            ? Container(
            margin: _scaler.getMargin(4, 0),
            child: CustomProgressIndicatorWidget(
              full: false,
            ))
            : _buildProductsList();
      },
    );
  }

  Widget _buildProductsList() {
    return _merchantDetailStore.productsList != null &&
        _merchantDetailStore.productsList.length > 0
        ? ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: _scaler.getPadding(1, 0),
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return _buildListItem(
            _merchantDetailStore.productsList[position]);
      },
      itemCount: _merchantDetailStore.productsList.length,
    )
        : Container(margin: _scaler.getMargin(3, 0), child: NoDataError());
  }

  Widget _buildListItem(ProductModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.productDetail,
            arguments: ProductDetailArgs(
                productModel: product, merchantModel: widget.merchantInfo))
            .then((value) {
          var data = value as ProductModel;
          _merchantDetailStore.productsList
              .lastWhere((element) => element.id == data.id)
              .likes = data.likes;

          _merchantDetailStore.productsList
              .lastWhere((element) => element.id == data.id)
              .favorites = data.favorites;


          setState(() {});
        });
      },
      child: Container(
        margin: _scaler.getMarginLTRB(0, 0, 0, 2),
        decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: _scaler.getBorderRadiusCircular(6)),
        child: Column(
          children: [
            Card(
              elevation: 0.2,
              child: Container(
                color: AppColors.bg,
                width: _scaler.getWidth(100),
                child: Stack(
                  children: [
                    Hero(
                      tag: "product_${product.id.toString()}",
                      child: ImageView(
                        path: product.productPhoto,
                        height: _scaler.getHeight(20),
                        width: _scaler.getWidth(100),
                        fit: BoxFit.cover,
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
                            text: "\$${product.price}",
                            style: AppTextStyle.medium,
                            size: _scaler.getTextSize(11),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              padding: _scaler.getPadding(0.3, 3),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: product.name,
                        style: AppTextStyle.regular,
                        size: _scaler.getTextSize(11),
                      ),
                      SizedBox(
                        height: _scaler.getHeight(0.5),
                      ),
                      Row(
                        children: [
                          _handleErrorLikeMessage(),
                          _handleSuccessLikeMessage(),
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
                            (product.likedByCurrentUser != null) && product.likedByCurrentUser,
                            likeCallback: (isLiked) {
                              Future.delayed(Duration(
                                milliseconds: 1,
                              )).then((value) {
                                setState(() {
                                  if(product.likedByCurrentUser==null){
                                    //product.likes=Likes(id: 0,buyerId: int.parse( _userStore.uid), isLiked: false,productId: int.parse(product.id.toString()));
                                    product.likedByCurrentUser=false;
                                  }

                                  product.likedByCurrentUser = isLiked;
                                });
                                isLiked
                                    ? _productStore.addWish(
                                    productId: product.id.toString(),
                                    uid: _userStore.uid)
                                    : _productStore.removeWish(
                                    productId: product.id.toString(),
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
                                  linkUrl: product.url,
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
                      )
                    ],
                  ),
                  getProductOptions(product)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_merchantDetailStore.errorStore.errorMessage.isNotEmpty) {
          return ErrorBar.showMessage(
              _merchantDetailStore.errorStore.errorMessage, context);
        }
        return SizedBox.shrink();
      },
    );
  }

  phoneClick() {
    if (widget.merchantInfo.phoneActivated) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CallSMSDialog(
            callClick: () {
              launch("tel:${widget.merchantInfo.phoneNumber}");
              Navigator.of(context).pop();
            },
            smsClick: () {
              launch("sms:${widget.merchantInfo.phoneNumber}");
              Navigator.of(context).pop();
            },
            cancelClick: () {
              Navigator.of(context).pop();
            },
          ));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CommonMessageDialog(
            message:
            "Merchant has not activated yet. Please try again later!",
          ));
    }
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
                if(model.favoriteByCurrentUser==null){
                 // model.favorites=Favorites(id: 0,buyerId: int.parse( _userStore.uid), isFavorite: false,productId: int.parse(model.id.toString()));
                  model.favoriteByCurrentUser= false;
                }

               model.favoriteByCurrentUser = !model.favoriteByCurrentUser;
              });

              print( model.favoriteByCurrentUser);

             model.favoriteByCurrentUser
                  ? _productStore.addFavourite(
                  uid: _userStore.uid, productId: model.id.toString())
                  : _productStore.removeFavourite(
                  uid: _userStore.uid, productId: model.id.toString());
            }
          }
          else if (selected == ProductOptions.cart) {
            if (!_userStore.isLoggedIn)
              CommonDialogs.showLoginDialog(context);
            else
              _cartStore.addCart(
                  uid: _userStore.uid, productId: model.id.toString());
          } else if (selected == ProductOptions.report) {
            if (_userStore.isLoggedIn) {
              setState(() {
                CommonDialogs.showReportDialog(context, (text) {
                  _productStore.addMerchantReport(
                      uid: _userStore.uid,
                      merchantId: model.id.toString(),
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

          ),
        ],
      ),
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


  Widget _handleSuccessFollowMessage() {
    return Observer(
      builder: (context) {
        return _merchantStore.successStore.successMessage.isNotEmpty
            ? SuccessBar.showMessage(
            _merchantStore.successStore.successMessage, context)
            : SizedBox.shrink();
      },
    );
  }

  Widget _handleErrorFollowMessage() {
    return Observer(
      builder: (context) {
        if (_merchantStore.errorStore.errorMessage.isNotEmpty) {
          return ErrorBar.showMessage(
              _merchantStore.errorStore.errorMessage, context);
        }
        return SizedBox.shrink();
      },
    );
  }


  Widget _handleSuccessLikeMessage() {
    return Observer(
      builder: (context) {
        return _productStore.successStore.successMessage.isNotEmpty
            ? SuccessBar.showMessage(
            _productStore.successStore.successMessage, context)
            : SizedBox.shrink();
      },
    );
  }

  Widget _handleErrorLikeMessage() {
    return Observer(
      builder: (context) {
        if (_productStore.errorStore.errorMessage.isNotEmpty) {
          return ErrorBar.showMessage(
              _productStore.errorStore.errorMessage, context);
        }
        return SizedBox.shrink();
      },
    );
  }

/*  void launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }*/

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
