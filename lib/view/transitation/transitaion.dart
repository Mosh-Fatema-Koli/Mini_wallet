import 'package:boilerplate_of_cubit/view/login/login.dart';
import 'package:boilerplate_of_cubit/view/transitation/transitation_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../library.dart';
import 'cubit/transitation_cubit.dart';
import 'cubit/transitation_state.dart';

class TransactionPage extends StatefulWidget {
  final TransactionCubit cubit;

  const TransactionPage({super.key, required this.cubit});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController _searchController = TextEditingController();
  final misc = MiscController();

  @override
  void initState() {
    super.initState();
    // Fetch transactions when the page opens
    widget.cubit.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.withOpacity(.2),
        title: const Text('Transactions'),
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
                        misc.showProgressDialog(context: context);
                        final pref = await misc.pref();
                        await misc.prefRemoveAll(pref: pref);
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
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
      body: Column(
        children: [
          // ------------------
          // Search & Refresh
          // ------------------
          Container(
            color: Colors.blueGrey.withOpacity(.2),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by merchant name...',
                      border: OutlineInputBorder(),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    onSubmitted: (value) {
                      widget.cubit.searchTransactions(value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.cubit
                          .searchTransactions(_searchController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      _searchController.clear();
                      await widget.cubit.fetchTransactions();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Icon(Icons.refresh, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Colors.black26),

          // ------------------
          // Transaction List
          // ------------------
          Expanded(
            child: BlocBuilder<TransactionCubit, TransactionState>(
              bloc: widget.cubit, // IMPORTANT: use the passed cubit
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TransactionError) {
                  return Center(child: Text(state.message));
                }
                if (state is TransactionLoaded) {
                  final transactions = state.transactions;
                  if (transactions.isEmpty) {
                    return const Center(
                      child: Text(
                        'No transactions found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      _searchController.clear();
                      await widget.cubit.fetchTransactions();
                    },
                    child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final t = transactions[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              // DashboardPage.dart
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TransitationDetailsPage(
                                    details: t,
                                    cubit: widget.cubit, // SAME INSTANCE
                                  ),
                                ),
                              );


                            },
                            child: ListTile(
                              tileColor: Colors.blueGrey.withOpacity(.2),
                              title: Text(t.merchantName),
                              subtitle: Text(
                                  'ID: ${t.id}\nAmount: ${t.amount}\nStatus: ${t.status}\nType: ${t.type}'),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
