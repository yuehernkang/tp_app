import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Content of the DraggableBottomSheet's child SingleChildScrollView
class CustomScrollViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0), topRight: Radius.circular(0))),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: CustomInnerContent(),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // SizedBox(height: 12),
        // CustomDraggingHandle(),
        // SizedBox(height: 16),
        // CustomExploreTemasekPolytechnic(),
        SizedBox(height: 16),
        CustomHorizontallyScrollingRestaurants(),
        SizedBox(height: 24),
        CustomFeaturedListsText(),
        SizedBox(height: 16),
        CustomFeaturedItemsGrid(),
        SizedBox(height: 24),
        CustomRecentPhotosText(),
        SizedBox(height: 16),
        CustomRecentPhotoLarge(),
        SizedBox(height: 12),
        CustomRecentPhotosSmall(),
        SizedBox(height: 16),
      ],
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
    );
  }
}

class CustomExploreTemasekPolytechnic extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const CustomExploreTemasekPolytechnic({Key key, this.snapshot})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Explore Temasek Polytechnic",
            style: TextStyle(fontSize: 22, color: Colors.black)),
        SizedBox(width: 8),
        Container(
          height: 24,
          width: 24,
          child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black54),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
        ),
      ],
    );
  }
}

class CustomHorizontallyScrollingRestaurants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 96,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[500],
                highlightColor: Colors.grey[300],
                enabled: true,
                child: CustomRestaurantCategory(),
              ),
              SizedBox(width: 12),
              Shimmer.fromColors(
                baseColor: Colors.grey[500],
                highlightColor: Colors.grey[100],
                enabled: true,
                child: CustomRestaurantCategory(),
              ),
              SizedBox(width: 12),
              Shimmer.fromColors(
                baseColor: Colors.grey[500],
                highlightColor: Colors.grey[100],
                enabled: true,
                child: CustomRestaurantCategory(),
              ),
              SizedBox(width: 12),
              Shimmer.fromColors(
                baseColor: Colors.grey[500],
                highlightColor: Colors.grey[100],
                enabled: true,
                child: CustomRestaurantCategory(),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFeaturedListsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      //only to left align the text
      child: Row(
        children: <Widget>[
          Text("Featured Lists", style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }
}

class CustomFeaturedItemsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        //to avoid scrolling conflict with the dragging sheet
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.grey[500],
            highlightColor: Colors.grey[300],
            enabled: true,
            child: CustomRestaurantCategory(),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[500],
            highlightColor: Colors.grey[300],
            enabled: true,
            child: CustomRestaurantCategory(),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[500],
            highlightColor: Colors.grey[300],
            enabled: true,
            child: CustomRestaurantCategory(),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[500],
            highlightColor: Colors.grey[300],
            enabled: true,
            child: CustomRestaurantCategory(),
          ),
        ],
      ),
    );
  }
}

class CustomRecentPhotosText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          Text("Recent Photos", style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class CustomRecentPhotoLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomFeaturedItem(),
    );
  }
}

class CustomRecentPhotosSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFeaturedItemsGrid();
  }
}

class CustomRestaurantCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class CustomFeaturedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
