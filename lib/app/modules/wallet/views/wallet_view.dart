import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/wallet/controllers/models/coin_model.dart';
import 'package:ui_challenge/app/modules/wallet/controllers/models/contact_model.dart';
import 'package:ui_challenge/app/modules/wallet/controllers/models/payment_model.dart';
import 'package:ui_challenge/app/modules/wallet/controllers/models/transaction_model.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  late ScrollController scrollController;

  void showNotif() async {
    showGeneralDialog<bool>(
      barrierColor: Colors.black.withValues(alpha: 0.35),
      transitionBuilder: (context, a1, a2, widget) {
        return GestureDetector(
          onTap: () {
            Get.back();
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: FadeTransition(
              opacity:
                  Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
                parent: a1,
                curve: Curves.easeOut, // 🎯 Effet de sortie plus fluide
              )),
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(10),
                child: NotifDialog(
                  scrollController: scrollController,
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(
        milliseconds: 500,
      ), // Un peu plus long pour bien voir l'effet
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    Future.delayed(
      const Duration(seconds: 15),
      showNotif,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    final theme = context.theme;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   surfaceTintColor: Colors.transparent,
      //   title: ,
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.home),
                      GestureDetector(
                        onTap: showNotif,
                        child: const Text(
                          'Wallet',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      IconButton.filledTonal(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateColor.resolveWith(
                          (states) => Colors.white,
                        )),
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/ton.png",
                    height: 200,
                  ),
                  Text(
                    "Total balance",
                    style: theme.textTheme.labelSmall,
                  ),
                  Text(
                    "\$117,664.9",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(90, 40),
                          minimumSize: const Size(90, 40),
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                        child: Text(
                          "Wallet",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(90, 40),
                          minimumSize: const Size(90, 40),
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Text(
                          "Ton space",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 12,
                          ),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withValues(alpha: .2),
                                  // gradient: RadialGradient(
                                  //   colors: [],
                                  // ),
                                ),
                                child: const Icon(
                                  Icons.add_rounded,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Deposit",
                                style: theme.textTheme.labelMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 12,
                          ),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.grey.withValues(alpha: .2),
                                  // gradient: RadialGradient(
                                  //   colors: [],
                                  // ),
                                ),
                                child: const Icon(
                                  Icons.file_upload_outlined,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Send",
                                style: theme.textTheme.labelMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 12,
                          ),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.grey.withValues(alpha: .2),
                                  // gradient: RadialGradient(
                                  //   colors: [],
                                  // ),
                                ),
                                child: const Icon(
                                  Icons.compare_arrows_rounded,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Exchanges",
                                style: theme.textTheme.labelMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 12,
                          ),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.grey.withValues(alpha: .2),
                                  // gradient: RadialGradient(
                                  //   colors: [],
                                  // ),
                                ),
                                child: const Icon(
                                  Icons.qr_code_scanner,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "QR",
                                style: theme.textTheme.labelMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Quick Transfer",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    dummyContacts.length,
                                    (index) {
                                      final contact = dummyContacts[index];
                                      return Container(
                                        width: 130,
                                        height: 50,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              foregroundImage:
                                                  AssetImage(contact.avatarUrl),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                contact.name,
                                                style:
                                                    theme.textTheme.titleSmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Assets",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 105,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: dummyCoins.take(4).length,
                    itemBuilder: (context, index) {
                      final coin = dummyCoins[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              right: BorderSide(
                                width: 4,
                                color: coin.color,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  foregroundImage: AssetImage(coin.imageUrl),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  coin.symbol,
                                  style: theme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  "\$${coin.price}",
                                  style: theme.textTheme.titleLarge,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  "1 ${coin.symbol}",
                                  style: theme.textTheme.labelMedium,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Scheduled payments",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 170,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withValues(alpha: .2),
                                  // gradient: RadialGradient(
                                  //   colors: [],
                                  // ),
                                ),
                                child: const Icon(
                                  Icons.add_rounded,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    dummyPayments.length,
                                    (index) {
                                      final payment = dummyPayments[index];
                                      return Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        width: 140,
                                        height: 170,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 55,
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                colors: [
                                                  Colors.blueAccent,
                                                  Colors.deepPurple
                                                ],
                                              )),
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Positioned(
                                                    bottom: -20,
                                                    left: 10,
                                                    child: CircleAvatar(
                                                      radius: 18,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(
                                                          190,
                                                          133,
                                                          106,
                                                          208,
                                                        ),
                                                        child: Icon(
                                                          !payment.isPremium
                                                              ? Icons
                                                                  .mobile_friendly_outlined
                                                              : Icons
                                                                  .telegram_rounded,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(payment.isPremium
                                                        ? "Premium"
                                                        : "TonMobile"),
                                                    Text(
                                                      "\$${payment.amount.toStringAsFixed(2)}",
                                                      style: theme
                                                          .textTheme.titleMedium
                                                          ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ), // Formatage montant
                                                    Text(
                                                      DateFormat(
                                                              "d MMM", "en_US")
                                                          .format(
                                                        payment.date,
                                                      ),
                                                      style: theme
                                                          .textTheme.titleMedium
                                                          ?.copyWith(
                                                        color: Colors.grey,
                                                      ), // Correction du theme
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Transactions",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      final transaction = dummyTransactions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            foregroundImage: AssetImage(
                              "assets/avatars/${index + 1}.png",
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: Colors.white,
                          title: Text(
                            transaction.userName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text("Send to ${transaction.receiver}"),
                          trailing: Column(
                            children: [
                              Text(
                                "\$${transaction.amount}",
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                DateFormat("d MMM", "en_US").format(
                                  transaction.date,
                                ),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: dummyTransactions.length,
                    shrinkWrap: true,
                    primary: false,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotifDialog extends StatefulWidget {
  const NotifDialog({super.key, required this.scrollController});

  final ScrollController scrollController;
  @override
  State<NotifDialog> createState() => _NotifDialogState();
}

class _NotifDialogState extends State<NotifDialog> {
  bool isSwitched = false;
  bool canShow = false;
  bool startPayment = false;
  bool isLading = false;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    final double statusBarHeight = MediaQuery.paddingOf(context).top;
    final theme = context.theme;

    return Column(
      children: [
        SizedBox(height: statusBarHeight),
        GestureDetector(
          onTap: () {
            setState(() {
              isSwitched = true;
            });
          },
          child: AnimatedContainer(
            height: isSwitched
                ? startPayment
                    ? 530
                    : 560
                : 75,
            onEnd: () {
              setState(() {
                canShow = true;
              });
            },
            clipBehavior: Clip.antiAliasWithSaveLayer,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 244, 244, 244),
              borderRadius: BorderRadius.circular(40),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: canShow
                  ? Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AnimatedPadding(
                              duration: const Duration(milliseconds: 200),
                              padding: startPayment
                                  ? const EdgeInsets.all(20)
                                  : EdgeInsets.zero,
                              child: Container(
                                height: 110,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.surfaceTint,
                                      Colors.blue,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      startPayment ? 20 : 0),
                                ),
                                child: SizedBox.expand(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child:
                                        Image.asset("assets/images/notif.png"),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: startPayment
                                  ? Column(
                                      key: const Key("paymentStarted"),
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "19 May, Sunday, 10:23",
                                              style: theme.textTheme.titleSmall
                                                  ?.copyWith(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const Text(
                                              "Monthly Design Subscription",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                            .animate()
                                            .fadeIn(
                                                duration:
                                                    const Duration(seconds: 1))
                                            .slideY(
                                              begin: -1,
                                              end: 0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ),
                                        const SizedBox(height: 30),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "5,990 USDT",
                                                  style: theme
                                                      .textTheme.displayMedium,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                            .animate()
                                            .fadeIn(
                                                duration:
                                                    const Duration(seconds: 1),
                                                delay: const Duration(
                                                    milliseconds: 300))
                                            .slideY(
                                              begin: -1,
                                              end: 0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                    "Pay every 19th day of month"),
                                              ),
                                              Switch.adaptive(
                                                value: true,
                                                onChanged: (value) {},
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      key: const Key("paymentStarted"),
                                      children: [
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Monthly Design Subscription",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Branding, UX/UI, 3D Illustration & Animation, Social Media Visuals",
                                            ),
                                          ],
                                        )
                                            .animate()
                                            .fadeIn(
                                                duration:
                                                    const Duration(seconds: 1))
                                            .slideY(
                                              begin: -1,
                                              end: 0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ),
                                        const SizedBox(height: 30),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "5,990 USDT",
                                                  style: theme
                                                      .textTheme.displayMedium,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Until 19 June 2024",
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                            .animate()
                                            .fadeIn(
                                                duration:
                                                    const Duration(seconds: 1),
                                                delay: const Duration(
                                                    milliseconds: 300))
                                            .slideY(
                                              begin: -1,
                                              end: 0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ),
                                        const SizedBox(height: 30),
                                        const ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          leading: CircleAvatar(
                                            foregroundImage: AssetImage(
                                                "assets/icons/coins/usdt.png"),
                                          ),
                                          dense: true,
                                          title: Text("Choose balance"),
                                          subtitle: Text("25,360.4"),
                                          trailing:
                                              Icon(Icons.chevron_right_rounded),
                                        )
                                            .animate()
                                            .fadeIn(
                                                duration:
                                                    const Duration(seconds: 1),
                                                delay: const Duration(
                                                    milliseconds: 300))
                                            .slideY(
                                              begin: -1,
                                              end: 0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ),
                                      ],
                                    ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Visibility(
                                visible: startPayment,
                                replacement: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLading = true;
                                    });

                                    await Future.delayed(
                                      const Duration(seconds: 1),
                                      () {
                                        setState(() {
                                          startPayment = true;
                                        });
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: Visibility(
                                          visible: !isLading,
                                          replacement: const SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              color: AppColors.white,
                                            ),
                                          ),
                                          child: Text(
                                            "Pay 5,990 USDT",
                                            style: theme.textTheme.titleLarge
                                                ?.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ).animate().fadeIn(),
                                    ],
                                  ),
                                )
                                    .animate()
                                    .fadeIn(
                                        duration: const Duration(seconds: 1),
                                        delay:
                                            const Duration(milliseconds: 300))
                                    .slideY(
                                      begin: -1,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (startPayment == true) {
                                      dummyTransactions.add(
                                        Transaction(
                                          id: '4',
                                          userId: '103',
                                          userName: 'Subscription',
                                          receiver: 'Frank',
                                          amount: 5.990,
                                          currency: 'GBP',
                                          status: 'failed',
                                          date: DateTime.now().subtract(
                                              const Duration(days: 3)),
                                          color: Colors.red,
                                        ),
                                      );

                                      Get.back();
                                      print("josco");
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      widget.scrollController.animateTo(
                                        widget.scrollController.position
                                            .maxScrollExtent,
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        curve: Curves.decelerate,
                                      );

                                      setState(() {});
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: Text(
                                          "Done",
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ).animate().fadeIn(),
                                    ],
                                  ),
                                )
                                    .animate()
                                    .fadeIn(
                                        duration: const Duration(seconds: 1),
                                        delay:
                                            const Duration(milliseconds: 300))
                                    .slideY(
                                      begin: -1,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        if (startPayment)
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 100,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 30,
                                child: Icon(
                                  CupertinoIcons.check_mark,
                                  color: Colors.white,
                                ),
                              ),
                            )
                                .animate()
                                .slideY(
                                  delay: const Duration(
                                    milliseconds: 400,
                                  ),
                                )
                                .fade(),
                          ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                            key: const ValueKey('listTile'),
                            leading: const CircleAvatar(
                              child: Icon(CupertinoIcons.bell_fill),
                            ),
                            title: Text(
                              "FANCY",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            subtitle: Text(
                              "Subscription \$5,990",
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.blue,
                                elevation: 0,
                              ),
                              child: Text(
                                "Pay",
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ))
                      ],
                    ),
            ),
          ).animate().slideY(
                begin: -1,
                end: 0,
                duration: const Duration(milliseconds: 500),
              ),
        ),
      ],
    );
  }
}
