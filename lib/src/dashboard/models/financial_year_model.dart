import 'package:equatable/equatable.dart';

class FinancialYearModel extends Equatable {
    const FinancialYearModel({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final List<Data> data;
    final String? message;

    factory FinancialYearModel.fromJson(Map<String, dynamic> json){ 
        return FinancialYearModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
            message: json["message"],
        );
    }

    @override
    List<Object?> get props => [
    success, data, message, ];
}

class Data extends Equatable {
    const Data({
        required this.year,
        required this.fullGrandTotal,
        required this.fullData,
    });

    final String? year;
    final int? fullGrandTotal;
    final List<FullData> fullData;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            year: json["year"],
            fullGrandTotal: json["full_grand_total"],
            fullData: json["full_data"] == null ? [] : List<FullData>.from(json["full_data"]!.map((x) => FullData.fromJson(x))),
        );
    }

    @override
    List<Object?> get props => [
    year, fullGrandTotal, fullData, ];
}

class FullData extends Equatable {
    const FullData({
        required this.month,
        required this.grandTotalCost,
        required this.expenses,
    });

    final int? month;
    final int? grandTotalCost;
    final List<ExpenseYear> expenses;

    factory FullData.fromJson(Map<String, dynamic> json){ 
        return FullData(
            month: json["month"],
            grandTotalCost: json["grand_total_cost"],
            expenses: json["expenses"] == null ? [] : List<ExpenseYear>.from(json["expenses"]!.map((x) => ExpenseYear.fromJson(x))),
        );
    }

    @override
    List<Object?> get props => [
    month, grandTotalCost, expenses, ];
}

class ExpenseYear extends Equatable {
    const ExpenseYear({
        required this.name,
        required this.amount,
    });

    final String? name;
    final String? amount;

    factory ExpenseYear.fromJson(Map<String, dynamic> json){ 
        return ExpenseYear(
            name: json["name"],
            amount: json["amount"],
        );
    }

    @override
    List<Object?> get props => [
    name, amount, ];
}
