import 'dart:io';

import 'package:chatting/data/chat/model/chat_file_model.dart';
import 'package:chatting/data/chat/model/chat_image_model.dart';
import 'package:chatting/presentation/ui/file_picker/thumbnail_image_grid_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/presentation/theming/color_manager.dart';

class FilePickerSheet extends StatefulWidget {
  @override
  _FilePickerSheetState createState() => _FilePickerSheetState();
}

class _FilePickerSheetState extends State<FilePickerSheet> {
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf', 'doc', 'docx']);

    if (result != null) {
      PlatformFile file = result.files.single;
      FileDocumentModel fileModel = FileDocumentModel.fromPlatformFile(file);
      print('File Config name=${file.name} |size=${file.size} type=${file.extension.toString()}');
      Navigator.pop(context,fileModel);
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
                              onPressed: () async{
                                File? imageFile = await selectedAsset?.file;
                                ImageModel selectedImageModel = ImageModel(messageId: '',localUrl: imageFile?.path);
                                print('Selected Asset is => ${selectedImageModel.localUrl}');
                                Navigator.pop(context,selectedImageModel);
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
