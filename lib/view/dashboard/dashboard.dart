import 'dart:io';
import 'package:boilerplate_of_cubit/library.dart';
import 'package:boilerplate_of_cubit/view/transitation/transitaion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di.dart';
import '../../widgets/framework/rf_text.dart';
import '../login/login.dart';
import '../transitation/cubit/transitation_cubit.dart';
import '../transitation/cubit/transitation_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? shouldExit = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: RFText(text: "Exit App", size: 10.sp),
            content: RFText(text: "Do you really want to exit?", size: 8.sp),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
                child: RFText(text: "No", size: 10.sp),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(true);
                },
                child: RFText(text: "Yes", size: 10.sp),
              ),
            ],
          ),
        );

        if (shouldExit == true) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }

        return false;
      },
      child: BlocProvider<TransactionCubit>(
        create: (_) => sl<TransactionCubit>()..loadWallet(),
        child: Builder(builder: (context) {
          final cubit = context.read<TransactionCubit>();
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('MiniPay Wallet'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final misc = MiscController();
                              misc.showProgressDialog(context: context);
                              final pref = await misc.pref();
                              await misc.prefRemoveAll(pref: pref);
                              Navigator.pop(context);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                                    (route) => false,
                              );
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ------------------
                  // Wallet Balance
                  // ------------------
                  BlocBuilder<TransactionCubit, TransactionState>(
                    builder: (context, state) {
                      final balance = state is WalletState ? state.balance : 0.0;
                      return Column(
                        children: [
                          const Text("Balance", style: TextStyle(fontSize: 18)),
                          Text(
                            "৳ $balance",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // ------------------
                  // Add / Send Buttons
                  // ------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => cubit.addMoneyAction(500),
                        child: const Text("Add 500 ৳"),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => cubit.sendMoneyAction(200),
                        child: const Text("Send 200 ৳"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ------------------
                  // Transactions Header
                  // ------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Transactions", style: TextStyle(fontSize: 18)),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TransactionPage(cubit: cubit),
                            ),
                          );

// 🔥 Refresh after coming back
                          cubit.loadWallet();
                        },
                        child: const Text("View all", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ------------------
                  // Transactions List
                  // ------------------
                  Expanded(
                    child: BlocBuilder<TransactionCubit, TransactionState>(
                      builder: (context, state) {
                        if (state is TransactionLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (state is TransactionError) {
                          return Center(child: Text(state.message));
                        }

                        final transactions = state is WalletState ? state.transactions : [];

                        if (transactions.isEmpty) {
                          return const Center(
                            child: Text(
                              'No transactions found',
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: transactions.length > 10 ? 10 : transactions.length,
                          itemBuilder: (context, index) {
                            final t = transactions[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(t.merchantName),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ID: ${t.id}"),
                                    Text("Amount: ৳ ${t.amount}"),
                                    Text("Status: ${t.status}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
