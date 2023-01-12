import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/component/loading/lazyloading.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/routes.dart';
import 'package:provider/provider.dart' as pro;
import 'package:waterfall_flow/waterfall_flow.dart';

import 'illust_waterfall_item.dart';

/// ### 插画瀑布流
/// 静态组件，故列表加载的Loading不在本组件管理范围内
///
/// **例外**：管理了懒加载Lazyload的状态（出于懒加载状态的性能考虑）
/// - #### 使用时须在本组件外套一层[ChangeNotifierProvider\<LazyloadStatusProvider\>]
/// - 通过[lazyloadWidget]参数可以自定义并管理其他懒加载组件，此时就不需要外套[LazyloadStatusProvider]
class IllustWaterfallGrid extends ConsumerWidget {
  /// 插画（或漫画）列表
  final List<CommonIllust> artworkList;

  /// 触发懒加载（加载更多）的时候调用，需要自行处理重复触发请求的问题
  final Function onLazyLoad;

  /// 列表项的极限数量，为空则表示不限
  final int? limit;
  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  /// 自定义懒加载组件（为null时使用默认的懒加载，但需要外套一层 [ChangeNotifierProvider\<LazyloadStatusProvider\>]）
  final Widget? lazyloadWidget;

  /// 是否为Sliver型组件
  final bool isSliver;

  /// 是否有更多的数据没请求（即是否还有下一页）; [true] 使懒加载显示Loading，[false] 则显示没有更多数据
  /// - **优先级大于[LazyloadStatusProvider.lazyloadStatus]**
  final bool hasMore;

  const IllustWaterfallGrid({
    Key? key,
    required this.artworkList,
    required this.onLazyLoad,
    this.limit,
    this.scrollController,
    this.physics,
    this.lazyloadWidget,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    this.hasMore = true,
  })  : isSliver = false,
        super(key: key);

  const IllustWaterfallGrid.sliver({
    Key? key,
    required this.artworkList,
    required this.onLazyLoad,
    this.limit,
    this.scrollController,
    this.physics,
    this.lazyloadWidget,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    this.hasMore = true,
  })  : isSliver = true,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isSliver) {
      return SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          collectGarbage: (List<int> garbages) {
            // print('collect garbage : $garbages');
            // 内存回收
            int end = garbages.last;
            for (int i = garbages.first; i <= end; i++) {
              final provider = ExtendedNetworkImageProvider(
                artworkList[i].imageUrls.medium,
              );
              provider.evict();
            }
          },
          viewportBuilder: (int firstIndex, int lastIndex) {
            // print('viewport : [$firstIndex,$lastIndex]');
          },
          lastChildLayoutTypeBuilder: (index) =>
              index == artworkList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => _buildItem(ref, index),
          childCount: artworkList.length + 1,
        ),
      );
    } else {
      return WaterfallFlow.builder(
        padding: padding,
        controller: scrollController,
        physics: physics,
        itemCount: artworkList.length + 1,
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          collectGarbage: (List<int> garbages) {
            // print('collect garbage : $garbages');
            for (var index in garbages) {
              final provider = ExtendedNetworkImageProvider(
                artworkList[index].imageUrls.medium,
              );
              provider.evict();
            }
          },
          viewportBuilder: (int firstIndex, int lastIndex) {
            // print('viewport : [$firstIndex,$lastIndex]');
          },
          lastChildLayoutTypeBuilder: (index) =>
              index == artworkList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        itemBuilder: (BuildContext context, int index) => _buildItem(ref, index),
      );
    }
  }

  Widget _buildItem(WidgetRef ref, index) {
    var illust = artworkList[index];
    // 如果滑动到了表尾加载更多的项
    if (index == artworkList.length) {
      // 未到列表上限，继续获取数据
      if (artworkList.length < (limit ?? double.infinity)) {
        if (artworkList.isNotEmpty) onLazyLoad(); // 列表不为空才获取数据
        // 尾部懒加载组件
        return _buildLazyloadItem(ref.context);
      } else {
        //已经加载足够多的数据，不再获取
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "没有更多了",
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }
    return IllustWaterfallItem(
      illust: artworkList[index],
      // isBookmarked: ref.watch(illustDetailCollectStateProvider(illust.id.toString())) == CollectState.collected,
      collectState: illust.isBookmarked ? CollectState.collected : CollectState.notCollect,
      onTap: () {
        // ref.read(illustDetailProvider(illust.id.toString()).notifier).setIllustInfo(illust);
        artworkList[index].restrict == 2
            ? Fluttertoast.showToast(msg: "该图片已被删除或不公开", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0)
            : Navigator.of(ref.context).pushNamed(
                RouteNames.artworkDetail.name,
                arguments: IllustDetailPageArguments(
                  illustId: illust.id.toString(),
                  detail: illust,
                ),
              );
      },
    );
  }

  Widget _buildLazyloadItem(BuildContext context) {
    if (hasMore) {
      return pro.Consumer<LazyloadStatusProvider>(
        builder: ((context, LazyloadStatusProvider provider, child) {
          switch (provider.lazyloadStatus) {
            case LazyloadStatus.loading:
              return _buildLoading(context);
            case LazyloadStatus.failed:
              return _buildLoadingFailed(context);
          }
        }),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          "没有更多了",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
  }

  /* 收藏或者取消收藏插画 */
  Future<bool> postBookmark(String id, bool oldIsBookmark) async {
    bool isSucceed = false; // 是否执行成功
    if (oldIsBookmark) {
      isSucceed = await ApiIllusts().deleteIllustBookmark(illustId: id);
    } else {
      isSucceed = await ApiIllusts().addIllustBookmark(illustId: id);
    }
    // 执行结果
    return isSucceed;
  }

  // 构建懒加载中
  Widget _buildLoading(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: const CircularProgressIndicator(strokeWidth: 1.0),
      ),
    );
  }

  // 构建懒加载失败
  Widget _buildLoadingFailed(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: LazyloadingFailedWidget(
          onRetry: () {
            onLazyLoad();
          },
        ),
      ),
    );
  }
}