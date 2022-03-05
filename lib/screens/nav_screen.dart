import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_ui/providers.dart';
import 'package:flutter_youtube_ui/screens/home_screen.dart';
import 'package:flutter_youtube_ui/screens/video_screen.dart';
import 'package:miniplayer/miniplayer.dart';

class NavScreen extends ConsumerWidget {
  NavScreen({Key? key}) : super(key: key);

  final screens = [
    HomeScreen(),
    Scaffold(
      body: Center(child: Text('Explore')),
    ),
    Scaffold(
      body: Center(child: Text('Add')),
    ),
    Scaffold(
      body: Center(child: Text('Subscriptions')),
    ),
    Scaffold(
      body: Center(child: Text('Library')),
    ),
  ];

  final navOptions = ['Home', 'Explore', 'Add', 'Subscriptions', 'Library'];

  final navIconsSelected = [
    Icons.home,
    Icons.explore,
    Icons.add_circle,
    Icons.subscriptions,
    Icons.video_library
  ];
  final navIconsUnSelected = [
    Icons.home_outlined,
    Icons.explore_outlined,
    Icons.add_circle_outlined,
    Icons.subscriptions_outlined,
    Icons.video_library_outlined
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentScreen = ref.watch(providerScreenIndex);
    final _currentVideo = ref.watch(providerVideo);
    final _minHeight = 70.0;
    final _miniPlayerController = ref.watch(providerMiniPlayerController);

    return Scaffold(
        body: Stack(children: [
          IndexedStack(
            children: screens,
            index: _currentScreen,
          ),
          Offstage(
            offstage: _currentVideo == null,
            child: _currentVideo == null
                ? SizedBox.shrink()
                : Miniplayer(
                    controller: _miniPlayerController,
                    minHeight: _minHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (height == _minHeight)
                        return Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  _currentVideo.thumbnailUrl,
                                  width: 125,
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _currentVideo.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        _currentVideo.author.username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.grey[500]),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => print('Play'),
                                  icon: Icon(Icons.play_arrow),
                                ),
                                IconButton(
                                  onPressed: () => ref
                                      .read(providerVideo.notifier)
                                      .setNewVideo(null),
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            LinearProgressIndicator(
                              value: 0.4,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                              minHeight: 5,
                            )
                          ],
                        );
                      else {
                        return VideoScreen();
                      }
                    }),
          ),
        ]),
        bottomNavigationBar: Theme(
          data:
              Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
          child: BottomNavigationBar(
              currentIndex: _currentScreen,
              type: BottomNavigationBarType.fixed,
              iconSize: 23,
              onTap: (index) {
                ref.read(providerScreenIndex.notifier).selectNewScreen(index);
                ref
                    .read(providerMiniPlayerController)
                    .animateToHeight(height: _minHeight);
              },
              items: screens
                  .asMap()
                  .map((index, e) => MapEntry(
                      index,
                      BottomNavigationBarItem(
                          icon: Icon(navIconsUnSelected[index]),
                          label: navOptions[index],
                          activeIcon: Icon(navIconsSelected[index]))))
                  .values
                  .toList()),
        ));
  }
}
