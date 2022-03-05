import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_ui/data.dart' as data;
import 'package:timeago/timeago.dart' as timeago;

class BuildVideoCard extends StatelessWidget {
  final data.Video? video;
  const BuildVideoCard({Key? key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(alignment: Alignment.topCenter, children: [
          Container(
            // color: Colors.purpleAccent,
            height: 230,
            width: double.infinity,
            child: Image.network(
              video!.thumbnailUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding: EdgeInsets.all(4.0),
                color: Colors.black,
                child: Text(
                  video!.duration,
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(data.currentUser.profileImageUrl),
                radius: 23,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      video!.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      '${video!.author.username} ∘ ${video!.viewCount} views ∘ ${timeago.format(video!.timestamp)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey[500]),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => print('video details'),
                child: Icon(
                  Icons.more_vert,
                  size: 20,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
