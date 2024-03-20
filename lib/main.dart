import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePageContent(),
    FriendsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.blue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.message, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Oleksandr Khvostov'),
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Friends'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FriendsPage()));
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.message),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyHomePageContent extends StatelessWidget {
  const MyHomePageContent({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                'News Feed',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const PostWidget(
            avatarImage: 'assets/user_avatar.jpg',
            userName: 'Oleksandr Khvostov',
            postTime: '2 hours ago',
            postText: 'Cute puppy',
            imagePath: 'assets/cute-little-puppy.jpg',
            heroTag: 'post1',
          ),
          const PostWidget(
            avatarImage: 'assets/mrRobotsAvatar.jpg',
            userName: 'MrRobot',
            postTime: '3 hours ago',
            postText: 'A little bit about Meta',
            imagePath: 'assets/metaPost.jpg',
            heroTag: 'post2',
          ),
        ],
      ),
    );
  }
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends Page', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('You don\'t have any friends yet:('),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(''),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String avatarImage;
  final String userName;
  final String postTime;
  final String postText;
  final String imagePath;
  final String heroTag;

  const PostWidget({
    super.key,
    required this.avatarImage,
    required this.userName,
    required this.postTime,
    required this.postText,
    required this.imagePath,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(avatarImage),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(postTime, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              postText,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_up),
                        onPressed: () {},
                      ),
                      const Text('Like'),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {},
                      ),
                      const Text('Comment'),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {},
                      ),
                      const Text('Share'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}