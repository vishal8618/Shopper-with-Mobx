import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/menu_options/merchant_options.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/merchants_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/common_dialogs.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';
import 'package:greetings_world_shopper/widgets/common_message_dialog.dart';
import 'package:greetings_world_shopper/widgets/dashboard_loader.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/no_data_error.dart';
import 'package:greetings_world_shopper/widgets/polygon_clipper/polygon_clipper.dart';
import 'package:greetings_world_shopper/widgets/search_field.dart';
import 'package:greetings_world_shopper/widgets/tab_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  TextEditingController searchController;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  MerchantStore _merchantStore;
  UserStore _userStore;
  ScreenScaler _scaler;
  CartStore _cartStore;
  ScrollController _scrollController = ScrollController();
  bool firstTabselected = true;
  String tabSelected = '';

  @override
  void initState() {
    searchController = TextEditingController();
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
    _merchantStore = Provider.of<MerchantStore>(context);
    _userStore = Provider.of<UserStore>(context);
    if (!_merchantStore.loading && Routes.currentRoute == Routes.home)
      _cartStore.getCart(uid: _userStore.uid);
  }

  @override
  Widget build(BuildContext context) {
    if (_scaler == null) {
      _scaler = ScreenScaler()..init(context);
      if (!_merchantStore.loading)
        _merchantStore.getMerchants(tab: "Online", paginated: false);
    }

    return Scaffold(backgroundColor: AppColors.bg, body: _buildBody());
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        _buildTabs(),
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

  Widget _buildSearchBar() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: TextField(
            controller: searchController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: Strings.search,
              prefixIcon: Icon(Icons.search),

            ),
            onChanged: onItemChanged,
          ),
        ),
      ],

      /*  onType: _merchantStore.getSearches,
      onSubmit: (text, close) {
        print('===========>onSubmit');
        DeviceUtils.hideKeyboard(context);

        if (_merchantStore.searchText.isNotEmpty) {
          _merchantStore.addSearch(text);
          _merchantStore.updateSearch(text);
          DeviceUtils.hideKeyboard(context);

        }

      },*/
      /*onSelected: (text) {
        print('===========>onSelected');
        _merchantStore.updateSearch(text);
        DeviceUtils.hideKeyboard(context);
        setState(() {
          searchController.text = text;
        });
      },*/
    );
  }

  Widget _buildTabs() {
    return Observer(builder: (context) {
      return Container(
        color: AppColors.starYellow,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: TabButton(
                text: "Online",
                onPressed: () {
                  searchController.text='';
                  if (!firstTabselected) {
                    firstTabselected = true;
                    _merchantStore.updateTab(0);
                    _merchantStore.updateSearch('');
                    DeviceUtils.hideKeyboard(context);
                  }
                },
                selected: _merchantStore.tab == 0,
              ),
            ),
            Expanded(
              flex: 1,
              child: TabButton(
                text: "Brick and Mortars",
                onPressed: () {
                  searchController.text='';
                  if (firstTabselected) {
                    firstTabselected = false;
                    _merchantStore.updateTab(1);
                    _merchantStore.updateSearch('');
                    DeviceUtils.hideKeyboard(context);
                  }
                },
                selected: _merchantStore.tab == 1,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _merchantStore.loading
            ? CustomProgressDashboardLoaderWidget()
            : _buildListView();
      },
    );
  }

  Widget _buildListView() {
    return _merchantStore.merchantsList != null &&
            _merchantStore.merchantsList.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            itemBuilder: (context, position) {
              return _buildListItem(_merchantStore.merchantsList[position]);
            },
            itemCount: _merchantStore.merchantsList.length,
          )
        : Center(
            child: NoDataError(),
          );
  }

  Widget getMerchantOptions(MerchantModel model) {
    return Center(
      child: PopupMenuButton<MerchantOptions>(
        onSelected: (selected) {
          if (selected == MerchantOptions.follow) {
            if (_userStore.isLoggedIn) {
              setState(() {
                if (model.followers.contains(int.parse(_userStore.uid))) {
                  model.followers.remove(int.parse(_userStore.uid));
                } else {
                  model.followers.add(int.parse(_userStore.uid));
                }
              });

              model.followers.contains(int.parse(_userStore.uid))
                  ? _merchantStore.followMerchant(
                      merchantId: model.id.toString(), uid: _userStore.uid)
                  : _merchantStore.unFollowMerchant(
                      merchantId: model.id.toString(), uid: _userStore.uid);
            } else {
              CommonDialogs.showLoginDialog(context);
            }
          } else if (selected == MerchantOptions.call) {
            phoneClick(model);
          } else if (selected == MerchantOptions.report) {
            if (_userStore.isLoggedIn) {
              setState(() {
                CommonDialogs.showReportDialog(context, (text) {
                  _merchantStore.reportMerchant(
                      uid: _userStore.uid,
                      merchantId: model.id.toString(),
                      reason: text);
                });
              });
            } else {
              CommonDialogs.showLoginDialog(context);
            }
          } else if (selected == MerchantOptions.find_location) {
            //launchMap("Chattanooga, TN, USA");
            _launchMapsUrl(35.045631, -85.309677);
          }
        },
        child: ImageView(
            path: Assets.more,
            color: AppColors.starYellow,
            width: _scaler.getWidth(
              4,
            )),
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<MerchantOptions>>[
          PopupMenuItem<MerchantOptions>(
            value: MerchantOptions.follow,
            child: AppText(
              text: _userStore.isLoggedIn &&
                      model.followers.contains(int.parse(_userStore.uid))
                  ? 'UnFollow'
                  : 'Follow',
            ),
          ),
          PopupMenuItem<MerchantOptions>(
            value: MerchantOptions.call,
            child: AppText(
              text: 'Call',
            ),
          ),
          PopupMenuItem<MerchantOptions>(
            value: MerchantOptions.report,
            child: AppText(
              text: 'Report',
            ),
          ),
          model.mtype.toLowerCase() != "online"
              ? PopupMenuItem<MerchantOptions>(
                  value: MerchantOptions.find_location,
                  child: AppText(
                    text: 'Get Location',
                  ),
                )
              : null
        ],
      ),
    );
  }

  Widget _buildListItem(MerchantModel merchant) {
    return Container(
      margin: _scaler.getMarginLTRB(0, 0, 0, 0.4),
      width: _scaler.getWidth(100),
      decoration: BoxDecoration(
          gradient: AppColors.transParentGradient,
          image: DecorationImage(
              image: merchant.merchantPhoto != null
                  ? NetworkImage(merchant.merchantPhoto)
                  : AssetImage(
                      Assets.logo,
                    ),
              fit: BoxFit.cover)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.splashWhite,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            DeviceUtils.hideKeyboard(context);

            Navigator.of(context).pushNamed(Routes.merchantDetail, arguments: merchant);
          },
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  decoration:
                      BoxDecoration(gradient: AppColors.transParentGradient),
                  height: _scaler.getHeight(20),
                  width: _scaler.getWidth(100),
                ),
              ),
              Container(
                padding: _scaler.getPadding(0, 2),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _scaler.getHeight(1),
                    ),
                    Hero(
                        tag: merchant.id.toString(),
                        child: Container(
                          height: _scaler.getHeight(12),
                          width: _scaler.getHeight(12),
                          child: ClipPolygon(
                            sides: 6,
                            borderRadius: 5.0,
                            boxShadows: [
                              PolygonBoxShadow(
                                  color: Colors.white, elevation: 5.0),
                              // PolygonBoxShadow(color: Colors.white, elevation: 5.0)
                            ],
                            child: ImageView(
                              path: merchant.logo ?? Assets.logo,
                              fit: merchant.logo == null
                                  ? BoxFit.scaleDown
                                  : BoxFit.cover,
                              color: merchant.logo == null
                                  ? AppColors.textColorLight
                                  : null,
                            ),
                          ),
                        )

                        /*   child: RotatedBox(
                        child: ShapeOfView(
                          bgColor: Colors.white,
                          shape: PolygonShape(
                            numberOfSides: 6,

                          ),
                          elevation: 4.0,

                          child: RotatedBox(
                            quarterTurns: -1,
                            child: ImageView(
                              path: merchant.logo ?? Assets.logo,
                              fit: merchant.logo == null
                                  ? BoxFit.scaleDown
                                  : BoxFit.cover,
                              color: merchant.logo == null
                                  ? AppColors.textColorLight
                                  : null,
                              height: _scaler.getHeight(12),
                              width: _scaler.getHeight(12),
                            ),
                          ),
                          height: _scaler.getHeight(12),
                          width: _scaler.getHeight(12),
                        ),
                        quarterTurns: 1,
                      ),*/
                        // transitionOnUserGestures: true,
                        ),

                    /*      ImageView(
                      path: merchant.logo ?? Assets.logo,
                      height: _scaler.getWidth(5),
                      width: _scaler.getWidth(5),
                      border: 1,
                      circleCrop: true,
                      fit:
                      merchant.logo == null ? BoxFit.contain : BoxFit.cover,
                      color:
                      merchant.logo == null ? AppColors.starYellow : null,
                      radius: _scaler.getTextSize(15),
                    ),
*/

                    SizedBox(
                      height: _scaler.getHeight(0.4),
                    ),
                    AppText(
                      text: merchant.name,
                      color: Colors.white.withOpacity(0.9),
                      style: AppTextStyle.medium,
                      size: _scaler.getTextSize(13),
                    ),
                    /*SizedBox(
                      height: _scaler.getHeight(0.2),
                    ),
                    AppText(
                      text: merchant.tagline,
                      color: Colors.white.withOpacity(0.9),
                      style: AppTextStyle.medium,
                      maxLine: 2,
                      size: _scaler.getTextSize(10),
                    ),*/
                    SizedBox(
                      height: _scaler.getHeight(1),
                    ),
                    Container(
                      padding: _scaler.getPaddingLTRB(1, 0, 1, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                initialRating: 4.5,
                                minRating: 0.5,
                                itemSize: 15,
                                direction: Axis.horizontal,
                                unratedColor: AppColors.textColorLight,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => ImageView(
                                  height: _scaler.getWidth(1),
                                  width: _scaler.getWidth(1),
                                  path: Assets.star,
                                  color: AppColors.starYellow,
                                ),
                              ),
                              SizedBox(
                                width: _scaler.getWidth(1),
                              ),
                              AppText(
                                text: "5.0",
                                color: Colors.white.withOpacity(0.9),
                              )
                            ],
                          ),
                          getMerchantOptions(merchant)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _scaler.getHeight(1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _handleErrorMessage() {
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

  phoneClick(MerchantModel model) {
    if (model.phoneActivated) {
      launch("tel:${model.phoneNumber}");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CommonMessageDialog(
                message:
                    "Merchant has not activated yet. Please try again later!",
              ));
    }
  }

  /* void launchMap(String address) async {
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

  onItemChanged(String value) {
    setState(() {
      if (value != null && value.trim().length > 1) {
      //  _merchantStore.addSearch(value);
        _merchantStore.updateSearch(value);
      } else if (value.isEmpty || value.length == 0) {
        _merchantStore.updateSearch('');
      }
    });

  }
}
