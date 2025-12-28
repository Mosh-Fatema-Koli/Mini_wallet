import 'package:boilerplate_of_cubit/view/login/login.dart';
import 'package:boilerplate_of_cubit/view/transitation/transitation_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/data_sources/transitation_remote_datasource.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../library.dart';
import 'cubit/transitation_cubit.dart';
import 'cubit/transitation_state.dart';
class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController _searchController = TextEditingController();
  final misc = MiscController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final remoteDataSource = TransactionRemoteDataSourceImpl();
        final repository =
        TransactionRepositoryImpl(remoteDataSource: remoteDataSource);
        final cubit = TransactionCubit(repository: repository);
        cubit.fetchTransactions();
        return cubit;
      },

      // ✅ VERY IMPORTANT
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Transactions'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Logout'),
                        content:
                        const Text('Are you sure you want to logout?'),
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
                                    (route) => false, // Remove all previous routes
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50, // set desired height
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search by merchant name...',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            ),
                            onSubmitted: (value) {
                              context.read<TransactionCubit>().searchTransactions(value);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 50, // same height as TextField
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<TransactionCubit>()
                                .searchTransactions(_searchController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greyColor,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Icon(Icons.search,color: Colors.white,),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 50, // same height as TextField
                        child: ElevatedButton(
                          onPressed: () async {
                            _searchController.clear();
                            await context.read<TransactionCubit>().fetchTransactions();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            backgroundColor: AppColors.green
                          ),
                          child: const Icon(Icons.refresh,color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),


                Expanded(
                  child: BlocBuilder<TransactionCubit, TransactionState>(
                    builder: (context, state) {
                      if (state is TransactionLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (state is TransactionError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.message),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<TransactionCubit>()
                                    .fetchTransactions(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is TransactionLoaded) {

                        if (state.transactions.isEmpty) {
                          return Center(
                            child: Text(
                              'No transactions found',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () async {
                            _searchController.clear();
                            await context.read<TransactionCubit>().fetchTransactions();
                          },
                          child: ListView.builder(
                            itemCount: state.transactions.length,
                            itemBuilder: (context, index) {
                              final t = state.transactions[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0).w,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<TransactionCubit>(),
                                          child: TransitationDetailsPage(details: t, cubit: context.read<TransactionCubit>()),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    tileColor:Colors.blueGrey.withOpacity(.2),title: Text(t.merchantName),
                                    subtitle: Text(
                                      'ID: ${t.id} | Amount: ${t.amount} | \nStatus: ${t.status}',
                                    ),
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
        },
      ),
    );
  }
}

