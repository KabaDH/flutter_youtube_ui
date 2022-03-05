import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_ui/data.dart' as data;
import 'package:flutter_youtube_ui/providers.dart';
import 'package:flutter_youtube_ui/widgets/video_card.dart';
import 'package:miniplayer/miniplayer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(data.Assets().ytLogo),
            ),
            leadingWidth: 100,
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            floating: true,
            actions: [
              IconButton(
                  onPressed: () => print('Open channels'),
                  splashRadius: 25,
                  icon: Icon(Icons.cast_connected_outlined)),
              IconButton(
                  onPressed: () => print('Notifications'),
                  splashRadius: 25,
                  icon: Icon(Icons.notifications_none_outlined)),
              IconButton(
                  onPressed: () => print('Search'),
                  splashRadius: 25,
                  icon: Icon(Icons.search)),
              GestureDetector(
                onTap: () => print('Go to User Profile'),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(data.currentUser.profileImageUrl),
                    radius: 19,
                  ),
                ),
              )
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            final _video = data.videos[index];

            return GestureDetector(
              onTap: () {
                ref.read(providerVideo.notifier).setNewVideo(_video);
                ref
                    .read(providerMiniPlayerController)
                    .animateToHeight(state: PanelState.MAX);
              },
              child: BuildVideoCard(
                video: _video,
              ),
            );
          }, childCount: data.videos.length)),
        ],
      ),
    );
  }
}
