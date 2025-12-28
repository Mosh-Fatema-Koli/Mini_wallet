import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../model/transitation.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> fetchTransactions();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Duration timeoutDuration;

  TransactionRemoteDataSourceImpl({this.timeoutDuration = const Duration(seconds: 10)});

  @override
  Future<List<TransactionModel>> fetchTransactions() async {
    // 1️⃣ Check internet connection
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }

    try {
      // 2️⃣ Fetch data with timeout
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
          .timeout(timeoutDuration);

      // 3️⃣ Handle response
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((e) => TransactionModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load transactions. Status code: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timed out. Please try again.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
