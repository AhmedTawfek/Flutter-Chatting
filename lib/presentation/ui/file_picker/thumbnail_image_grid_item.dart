import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../core/presentation/theming/color_manager.dart';

class ThumbnailImageGridItem extends StatefulWidget {

  final AssetEntity asset;
  final bool isSelected;
  final VoidCallback onTap;

   const ThumbnailImageGridItem({
    required Key key,
    required this.isSelected,
    required this.asset,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ThumbnailImageGridItem> createState() => _ThumbnailImageGridItemState();
}

class _ThumbnailImageGridItemState extends State<ThumbnailImageGridItem> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    final imageDataResult = await widget.asset.thumbnailDataWithSize(ThumbnailSize(200, 200));

    if (!mounted){
      // We are checking if we can update the state or not
      // Not mounted means the state is disposed or closed,
      // So, its not correct to update the state even if it doesn't exist.
      print('Not mounted !');
      return;
    }

    setState(() {
      imageData = imageDataResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageData != null
              ? Image.memory(imageData!, fit: BoxFit.cover)
              : Container(color: Colors.grey[200]),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: widget.isSelected ? ColorManager.red : Colors.transparent,width: 3),
                borderRadius: BorderRadius.circular(0)),
          )
        ],
      ),
    );
  }
}