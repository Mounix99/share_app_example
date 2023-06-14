import 'package:flutter/material.dart';
import 'package:share_example/share_service.dart';
import 'package:share_handler/share_handler.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key, this.content, this.attachments});

  final String? content;
  final List<SharedAttachment?>? attachments;

  static Route<void> route({String? content, List<SharedAttachment?>? attachments}) =>
      MaterialPageRoute<void>(builder: (context) =>
          SecondScreen(content: content, attachments: attachments));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen"), backgroundColor: Colors.amber),
      body: _checkSharedContent(context),
    );
  }


  Widget _checkSharedContent(BuildContext context){
    if (content != null || (attachments != null && attachments!.isNotEmpty)){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (content != null) ...[
            Text(content!),
            const SizedBox(height: 16),
          ],
          if (attachments != null && attachments!.isNotEmpty) ...[
            shareAttachmentsWidget(attachments, context)
          ]
        ],
      );
    } else {
      return const Center(
        child: Text("Something typed here..."),
      );
    }
  }
}
