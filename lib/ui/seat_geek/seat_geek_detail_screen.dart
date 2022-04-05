import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../api/entities/event.dart';

class SeatGeekDetailScreen extends StatefulWidget {
  SeatGeekDetailScreen({required this.event, required this.onLike, Key? key})
      : super(key: key);

  final Event event;
  final VoidCallback onLike;

  @override
  State<SeatGeekDetailScreen> createState() => _SeatGeekDetailScreenState();
}

class _SeatGeekDetailScreenState extends State<SeatGeekDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AppBarState(
                event: widget.event,
                onLike: () {
                  setState(() {
                    widget.onLike();
                  });
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              _ImageView(event: widget.event),
              const SizedBox(
                height: 20,
              ),
              _DateTimeAndLocationView(event: widget.event),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({required this.event, Key? key}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    final isImageNotEmpty = event.performers.isNotEmpty
        ? event.performers.first.image.isNotEmpty
        : false;
    return isImageNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: event.performers.isNotEmpty
                    ? event.performers.first.image
                    : '',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          )
        : const Icon(Icons.error);
  }
}

class _DateTimeAndLocationView extends StatelessWidget {
  const _DateTimeAndLocationView({
    required this.event,
    Key? key,
  }) : super(key: key);
  final Event event;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.localDateTime,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          event.venue.displayLocation,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _AppBarState extends StatelessWidget {
  const _AppBarState({
    required this.event,
    required this.onLike,
    Key? key,
  }) : super(key: key);
  final Event event;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: Text(
            event.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        IconButton(
          onPressed: onLike,
          icon: event.isLiked
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border, color: Colors.blue),
        )
      ],
    );
  }
}
