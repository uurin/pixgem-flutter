import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/business_component/listview/illust_listview/illust_waterfall_item.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:pixgem/global/provider/collection_state_provider.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:pixgem/routes.dart';

mixin IllustWaterfallGridViewLogic {
  WidgetRef get ref;

  void handleTapItem(CommonIllust illust) {
    if (illust.restrict == 2) {
      Fluttertoast.showToast(msg: "该图片已被删除或不公开", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    } else {
      Navigator.of(ref.context).pushNamed(
        RouteNames.artworkDetail.name,
        arguments: IllustDetailPageArguments(illustId: illust.id.toString(), detail: illust),
      );
    }
  }
}

mixin IllustWaterfallItemLogic on ConsumerState<IllustWaterfallItem> {
  late CollectState collectState;

  late String illustId;

  @override
  WidgetRef get ref;

  late final collectStateProvider = StateNotifierProvider.autoDispose<CollectNotifier, CollectState>((ref) {
    // 监听全局美术作品收藏状态通知器的变化
    ref.listen<CollectStateChangedArguments?>(globalArtworkCollectionStateChangedProvider, (previous, next) {
      if (next != null && next.worksId == illustId) {
        ref.notifier.setCollectState(next.state);
      }
    });

    return CollectNotifier(collectState, ref: ref, worksId: illustId, worksType: WorksType.illust);
  });

  void handleTapCollect() {
    var i10n = LocalizationIntl.of(ref.context);
    var state = ref.read(collectStateProvider);
    if (state == CollectState.notCollect) {
      // 当前未收藏，添加收藏
      ref
          .read(collectStateProvider.notifier)
          .collect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? i10n.addCollectSucceed : i10n.addCollectFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${i10n.addCollectFailed}, (Maybe already collected)", toastLength: Toast.LENGTH_LONG));
    }
    if (state == CollectState.collected) {
      // 当前已收藏，移除收藏
      ref
          .read(collectStateProvider.notifier)
          .uncollect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? i10n.removeCollectionSucceed : i10n.removeCollectionFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${i10n.removeCollectionFailed}, (Maybe already un-collected)", toastLength: Toast.LENGTH_LONG));
    }
  }
}