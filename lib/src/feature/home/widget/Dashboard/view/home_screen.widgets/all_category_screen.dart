import 'package:flutter/material.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.arrow_upward),
        ),
        body: SafeArea(
      child: Column(children: [
        const SizedBox(height:25),
        Toolbar(),
        const SizedBox(height:15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search for a professional......',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF7C7C7C), // Adjust hint text color
                  ),
                  fillColor: Theme.of(context).primaryColor,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color(0xFF7C7C7C),
                    size: 32,
                  )),
            ),
          ),
        ),
        Expanded(child: ItemListView()),
      ]),
    ));
  }
}

class Toolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16 ),
          child: Icon(Icons.arrow_back_ios),
        ),
        Expanded(
          child: Center(
            child: Text(
              'All Category',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
}

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    fetchItemsFromApi();
  }

  Future<void> fetchItemsFromApi() async {
    // Simulating network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulating fetched data
    setState(() {
      items = List<String>.generate(20, (index) => 'Item $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: Theme.of(context).primaryColor,
                width: MediaQuery.sizeOf(context).width*0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      color:Colors.blueGrey,
                      child: Center(
                        child:Image.asset('assets/icons/gallery.png')
                      ),
                    ),
                    const SizedBox(height: 3,),
                    Text(
                      items[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
