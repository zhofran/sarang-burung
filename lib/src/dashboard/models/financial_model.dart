import 'package:equatable/equatable.dart';

class FinancialModel extends Equatable {
    const FinancialModel({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final List<FinancialData> data;
    final String? message;

    factory FinancialModel.fromJson(Map<String, dynamic> json){ 
        return FinancialModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<FinancialData>.from(json["data"]!.map((x) => FinancialData.fromJson(x))),
            message: json["message"],
        );
    }

    @override
    List<Object?> get props => [
    success, data, message, ];
}

class FinancialData extends Equatable {
    const FinancialData({
        required this.month,
        required this.year,
        required this.grandTotalCost,
        required this.expenses,
    });

    final int? month;
    final int? year;
    final int? grandTotalCost;
    final List<Expense> expenses;

    factory FinancialData.fromJson(Map<String, dynamic> json){ 
        return FinancialData(
            month: json["month"],
            year: json["year"],
            grandTotalCost: json["grand_total_cost"],
            expenses: json["expenses"] == null ? [] : List<Expense>.from(json["expenses"]!.map((x) => Expense.fromJson(x))),
        );
    }

    @override
    List<Object?> get props => [
    month, year, grandTotalCost, expenses, ];
}

class Expense extends Equatable {
    const Expense({
        required this.name,
        required this.amount,
    });

    final String? name;
    final String? amount;

    factory Expense.fromJson(Map<String, dynamic> json){ 
        return Expense(
            name: json["name"],
            amount: json["amount"],
        );
    }

    @override
    List<Object?> get props => [
    name, amount, ];
}
