import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/dialogs/add_folder_dialog.dart';
import 'package:outfit/src/data/model/favourites_folder.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/widgets/custom_loader.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DressDetailPage extends StatefulWidget {
  final ProductsViewModel? productViewModel;
  final FavFoldersViewModel favFoldersViewModel;
  final FavFoldersViewModel gettingFolderModel;
  final String imageId;
  final String source;
  final int id;
  final bool isFavourite;
  final int index;
  final String page;
  final String loadAd;
  final FavFoldersViewModel loadAdFavFoldersViewModel;
  const DressDetailPage({
    Key? key,
    this.productViewModel,
    required this.favFoldersViewModel,
    required this.dress,
    required this.source,
    required this.imageId,
    required this.id,
    required this.isFavourite,
    required this.index,
    required this.page,
    required this.loadAdFavFoldersViewModel,
    this.loadAd = "false",
    required this.gettingFolderModel,
  }) : super(key: key);

  final String dress;

  @override
  State<DressDetailPage> createState() => _DressDetailPageState();
}

class _DressDetailPageState extends State<DressDetailPage> {
  final String email = AuthLocalDataSource.getEmail();
  final String userid = AuthLocalDataSource.getUserid();
  final String ip = AuthLocalDataSource.getIp();
  bool isFav = false;

  bool isShow = false;

  @override
  void initState() {
    if (email != "") {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<FavFoldersViewModel>(context, listen: false).clearFavImageIds();
      });
      Provider.of<FavFoldersViewModel>(context, listen: false).checkIfFav(
        photoId: widget.id.toString(),
        userId: userid,
      );
    }
    setState(() {
      isFav = widget.isFavourite;
    });
    super.initState();
  }

  void openInstagramProfile(String url) async {
    if (await canLaunchUrl(Uri.parse(url.trim()))) {
      await launchUrl(Uri.parse(url.trim()));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final favourites = Provider.of<FavFoldersViewModel>(context);
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: Navigator.of(context).pop,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(27, 22, 22, 11.5),
                child: Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11.5),
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.dress,
                    height: 460,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(34, 16, 31, 90),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (widget.page == "outfit") {
                                if (widget.productViewModel!.favouriteList.contains(widget.index)) {
                                  widget.productViewModel!.removeFromFavourite(widget.index);
                                  widget.productViewModel!.decrementFromFavourite(widget.index);

                                  widget.productViewModel!.unLikeImageById(
                                    email: email,
                                    ip: ip,
                                    id: widget.imageId,
                                  );
                                } else {
                                  widget.productViewModel!.addFromFavourite(widget.index);
                                  widget.productViewModel!.incrementFromFavourite(widget.index);
                                  widget.productViewModel!.likeImageById(
                                    email: email,
                                    ip: ip,
                                    id: widget.imageId,
                                  );
                                }
                              } else {
                                if (widget.favFoldersViewModel.favouriteList.contains(widget.index)) {
                                  widget.favFoldersViewModel.decrementFromFavourite(widget.index);
                                  widget.favFoldersViewModel.removeFromFavourite(widget.index);
                                  widget.productViewModel!.unLikeImageById(
                                    email: email,
                                    ip: ip,
                                    id: widget.imageId,
                                  );
                                } else {
                                  widget.favFoldersViewModel.incrementFromFavourite(widget.index);
                                  widget.favFoldersViewModel.addFromFavourite(widget.index);
                                  widget.productViewModel!.likeImageById(
                                    email: email,
                                    ip: ip,
                                    id: widget.imageId,
                                  );
                                }
                              }
                              setState(() {});
                            },
                            child: widget.page == "outfit"
                                ? Icon(
                                    widget.productViewModel!.favouriteList.contains(widget.index) ? Icons.favorite : Icons.favorite_border,
                                    color: widget.productViewModel!.favouriteList.contains(widget.index)
                                        ? const Color(0xFFFF2C2C)
                                        : AppColors.blackColor,
                                  )
                                : Icon(
                                    widget.favFoldersViewModel.favouriteList.contains(widget.index) ? Icons.favorite : Icons.favorite_border,
                                    color: widget.favFoldersViewModel.favouriteList.contains(widget.index)
                                        ? const Color(0xFFFF2C2C)
                                        : AppColors.blackColor,
                                  ),
                          ),
                          const SizedBox(width: 10),
                          if (widget.page == "outfit")
                            Text(widget.productViewModel!.likesList[widget.index].toString())
                          else
                            Text(widget.favFoldersViewModel.likesList[widget.index].toString()),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              AppUtils.share(widget.id, currentLanguage.languageCode);
                            },
                            icon: const Icon(
                              Icons.share,
                              color: AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(width: 19.5),
                          IconButton(
                            icon: favourites.favImageIds.contains(widget.id)
                                ? Icon(
                                    Icons.bookmark,
                                    size: 26,
                                    color: favourites.favImageIds.contains(widget.id) ? AppColors.primaryColor : null,
                                  )
                                : const Icon(Icons.bookmark_border),
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CustomBottomSheet(
                                    imageId: widget.imageId,
                                    loadAd: widget.loadAd,
                                    loadAdFavFoldersViewModel: widget.loadAdFavFoldersViewModel,
                                    gettingFoldersModel: widget.gettingFolderModel,
                                    ctx: ctx,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      Text(
                        AppLocalization.of(context)!.getTranslatedValues("source")!,
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
  final BuildContext ctx;
  final String loadAd;
  final FavFoldersViewModel gettingFoldersModel;
  final FavFoldersViewModel loadAdFavFoldersViewModel;
  const CustomBottomSheet(
      {super.key,
      required this.imageId,
      required this.ctx,
      required this.gettingFoldersModel,
      required this.loadAdFavFoldersViewModel,
      this.loadAd = ""});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final String ip = AuthLocalDataSource.getIp();
  final String email = AuthLocalDataSource.getEmail();
  List<int> folderIds = [];
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
    final favourites = Provider.of<FavFoldersViewModel>(context);
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
          padding: const EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalization.of(context)!.getTranslatedValues("addtofolder")!,
                style: const TextStyle(
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
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: value.favFolders.data!.data!
                                      .map((folders) => Column(
                                            children: [
                                              CheckboxListTile(
                                                value: favourites.getFavImageFolderIds.contains(folders.id),
                                                activeColor: AppColors.primaryColor,
                                                onChanged: (_) {
                                                  print(widget.loadAd);
                                                  if (favourites.getFavImageFolderIds.contains(folders.id)) {
                                                    favourites.setRemovefavImageFolderIds(folders.id!, int.parse(widget.imageId));
                                                    favFoldersViewModel.deleteImageToFolderApi(
                                                        id: int.parse(widget.imageId), folderName: folders.list_name!, context: widget.ctx);
                                                    if (widget.loadAd == "yes") {
                                                      widget.loadAdFavFoldersViewModel.favFolderImagesList(
                                                        folderId: folders.id.toString(),
                                                        email: email,
                                                        ip: ip,
                                                      );
                                                      widget.gettingFoldersModel.favFoldersList(
                                                        userId: userId,
                                                      );
                                                    }
                                                  } else {
                                                    favourites.setfavImageFolderIds(folders.id!, int.parse(widget.imageId));
                                                    favFoldersViewModel.addImageToFolderApi(data: {
                                                      "user": userId,
                                                      "list": folders.id,
                                                      "img": widget.imageId,
                                                    }, folderName: folders.list_name!, context: widget.ctx);
                                                  }
                                                  setState(() {});
                                                },
                                                dense: true,
                                                title: Text(folders.list_name!),
                                              ),
                                              const Divider(
                                                height: 1.0,
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                const Divider(
                                  color: AppColors.blackColor,
                                  height: 0.0,
                                ),
                                ListTile(
                                  visualDensity: const VisualDensity(horizontal: -4.0, vertical: 0.0),
                                  dense: true,
                                  leading: const Icon(Icons.add),
                                  onTap: () async {
                                    await AddFolderDialog(
                                      title: AppLocalization.of(context)!.getTranslatedValues("createnewfolder")!,
                                      callback: (_) {
                                        favFoldersViewModel.addFolder(
                                            userId: userId,
                                            data: UpdateFolderData(
                                              user: userId,
                                              list_name: _,
                                              description: "app",
                                              type: "evening",
                                            ));
                                        setState(() {});
                                      },
                                    ).show(context);
                                  },
                                  title: Text(AppLocalization.of(context)!.getTranslatedValues("createfolder")!),
                                ),
                              ],
                            ),
                            favFoldersViewModel.loading ? const CustomLoader() : Container(),
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
