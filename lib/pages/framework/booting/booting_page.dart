import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/global/provider/current_account_provider.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/global/global.dart';

/// app启动的加载过渡页面，载入一些数据
class BootingPage extends ConsumerStatefulWidget {
  const BootingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BootingPageState();
}

class BootingPageState extends ConsumerState<BootingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).bottomAppBarColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Pixgem",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initData().then((value) {
      String? id = ref.read(globalCurrentAccountProvider)?.user.id;
      if (id == null) {
        // 拦截未登录
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.wizard.name, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainNavigation.name, (route) => false);
      }
    }).catchError((onError) {
      Navigator.pushNamedAndRemoveUntil(context, RouteNames.wizard.name, (route) => false);
    });
  }

  /// 初始化数据
  Future initData() async {
    await GlobalStore.init();
  }
}