import 'package:chatting/presentation/ui/file_picker/thumbnail_image_grid_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/presentation/theming/color_manager.dart';

class ExpandableFilePickerSheet extends StatefulWidget {
  @override
  _ExpandableFilePickerSheetState createState() =>
      _ExpandableFilePickerSheetState();
}

class _ExpandableFilePickerSheetState extends State<ExpandableFilePickerSheet> {
  late final AppLifecycleListener _listener;
  late ScrollController _scrollController;
  List<AssetEntity> mediaFiles = [];
  AssetEntity? selectedAsset;

  bool isLoading = false;
  int currentPageIndex = 0;
  bool settingsScreenIsShown = false;
  bool hasMoreToLoad = true;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(onStateChange: onStateChange);
    checkForFilesPermission();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> onStateChange(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && settingsScreenIsShown) {
      settingsScreenIsShown = false;
      final permState = await PhotoManager.getPermissionState(
          requestOption: PermissionRequestOption());
      if (permState == PermissionState.authorized) {
        fetchGalleryImages();
      } else {
        Navigator.pop(context);
      }
    }
  }

  Future<void> fetchGalleryImages() async {
    if (!hasMoreToLoad || isLoading) return;

    isLoading = true;
    //setState(() => isLoading = true);

    final List<AssetEntity> newMediaFiles =
        await PhotoManager.getAssetListPaged(
      page: currentPageIndex,
      pageCount: 50,
    );

    print('NewMediaFiles length= ${newMediaFiles.length}');

    setState(() {
      mediaFiles.addAll(newMediaFiles);
      isLoading = false;
      hasMoreToLoad = newMediaFiles.isNotEmpty;
      if (hasMoreToLoad) currentPageIndex++;
    });
  }

  Future<void> checkForFilesPermission() async {
    final permission = await PhotoManager.requestPermissionExtend();

    if (permission.isAuth) {
      fetchGalleryImages();
    } else if (permission == PermissionState.denied) {
      settingsScreenIsShown = true;
      PhotoManager.openSetting();
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String filePath = result.files.single.path!;
      print("Selected file: $filePath");
    }
  }

  void selectAsset(AssetEntity selectedAsset) {
    setState(() {
      this.selectedAsset = selectedAsset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        _scrollController = scrollController;
        return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Stack(children: [
                    Column(children: [
                      Expanded(
                          child: GridView.custom(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 3,
                                crossAxisSpacing: 3),
                        childrenDelegate: SliverChildBuilderDelegate(
                          findChildIndexCallback: (Key key) {
                            // Re-use elements.
                            if (key is ValueKey<int>) {
                              print('Current key = ${key.value}');
                              return key.value;
                            }
                            print('Key = ${key.toString()}');
                            return null;
                          },
                          (BuildContext context, int index) {
                            if (index == mediaFiles.length - 3 &&
                                hasMoreToLoad) {
                              fetchGalleryImages();
                            }
                            final AssetEntity entity = mediaFiles[index];

                            return ThumbnailImageGridItem(
                                key: ValueKey(index),
                                asset: entity,
                                isSelected: entity == selectedAsset,
                                onTap: () {
                                  selectAsset(entity);
                                  print('Handle selection');
                                });
                          },
                          childCount: mediaFiles.length,
                        ),
                      )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: pickFile,
                                icon: Icon(Icons.attach_file),
                                label: Text("Pick a Document"),
                              ),
                            ],
                          ))
                    ]),
                    if (selectedAsset != null)
                      Positioned(
                          bottom: 35,
                          right: 16,
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.primary),
                            child: IconButton(
                              color: ColorManager.onPrimary,
                              icon: const Icon(Icons.send, size: 27),
                              onPressed: () {
                                print('Selected Asset is => ${selectedAsset?.id}');
                              },
                            ),
                          ))
                  ]),
                )
              ],
            ));
      },
    );
  }
}
