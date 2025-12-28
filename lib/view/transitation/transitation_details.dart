import 'package:boilerplate_of_cubit/data/model/transitation.dart';
import 'package:boilerplate_of_cubit/library.dart';
import 'package:boilerplate_of_cubit/view/transitation/cubit/transitation_cubit.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/transitation_entetis.dart';
import '../login/login.dart';

import 'package:boilerplate_of_cubit/data/model/transitation.dart';
import 'package:boilerplate_of_cubit/library.dart';
import 'package:boilerplate_of_cubit/view/transitation/cubit/transitation_cubit.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/transitation_entetis.dart';
import '../login/login.dart';

class TransitationDetailsPage extends StatelessWidget {
  final TransactionEntities details;
  final TransactionCubit cubit; // Reuse existing cubit
  final misc = MiscController();

  TransitationDetailsPage({
    super.key,
    required this.details,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RFText(text: "Details of ${details.merchantName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: AppColors.lightGreyColor,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RFText(text: "Merchant Name : ${details.merchantName}", size: 16.sp),
                    RFText(text: "Reference: 1234"),
                    RFText(text: "Amount: ${details.amount}"),
                    RFText(text: "Description: ${details.discription}"),
                    RFText(text: "Status: ${details.status}"),
                    const SizedBox(height: 50),
                    details.status=="Approved"||details.status=="Rejected"?SizedBox(): Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () => _showApprovalDialog(context, "Approved"),
                          child: RFText(text: "Approve"),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.save_red,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () => _showApprovalDialog(context, "Rejected"),
                          child: RFText(text: "Reject"),
                        ),
                      ],
                    ),
                  ],
                ),
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
        title: const Text("Enter PIN"),
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
                cubit.updateStatus(details.id, status);
                details.status = status; // locally update UI
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


