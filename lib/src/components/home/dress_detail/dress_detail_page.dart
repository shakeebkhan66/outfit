import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/auth/social_auth_page.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/widgets/custom_loader.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DressDetailPage extends StatefulWidget {
  final ProductsViewModel? productViewModel;
  final FavFoldersViewModel? favFoldersViewModel;
  final String imageId;
  final String source;
  final String url;
  final bool isFavourite;
  final int index;
  final String page;
  const DressDetailPage({
    Key? key, 
    this.productViewModel,
    this.favFoldersViewModel,
    required this.dress,
    required this.source,
    required this.imageId,
    required this.url,
    required this.isFavourite,
    required this.index,
    required this.page,
  }) : super(key: key);

  final String dress;

  @override
  State<DressDetailPage> createState() => _DressDetailPageState();
}

class _DressDetailPageState extends State<DressDetailPage> {

  final String email = AuthLocalDataSource.getEmail();
  final String ip = AuthLocalDataSource.getIp();
  bool isFav = false;

  @override
  void initState() {
    setState(() {
      print(widget.isFavourite);
      isFav = widget.isFavourite;
    });
    super.initState();
  }
  Future<void> _share(String file) async {
      await Share.share(file);
  }
  void openInstagramProfile(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: Navigator.of(context).pop,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(27, 22, 0, 11.5),
                child: Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11.5),
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(widget.dress,
                    height: 460,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(34, 16, 31, 90),
                  child: Row(children: [
                    GestureDetector(
                      onTap: (){
                        if(isFav){
                          isFav = false;
                            if(widget.page == "outfit"){
                              widget.productViewModel!.decrementFromFavourite(widget.index);
                            } else {
                              widget.favFoldersViewModel!.decrementFromFavourite(widget.index);
                            }
                            widget.productViewModel!.unLikeImageById(
                              email: email,
                              ip: ip,
                              id: widget.imageId,
                            );
                          }else {
                            isFav = true;
                            if(widget.page == "outfit") {
                             widget.productViewModel!.incrementFromFavourite(widget.index);
                            } else {
                              widget.favFoldersViewModel!.incrementFromFavourite(widget.index);
                            }
                            widget.productViewModel!.likeImageById(
                              email: email,
                              ip: ip,
                              id: widget.imageId,
                            );
                          }
                          setState(() {});
                      },
                      child: Icon(isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: (isFav
                          ? const Color(0xFFFF2C2C)
                          : AppColors.blackColor),
                        ),
                    ),
                    const SizedBox(width: 10),
                    if(widget.page == "outfit")
                    Text(widget.productViewModel!.likesList[widget.index].toString())
                    else
                    Text(widget.favFoldersViewModel!.likesList[widget.index].toString()),
                    const Spacer(),
                    IconButton(
                      onPressed: (){
                        _share(widget.url);
                      },
                      icon: const Icon(
                        Icons.share,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(width: 19.5),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border, size: 26),
                      onPressed: (){
                        if(email == "") {
                          AppNavigation.to(context, const SocialAuthPage());
                        }else {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return CustomBottomSheet(imageId: widget.imageId);
                            },
                          );
                        }
                      },
                    ),
                  ]),
                ),
                InkWell(
                  onTap: () {
                    openInstagramProfile(widget.source);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.fromLTRB(42.5, 15.67, 44.17, 15.67),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(AppLocalization.of(context)!.getTranslatedValues("source")!,
                        style: GoogleFonts.roboto(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8C8C8C),
                        ),
                      ),
                      const SizedBox(width: 9.67),
                      Image.asset(AppAssets.instagram, height: 16.67, width: 16.67),
                    ]),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  final String imageId;

  const CustomBottomSheet({super.key, required this.imageId});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final FavFoldersViewModel favFoldersViewModel = FavFoldersViewModel();
  final String userId = AuthLocalDataSource.getUserid();

  @override
  void initState() {
    favFoldersViewModel.favFoldersList(
      userId: userId,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add to Folder",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12.0),
              ChangeNotifierProvider.value(
                value: favFoldersViewModel,
                child: Consumer<FavFoldersViewModel>(
                  builder: (context, value, child) {
                    switch (value.favFolders.status!) {
                      case Status.completed:
                        return value.favFolders.data!.data!.isEmpty ? const Text("No folders added"): Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: value.favFolders.data!.data!.map((folders) => 
                              Column(
                                children: [
                                  ListTile(
                                    onTap: (){
                                      favFoldersViewModel.addImageToFolderApi(
                                        data: {
                                        "user": userId,
                                        "list": folders.id,
                                        "img": widget.imageId,
                                      },
                                      folderName: folders.list_name!,
                                      context: context);
                                    },
                                    dense: true,
                                    title: Text(folders.list_name!),
                                  ),
                                  const Divider(
                                    height: 1.0,
                                  ),
                                ],
                              )).toList(),
                            ),
                            favFoldersViewModel.loading ?
                            const CustomLoader():
                            Container(),
                          ],
                        );
                      case Status.loading:
                      return const FolderShimmerLoader();
                      case Status.error:
                      return const Text("Error");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
