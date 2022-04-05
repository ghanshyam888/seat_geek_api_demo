import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/entities/event.dart';
import '../../blocs/seat_geek_list/seat_geek_list_bloc.dart';
import '../../blocs/seat_geek_list/seat_geek_list_contract.dart';
import '../../core/base_state.dart';
import '../../core/screen_state.dart';
import '../../core/utils/colors.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../common/full_screen_error.dart';
import '../common/full_screen_loader.dart';
import 'seat_geek_detail_screen.dart';

class SeatGeekListScreen extends StatefulWidget {
  const SeatGeekListScreen({Key? key}) : super(key: key);

  @override
  _SeatGeekListScreenState createState() => _SeatGeekListScreenState();
}

class _SeatGeekListScreenState
    extends BaseState<SeatGeekListBloc, SeatGeekListScreen> {
  final _searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(InitEvent());
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeatGeekListBloc>(
      create: (BuildContext context) => bloc,
      child: BlocBuilder<SeatGeekListBloc, SeatGeekListData>(
        builder: (BuildContext context, SeatGeekListData data) {
          return Scaffold(
            appBar: AppBar(
              title: _AppBar(
                data: data,
                searchTextEditingController: _searchTextEditingController,
              ),
            ),
            body: _SeatGeekListContent(data: data),
          );
        },
      ),
    );
  }

  @override
  void onViewEvent(ViewAction event) {
    switch (event.runtimeType) {
      case NavigateScreen:
        final screen = event as NavigateScreen;
        switch (screen.target) {
          case SeatGeekTarget.seatGeekDetailScreen:
            unawaited(
              context.push(
                builder: (context) => SeatGeekDetailScreen(
                  event: event.data as Event,
                  onLike: () {
                    bloc.add(LikeDislikeEvent(event: (event.data as Event)));
                  },
                ),
              ),
            );
        }
    }
  }
}

class _SeatGeekListContent extends StatelessWidget {
  const _SeatGeekListContent({required this.data, Key? key}) : super(key: key);

  final SeatGeekListData data;

  @override
  Widget build(BuildContext context) {
    switch (data.state) {
      case ScreenState.loading:
        return const FullScreenLoader();
      case ScreenState.content:
        return _SeatGeekList(data: data);

      case ScreenState.empty:
        return _EmptySeatGeekList(
          data: data,
        );
      default:
        return FullScreenError(message: data.errorMessage!, onRetryTap: () {});
    }
  }
}

class _EmptySeatGeekList extends StatelessWidget {
  const _EmptySeatGeekList({required this.data, Key? key}) : super(key: key);

  final SeatGeekListData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        data.isSearching
            ? 'Oops, search result not found!'
            : 'There is no data',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class _SeatGeekList extends StatelessWidget {
  const _SeatGeekList({required this.data, Key? key}) : super(key: key);

  final SeatGeekListData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: ListView.separated(
        itemCount: data.eventList.events.length,
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {
              BlocProvider.of<SeatGeekListBloc>(context).add(
                ShowSeatGeekDetailScreenEvent(
                    event: data.eventList.events[index]),
              );
            },
            child: _SeatGeekListItem(
              event: data.eventList.events[index],
            ),
          );
        },
        separatorBuilder: (_, int index) {
          return Divider(
            color: Colors.grey.shade600,
          );
        },
      ),
    );
  }
}

class _SeatGeekListItem extends StatelessWidget {
  const _SeatGeekListItem({required this.event, Key? key}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    final isImageNotEmpty = event.performers.isNotEmpty
        ? event.performers.first.image.isNotEmpty
        : false;
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: isImageNotEmpty
                        ? CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: event.performers.isNotEmpty
                                ? event.performers.first.image
                                : '',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const Icon(Icons.error),
                  ),
                ),
              ),
              event.isLiked
                  ? Stack(
                      children: <Widget>[
                        const Positioned(
                          left: 2.0,
                          top: 1.0,
                          child: Icon(Icons.favorite, color: Colors.white),
                        ),
                        const Icon(Icons.favorite, color: Colors.red),
                      ],
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  event.venue.displayLocation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  event.localDateTime,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatefulWidget {
  const _AppBar(
      {required this.data, required this.searchTextEditingController, Key? key})
      : super(key: key);

  final SeatGeekListData data;
  final TextEditingController searchTextEditingController;

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  @override
  void initState() {
    super.initState();
    widget.searchTextEditingController.addListener(_searchListener);
  }

  void _searchListener() {
    BlocProvider.of<SeatGeekListBloc>(context).add(
        GetSeatGeekListEvent(search: widget.searchTextEditingController.text));
  }

  @override
  Widget build(BuildContext context) {
    return widget.data.isSearching
        ? Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: TextField(
                      controller: widget.searchTextEditingController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: widget.searchTextEditingController.clear,
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  BlocProvider.of<SeatGeekListBloc>(context)
                      .add(ToggleSearchEvent());
                },
              ),
            ],
          )
        : Row(
            children: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<SeatGeekListBloc>(context)
                      .add(ToggleSearchEvent());
                },
                icon: const Icon(Icons.search),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'List of seat geek',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
  }
}
