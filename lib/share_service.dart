import 'package:flutter/material.dart';
import 'package:share_example/second_screen.dart';
import 'package:share_handler/share_handler.dart';
import 'package:path/path.dart' show extension;

Future<void> shareHandlerService(BuildContext context, bool mounted) async {
  final handler = ShareHandlerPlatform.instance;
  _processMedia(context, await handler.getInitialSharedMedia(), mounted);

  handler.sharedMediaStream.listen((SharedMedia newMedia) {
    _processMedia(context, newMedia, mounted);
  });
}

Future _processMedia(BuildContext screenContext, SharedMedia? media, bool mounted) async {
  if (!mounted || media == null) return;
  return await showDialog<dynamic>(
      context: screenContext,
      builder: (context) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Share dialog"),
                    if (media.content?.isNotEmpty ?? false) Text(media.content ?? ""),
                    shareAttachmentsWidget(media.attachments, context)
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.push(context, SecondScreen.route(content: media.content, attachments: media.attachments)).then((value) => Navigator.pop(context)),
                  child: const Text("Send media to next page"))
            ],
          ),
        );
      }
  );
}

Widget shareAttachmentsWidget(List<SharedAttachment?>? attachments, BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
        children: attachments != null
            ? attachments
            .map((attachment) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Image.network("https://via.placeholder.com/80x100?text=${extension(attachment!.path.toLowerCase())}"),
        ))
            .toList()
            : []));