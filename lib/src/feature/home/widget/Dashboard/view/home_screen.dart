import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/feature/home/widget/Dashboard/view/home_screen.widgets/homescreen_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: HomescreenHeader()),
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Categories',
                  actionText: 'See All',
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverToBoxAdapter(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 4,
                    children: List.generate(4, (index) => _buildGridTile(index)),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Recommended',
                  actionText: 'More',
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return _buildListItem(index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridTile(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 0.45,
          height: MediaQuery.sizeOf(context).height * 0.18,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Image.asset('assets/icons/gallery.png'),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Category title',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildListItem(int index) {
    return Container(
      width: MediaQuery.sizeOf(context).width*0.75,
      margin: EdgeInsets.only(left:5, right:5),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:Color(0xFF525252),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Image.asset('assets/icons/gallery.png'),
            ),
            title: Text('Title Text',style: TextStyle(color: Colors.white),),
            subtitle: Text('Subtitle Text',style: TextStyle(color: Colors.white),),
          ),
          const SizedBox(height: 10),
          Text(
            'This is some additional text below the ListTile. It can span multiple lines and provide further information.',
            style: TextStyle(fontSize: 14,color: Colors.white),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < 4 ? Icons.star : Icons.star_border, // 4 stars filled, 1 star border
                    color: Colors.amber,
                    size: 20,
                  );
                }),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(40, 40)
                ),
                child: Text('Book'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;

  const _SectionHeader({
    required this.title,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                actionText,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
