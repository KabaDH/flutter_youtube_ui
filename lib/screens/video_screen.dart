import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_ui/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_youtube_ui/widgets/widgets.dart';
import 'package:flutter_youtube_ui/data.dart' as data;

class VideoScreen extends HookConsumerWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentVideo = ref.watch(providerVideo);
    final _scrollController = useScrollController();

    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Image.network(
              _currentVideo!.thumbnailUrl,
              width: double.infinity,
              height: 230,
              fit: BoxFit.cover,
            ),
          ),
          SliverToBoxAdapter(
              child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            value: 0.4,
          )),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentVideo.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_currentVideo.viewCount} views • ${timeago.format(_currentVideo.timestamp)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey[500]),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconWithDesc(
                          iconData: Icons.thumb_up_outlined,
                          msg: _currentVideo.likes),
                      IconWithDesc(
                          iconData: Icons.thumb_down_outlined,
                          msg: _currentVideo.dislikes),
                      IconWithDesc(iconData: Icons.share, msg: 'Share'),
                      IconWithDesc(
                          iconData: Icons.download_outlined, msg: 'Download'),
                      IconWithDesc(iconData: Icons.save, msg: 'Save')
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        foregroundImage:
                            NetworkImage(_currentVideo.author.profileImageUrl),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentVideo.author.username,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${_currentVideo.author.subscribers} subscribers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 15, color: Colors.grey[500]),
                          ),
                        ],
                      )),
                      Text(
                        'SUBSCRIBE',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.red, fontSize: 15),
                      )
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            final _videoInList = data.suggestedVideos[index];
            return GestureDetector(
                onTap: () {
                  ref.read(providerVideo.notifier).setNewVideo(_videoInList);
                  _scrollController.jumpTo(0.0);
                },
                child: BuildVideoCard(video: _videoInList));
          }, childCount: data.suggestedVideos.length))
        ],
      ),
    );
  }
}
