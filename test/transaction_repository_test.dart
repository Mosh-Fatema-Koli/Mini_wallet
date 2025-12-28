import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:boilerplate_of_cubit/data/data_sources/transitation_remote_datasource.dart';
import 'package:boilerplate_of_cubit/data/model/transitation.dart';
import 'package:boilerplate_of_cubit/data/repositories/transaction_repository_impl.dart';

class MockRemoteDataSource extends Mock implements TransactionRemoteDataSource {}

void main() {
  late TransactionRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  final tTransactions = [
    TransactionModel(id: 1, merchantName: 'Amazon', amount: 100, status: 'Pending', discription: 'Test 1'),
    TransactionModel(id: 2, merchantName: 'eBay', amount: 50, status: 'Pending', discription: 'Test 2'),
  ];

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = TransactionRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  test('should return list of transactions when fetch is successful', () async {
    // arrange
    when(() => mockRemoteDataSource.fetchTransactions()).thenAnswer((_) async => tTransactions);

    // act
    final result = await repository.getTransactions();

    // assert
    expect(result.length, 2);
    expect(result[0].merchantName, 'Amazon');
    verify(() => mockRemoteDataSource.fetchTransactions()).called(1);
  });

  test('should throw exception when remote datasource fails', () async {
    // arrange
    when(() => mockRemoteDataSource.fetchTransactions()).thenThrow(Exception('Failed'));

    // act
    final call = repository.getTransactions();

    // assert
    expect(() => call, throwsA(isA<Exception>()));
    verify(() => mockRemoteDataSource.fetchTransactions()).called(1);
  });
}
