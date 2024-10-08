import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_search_field.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/widget/all_product_widget.dart';

import '../../../provider/theme_provider.dart';




class ProductListMenuScreen extends StatefulWidget {
  const ProductListMenuScreen({Key? key}) : super(key: key);
  @override
  State<ProductListMenuScreen> createState() => _ProductListMenuScreenState();
}

class _ProductListMenuScreenState extends State<ProductListMenuScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final hasPagePushed = Navigator.of(context).canPop();
    int? userId = Provider.of<ProfileProvider>(context, listen: false).userId;
    Provider.of<ProductProvider>(context, listen: false).initSellerProductList(userId.toString(), 1, context, 'en','', reload: true);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('product_list', context)),
      body: Column(
        children: [
          SizedBox(height: 80,
            child: Consumer<ProductProvider>(
                builder: (context, searchProductController, _) {
                  return Container(
                    color: Provider.of<ThemeProvider>(context).darkTheme? Theme.of(context).canvasColor:Theme.of(context).highlightColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                      child: CustomSearchField(
                        controller: searchController,
                        hint: getTranslated('search', context),
                        prefix: Images.iconsSearch,
                        iconPressed: () => (){},
                        onSubmit: (text) => (){},
                        onChanged: (value){
                          if(value.toString().isNotEmpty){
                            searchProductController.initSellerProductList(userId.toString(), 1, context, 'en',value, reload: true);
                          }

                        },
                      ),
                    ),
                  );
                }
            )),
          Expanded(child: ProductView(sellerId: userId))
        ],
      ),

    );
  }
}
