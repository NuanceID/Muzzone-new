import 'package:flutter/material.dart';
import 'package:muzzone/data/data.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config.dart';

class MySearchString extends StatefulWidget {
  const MySearchString({
    Key? key,
  }) : super(key: key);

  @override
  State<MySearchString> createState() => _MySearchStringState();
}

class _MySearchStringState extends State<MySearchString> {
  List<MyPlaylist> filteredProducts = LocalPlaylistsRepository.localPlaylists;
  final TextEditingController _searchController = TextEditingController();

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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPadding.horizontalPadding,
        vertical: 5.h,
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: _filterProducts,
      ),

      // GestureDetector(
      //   onTap: () => showSearch(
      //       context: context,
      //       delegate: MySearchDelegate(searchResult: [
      //         'Плейлист 1',
      //         'Мой плейлист',
      //         'Какой-то плейлист',
      //         'Плейлист лист',
      //         'Плейлист Максим',
      //       ])),
      //   child: Container(
      //     width: double.infinity,
      //     height: 6.h,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey.withOpacity(0.2),
      //           spreadRadius: 2,
      //           blurRadius: 2,
      //           offset: const Offset(0, 0), // changes position of shadow
      //         ),
      //       ],
      //       borderRadius: BorderRadius.circular(
      //         15,
      //       ),
      //       border: Border.all(
      //         width: 1,
      //         color: AppColors.greyColor.withOpacity(0.2),
      //       ),
      //     ),
      //     child: Row(
      //       children: [
      //         Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 5.w),
      //           child: SvgPicture.asset('${iconsPath}search.svg'),
      //         ),
      //         Text(
      //           LocaleKeys.hint_search_text.tr(),
      //           style: const TextStyle(
      //             color: AppColors.greyColor,
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
