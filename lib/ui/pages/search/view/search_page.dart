import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/models/playlist.dart';

import '../../../../generated/locale_keys.g.dart';

class SearchPage extends StatefulWidget {
  static const id = 'SearchPage';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  static List<MyPlaylist> filteredProducts = <MyPlaylist>[];
  final TextEditingController _searchController = TextEditingController();
  Color _prefixIconColor = AppColors.greyColor;

  void _filterProducts(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredProducts = <MyPlaylist>[];
      } else {
        filteredProducts = <MyPlaylist>[];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MyPadding.horizontalPadding,
                vertical: 5.h,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).dialogBackgroundColor,
                  hintText: LocaleKeys.hint_search_text.tr(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).disabledColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 2.0),
                  ),
                  prefixIcon: Container(
                    margin: EdgeInsets.all(2.5.h),
                    child: SvgPicture.asset(
                      '${iconsPath}search.svg',
                      color: _prefixIconColor,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // prefixIconColor: Colors.red,
                ),
                cursorColor: AppColors.primaryColor,
                textCapitalization: TextCapitalization.sentences,
                enableSuggestions: false,
                autocorrect: false,
                onChanged: (value) {
                  setState(() {
                    // изменяем цвет префиксной иконки на синий, если поле поиска не пустое
                    _prefixIconColor = value.isNotEmpty
                        ? AppColors.primaryColor
                        : AppColors.greyColor;
                    log('$_prefixIconColor');
                  });
                  _filterProducts(value);
                },
              ),
            ),
            /*PlaylistsWrap(
          fromPage: 'search_page',
          item: filteredProducts,
          pagingController: PagingController<int, MyPlaylist>(
            firstPageKey: 1,
          ),
        ),*/
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
