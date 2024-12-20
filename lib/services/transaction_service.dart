import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet/models/data_plan_form_model.dart';
import 'package:wallet/models/topup_form_model.dart';
import 'package:wallet/models/transaction_model.dart';
import 'package:wallet/models/transfer_form_model.dart';
import 'package:wallet/services/auth_service.dart';
import 'package:wallet/shared/shared_values.dart';

class TransactionService {
  Future<String> topUp(TopupFormModel data) async {
    try {
      // Validasi apakah data sudah lengkap
      if (!data.isValid()) {
        throw 'Top-up form data is incomplete';
      }

      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/top_ups'),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        final redirectUrl = responseBody['redirect_url'];

        // Pastikan redirect_url tidak null
        if (redirectUrl != null) {
          return redirectUrl;
        } else {
          throw 'Redirect URL is missing';
        }
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      print('Error during top-up: $e'); // Menambahkan log error
      rethrow;
    }
  }

  Future<void> transfer(TransferFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/transfers'),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dataPlan(DataPlanFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/data_plans'),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransactions() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/transactions',
        ),
        headers: {
          'Authorization': token,
        },
      );
      
      if (res.statusCode == 200) {
        return List<TransactionModel>.from(
          jsonDecode(res.body)['data'].map(
            (transaction) => TransactionModel.fromJson(transaction),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
