import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/sliver_persistent_header/tab_bar_delegate.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/artwork/ranking/logic.dart';
import 'package:artvier/pages/artwork/ranking/artworks_tabpage.dart';
import 'package:artvier/config/ranking_mode_constants.dart';

class ArtworksRankingPage extends BaseStatefulPage {
  const ArtworksRankingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ArtworksRankingPageState();
}

class ArtworksRankingPageState extends BasePageState<ArtworksRankingPage>
    with TickerProviderStateMixin, ArtworksRankingPageLogic {
  late final TabController _tabController;

  late final ScrollController _scrollController;

  @override
  ScrollController get scrollController => _scrollController;

  // tab分页的对应模式与字段
  late Map<String, String> _tabsMap;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 13, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = PrimaryScrollController.of(context);
    _tabsMap = {
      IllustRankingMode.daily: l10n.rankingDaily,
      IllustRankingMode.weekly: l10n.rankingWeekly,
      IllustRankingMode.monthly: l10n.rankingMonthly,
      IllustRankingMode.dailyMale: l10n.rankingMale,
      IllustRankingMode.dailyFemale: l10n.rankingFemale,
      IllustRankingMode.weeklyOriginal: l10n.rankingOriginal,
      IllustRankingMode.weeklyRookie: l10n.rankingRookie,
      IllustRankingMode.dayAi: l10n.rankingAiGenerated,
      IllustRankingMode.dailyR18: l10n.rankingR18Daily,
      IllustRankingMode.weeklyR18: l10n.rankingR18Weekly,
      IllustRankingMode.dailyR18Ai: l10n.rankingR18AiGenerated,
      IllustRankingMode.dailyMaleR18: l10n.rankingR18Male,
      IllustRankingMode.dailyFemaleR18: l10n.rankingR18Female,
    };
    return Scaffold(
      body: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [];
        },
        body: Column(
          children: [
            AppBar(
              leading: const AppbarLeadingButtton(),
              title: const Text("排行榜"),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              actions: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up),
                  onPressed: handlePressedToTop,
                  tooltip: "回到顶部",
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: kTabBarHeight,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              color: colorScheme.surface,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                tabs: [
                  for (String name in _tabsMap.values) Tab(text: name),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  for (String mode in _tabsMap.keys)
                    ArtworksRankingTabPage(
                      mode: mode,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
