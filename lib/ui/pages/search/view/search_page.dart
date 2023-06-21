import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/data.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../generated/locale_keys.g.dart';

class SearchPage extends StatefulWidget {
  static const id = 'SearchPage';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static List<MyPlaylist> filteredProducts =
      LocalPlaylistsRepository.localPlaylists;
  final TextEditingController _searchController = TextEditingController();
  Color _prefixIconColor = AppColors.greyColor;

  void _filterProducts(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredProducts = LocalPlaylistsRepository.localPlaylists
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredProducts = List.from(LocalPlaylistsRepository.localPlaylists);
      }
    });
  }

  @override
  void initState() {
    filteredProducts = List.from(LocalPlaylistsRepository.localPlaylists);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      needAnotherBottomHeight: true,
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
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 2.0),
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
        PlaylistsWrap(
          fromPage: 'search_page',
          item: filteredProducts,
          pagingController: PagingController<int, MyPlaylist>(
            firstPageKey: 1,
          ),
        ),
      ],
    );
  }
}
