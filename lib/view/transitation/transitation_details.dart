import 'package:boilerplate_of_cubit/data/model/transaction_model.dart';
import 'package:boilerplate_of_cubit/library.dart';
import 'package:boilerplate_of_cubit/view/transitation/cubit/transitation_cubit.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/transitation_entities.dart';
import '../login/login.dart';

import 'package:boilerplate_of_cubit/data/model/transaction_model.dart';
import 'package:boilerplate_of_cubit/library.dart';
import 'package:boilerplate_of_cubit/view/transitation/cubit/transitation_cubit.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/transitation_entities.dart';
import '../login/login.dart';
import 'cubit/transitation_state.dart';

class TransitationDetailsPage extends StatelessWidget {
  final TransactionEntities details;
  final misc = MiscController();

  TransitationDetailsPage({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RFText(text: "Details of ${details.merchantName}"),
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoaded) {
            final transaction = state.transactions.firstWhere(
                  (e) => e.id == details.id,
            );

            return _buildBody(context, transaction);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, TransactionEntities transaction) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        color: AppColors.lightGreyColor,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RFText(text: "Merchant: ${transaction.merchantName}",
                  size: 16.sp,
                  weight: FontWeight.bold),
              RFText(text: "Amount: ${transaction.amount}"),
              RFText(text: "Description: ${transaction.description}"),
              Row(
                children: [
                  RFText(text: "Status: "),
                  RFText(
                    text: transaction.status,
                    color: transaction.status == "Approved"
                        ? Colors.green
                        : transaction.status == "Rejected"
                        ? Colors.red
                        : Colors.grey,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (transaction.status == "Pending")
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showApprovalDialog(context, "Approved"),
                      child: const Text("Approve"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => _showApprovalDialog(context, "Rejected"),
                      child: const Text("Reject"),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
  void _showApprovalDialog(BuildContext context, String status) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Confirm $status"),
        content: Text("Are you sure you want to $status this transaction?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close confirmation dialog
              _showPinDialog(context, status); // Show PIN dialog next
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _showPinDialog(BuildContext context, String status) {
    final TextEditingController _pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Enter your PIN for confirmation"),
        content: TextField(
          controller: _pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Enter your PIN"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final pref = await misc.pref();
              final pin = pref.getString(Constant.pin);
              final token = pref.getString(Constant.accessToken);

              if (token == null || token.isEmpty) {
                // Token missing, logout
                await _logout(context);
                return;
              }

              if (_pinController.text == pin) {
                Navigator.of(context).pop(); // close PIN dialog
                // Update status via cubit
                context.read<TransactionCubit>().updateTransactionStatus(details.id, status);
                // details.status = status; // locally update UI
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid PIN")),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Your session expired. Please login again."),
        actions: [
          TextButton(
            onPressed: () async {
              misc.showProgressDialog(context: context);
              final pref = await misc.pref();
              await misc.prefRemoveAll(pref: pref);
              Navigator.pop(context); // close alert
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
                    (route) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
// class TransitationDetailsPage extends StatelessWidget {
//   final TransactionEntities details;
//   final TransactionCubit cubit; // Reuse existing cubit
//   final misc = MiscController();
//
//   TransitationDetailsPage({
//     super.key,
//     required this.details,
//     required this.cubit,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: RFText(text: "Details of ${details.merchantName}"),
//       ),
//       body: BlocBuilder<TransactionCubit, TransactionState>(
//     builder: (context, state) {
//       if (state is TransactionLoaded) {
//         final transaction = state.transactions.firstWhere(
//               (e) => e.id == details.id,
//         );
//
//         return  Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Card(
//             color: AppColors.lightGreyColor,
//             child: Wrap(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       RFText(text: "Merchant Name : ${transaction.merchantName}", size: 16.sp,weight: FontWeight.bold,),
//                       RFText(text: "Reference: 1234"),
//                       RFText(text: "Amount: ${transaction.amount}"),
//                       RFText(text: "Description: ${transaction.description}"),
//                       Row(
//                         children: [
//                           RFText(text: "Status: ",),
//                           RFText(text: " ${transaction.status }",color: transaction.status=="Approved"? Colors.green:transaction.status=="Rejected"?Colors.red:Colors.grey,weight: FontWeight.bold,),
//
//                         ],
//                       ),
//                       RFText(
//                         text: "Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(transaction.date as DateTime)}",
//                       ),
//                       const SizedBox(height: 50),
//                       transaction.status=="Approved"||transaction.status=="Rejected"?SizedBox(): Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.green,
//                               padding: const EdgeInsets.symmetric(horizontal: 16),
//                             ),
//                             onPressed: () => _showApprovalDialog(context, "Approved"),
//                             child: RFText(text: "Approve"),
//                           ),
//                           const SizedBox(width: 20),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.save_red,
//                               padding: const EdgeInsets.symmetric(horizontal: 16),
//                             ),
//                             onPressed: () => _showApprovalDialog(context, "Rejected"),
//                             child: RFText(text: "Reject"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//
//       return const Center(child: CircularProgressIndicator());
//     },
//     ),
//     );
//   }
//
// }


