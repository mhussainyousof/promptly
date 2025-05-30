import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promptly/provider/get_all_messages_provider.dart';
import 'package:promptly/widgets/message_tile.dart';



class MessagesList extends ConsumerWidget {
  const MessagesList({
    super.key,
    required this.userId,
    required this.scrollController
  });

  final String userId;
   final ScrollController scrollController;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageData = ref.watch(getAllMessagesProvider(userId));

    return messageData.when(
      data: (messages) {
        return ListView.builder(
          controller: scrollController,
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages.elementAt(index);

            return MessageTile(
              isOutgoing: message.isMine,
              message: message,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}