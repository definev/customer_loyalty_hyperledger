import 'package:flutter/material.dart';
import 'package:flutter_avataaar/flutter_avataaar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:universal_io/io.dart';
import 'package:wallet/features/dashboard/widget/transaction_card.dart';
import 'package:wallet/features/sign_in/sign_in_provider.dart';
import 'package:wallet/resources/resources.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  final avatar = Avataaar.random();
  final draggableController = DraggableScrollableController();
  bool isExpand = false;
  bool isAnimate = false;
  double minSnap = 0;

  @override
  void initState() {
    super.initState();

    draggableController.addListener(onSnap);
  }

  void onSnap() {
    if (isAnimate) return;
    if ((draggableController.size - minSnap).abs() < 0.000001) {
      if (isExpand == false) return;
      setState(() => isExpand = false);
    }
  }

  @override
  void dispose() {
    draggableController.removeListener(onSnap);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final md = MediaQuery.of(context);
    final bottomOffset = md.padding.bottom;
    minSnap = (bottomOffset + 80) / (md.size.height - md.padding.top - 56);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => ref.refresh(fetchTransactionsProvider),
          child: LineIcon.syncIcon(),
        ),
        actions: [
          SizedBox(
            height: 56,
            width: 56,
            child: Center(child: LineIcon.search()),
          ),
        ],
        title: SizedBox(
          height: 42,
          width: 42,
          child: AvataaarPicture.builder(avatar: avatar),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // ignore: unused_result
          ref.refresh(fetchTransactionsProvider);
        },
        child: ListView(
          children: [
            // TITLE
            Consumer(builder: (context, ref, child) {
              final data =
                  ref.watch(signInStateProvider.select((value) => value.mapOrNull(signedIn: (value) => value)!));

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Text.rich(
                  TextSpan(
                    text: 'Chào, ',
                    style: theme.textTheme.headlineLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w300),
                    children: [
                      TextSpan(
                        text: data.member.lastName,
                        style: theme.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // CLASSES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ví của tôi',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(''),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AspectRatio(
                aspectRatio: 16 / 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFe1e4e3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 52,
                                  width: 52,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFd1d7d4),
                                    ),
                                    child: Center(
                                      child: Image.asset(WalletImages.dollarFrontColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Số dư hiện tại',
                                      style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Consumer(builder: (context, ref, child) {
                                      final points = ref.watch(
                                        fetchTransactionsProvider.select(
                                          (value) => value.map<AsyncValue<int>>(
                                            data: (data) => AsyncData(
                                              data.value.fold(0,
                                                  (val, ele) => val + (ele.type == 'use' ? -ele.points : ele.points)),
                                            ),
                                            error: (error) => AsyncError(error.error, error.stackTrace),
                                            loading: (loading) => const AsyncLoading(),
                                          ),
                                        ),
                                      );
                                      return points.map(
                                        data: (data) => Text(data.value.toString()),
                                        error: (_) => const Text('XXX'),
                                        loading: (_) => const Text('...'),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white70,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: LineIcon.shoppingBag(),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: SizedBox(
                                      height: 20,
                                      width: 1.5,
                                      child: ColoredBox(color: Colors.white60),
                                    ),
                                  ),
                                  Text(
                                    'Uwu đãi',
                                    style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          WalletImages.walletFrontColor,
                          height: Platform.isIOS ? 84 : 56,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // HOMEWORKS
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lịch sử giao dịch',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: expandHistory,
                    child: const Text('Xem tất cả'),
                  ),
                ],
              ),
            ),
            const HistoryPreviewSection(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isExpand
          ? null
          : FloatingActionButton.extended(
              onPressed: expandHistory,
              icon: LineIcon.arrowCircleUp(),
              label: const Text('Xem thêm'),
            ),
      bottomSheet: DraggableScrollableSheet(
        controller: draggableController,
        expand: false,
        snap: true,
        snapSizes: [minSnap, 0.7, 1],
        minChildSize: minSnap,
        initialChildSize: minSnap,
        builder: (context, scrollController) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              bool newIsExpand = draggableController.size > minSnap;
              if ((draggableController.size - minSnap).abs() < 0.00001) {
                setState(() => isExpand = false);
                return true;
              }
              if (isExpand != newIsExpand) {
                setState(() => isExpand = newIsExpand);
              }
              return true;
            },
            child: ListAllTransactionView(
              isExpand: isExpand,
              scrollController: scrollController,
            ),
          );
        },
      ),
    );
  }

  void expandHistory() async {
    if (isExpand == false) {
      setState(() {
        isAnimate = true;
        isExpand = true;
      });
      Future.microtask(() async {
        await draggableController.animateTo(
          0.7,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubicEmphasized,
        );
        await Future.delayed(Duration.zero);
        isAnimate = false;
      });
    }
  }
}

class ListAllTransactionView extends ConsumerWidget {
  const ListAllTransactionView({
    Key? key,
    required this.isExpand,
    required this.scrollController,
  }) : super(key: key);

  final bool isExpand;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(fetchTransactionsProvider);

    return ListView(
      controller: scrollController,
      children: [
        DragHeader(isExpand),
        ...transactions.map(
          data: (data) {
            if (data.value.isEmpty) {
              return [
                const SizedBox(
                  height: 300,
                  child: Center(
                    child: Text('Doesn\'t have timeline yet'),
                  ),
                )
              ];
            }

            return [
              for (final trans in data.value)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: TransactionCard(transaction: trans),
                ),
            ];
          },
          error: (error) {
            return [
              const SizedBox(
                height: 300,
                child: Center(
                  child: Text('Boop! Beep! Something went wrong'),
                ),
              )
            ];
          },
          loading: (_) {
            return [
              const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ];
          },
        ),
      ],
    );
  }
}

class HistoryPreviewSection extends ConsumerWidget {
  const HistoryPreviewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final first = ref.watch(fetchTransactionsProvider);

    return first.map(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: data.value.isEmpty
              ? const SizedBox(
                  height: 200,
                  child: Center(child: Text('Lịch sử trống')),
                )
              : Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 8,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF866ee1),
                        ),
                      ),
                    ),
                    TransactionCard(transaction: data.value.first),
                  ],
                ),
        );
      },
      error: (error) {
        return Text('Beep! Boop! ${error.error}');
      },
      loading: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
}

class DragHeader extends StatelessWidget {
  const DragHeader(this.isExpand, {super.key});

  final bool isExpand;

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context);
    final bottomOffset = md.padding.bottom;
    return AnimatedSize(
      duration: const Duration(milliseconds: 280),
      curve: Curves.ease,
      child: () {
        if (isExpand) return const SizedBox(height: 25);
        return Column(
          children: [
            NavigationBar(
              destinations: [
                NavigationDestination(
                  icon: LineIcon.home(),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: LineIcon.cog(),
                  label: 'Setting',
                ),
              ],
            ),
            SizedBox(height: bottomOffset),
          ],
        );
      }(),
    );
  }
}
