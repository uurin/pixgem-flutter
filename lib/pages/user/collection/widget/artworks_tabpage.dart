import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/business_component/illust_listview/illust_waterfall_gridview.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/user/collection/provider/artwork_collections_provider.dart';

class MyCollectArtworksTabPage extends ConsumerWidget {
  const MyCollectArtworksTabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(myArtworkCollectionsStateProvider);
    return state.when(
      loading: () => const RequestLoading(),
      data: (List<CommonIllust> artworks) => IllustWaterfallGridView(
        artworkList: artworks,
        lazyloadState: LazyloadState.idle,
        onLazyload: () {
          ref.read(myArtworkCollectionsStateProvider.notifier).next();
        },
      ),
      empty: () => const Center(
        child: Text("Empty."),
      ),
      error: (String error) => RequestLoadingFailed(
        onRetry: () {
          //
        },
      ),
    );
  }
}