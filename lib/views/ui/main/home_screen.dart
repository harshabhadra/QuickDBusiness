import 'package:animations/animations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickd_business/utils/Constants.dart';
import 'package:quickd_business/views/ui/main/add_product_ui.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QuikD Business'),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            )
          ],
        ),
        floatingActionButton: OpenContainer(
          openColor: Colors.white,
          closedColor: Colors.white,
          closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          transitionDuration: Duration(milliseconds: 750),
          closedBuilder: (context, openContainer) {
            return FloatingActionButton(
              onPressed: () {
                openContainer();
              },
              child: Icon(Icons.add),
            );
          },
          openBuilder: (context, _) {
            return AddProductScreen();
          },
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32))),
                accountName: Text('Harsha Bhadra'),
                accountEmail: Text('harshasharkey@gmailcom'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('HB'),
                ),
              ),
              ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(
                    Icons.home_outlined,
                  ),
                  onTap: () {}),
              ListTile(
                  title: Text('My Orders',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Icon(
                    Icons.list_alt,
                  ),
                  onTap: () {}),
              ListTile(
                  title: Text('My Products',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Icon(
                    Icons.list,
                  ),
                  onTap: () {}),
              ListTile(
                  title: Text('Share',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Icon(
                    Icons.share_outlined,
                  ),
                  onTap: () {}),
              ListTile(
                  title: Text('Rate Us',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Icon(
                    Icons.rate_review_outlined,
                  ),
                  onTap: () {}),
              ListTile(
                  title: Text('About Us',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Icon(
                    Icons.info_outline,
                  ),
                  onTap: () {}),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: _buildBody());
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45)),
                child: _buildHeader()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Todays Orders',
                style: GoogleFonts.openSans(
                    textStyle: Theme.of(context).textTheme.headline5,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            labelColor: Colors.deepPurple,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: 'Pending',
                                icon: Icon(
                                  Icons.pending_actions,
                                ),
                              ),
                              Tab(
                                text: 'Complete',
                                icon: Icon(
                                  Icons.done_all,
                                  color: Colors.green,
                                ),
                              ),
                              Tab(
                                text: 'Canceled',
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context)
                                .size
                                .height, //height of TabBarView
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(children: <Widget>[
                              Container(child: _buildTodaysOrderList()),
                              Container(child: _buildTodaysOrderList()),
                              Container(
                                  child:
                                      Center(child: _buildTodaysOrderList())),
                            ]))
                      ])),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.deepPurple,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                'Restaurant Name',
                style: GoogleFonts.openSans(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              'Restaurant Address',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 1.0, color: Colors.white),
            ),
            _buildSellHeader()
          ],
        ),
      ),
    );
  }

  Widget _buildSellHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today Revenue',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '₹ 4,6500',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '21 Orders',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Month So Far',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '₹ 4,6500',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '21 Orders',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysOrderList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 60),
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildOrderListItem();
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey,
              height: 1.0,
            );
          },
          itemCount: 10),
    );
  }

  Widget _buildOrderListItem() {
    return Container(
      margin: EdgeInsets.all(8),
      child: ExpandablePanel(
        header: Row(
          children: [
            Text(
              '#1316464631',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pending',
                style: TextStyle(backgroundColor: Colors.yellow),
              ),
            ),
            Spacer(),
            Text(
              '₹ 165',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        collapsed: Row(
          children: [
            Text('07 January, 2021  10.00AM'),
            Spacer(),
            Text(
              '1hr left',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.timer),
            )
          ],
        ),
        expanded: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Order Descriptions....'),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      onPressed: () {},
                      color: Colors.green,
                      child: Text(
                        'Mark As Complete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      onPressed: () {},
                      color: Colors.red,
                      child: Text(
                        'Cancel Order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
