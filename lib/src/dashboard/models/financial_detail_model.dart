import 'package:equatable/equatable.dart';

class FinancialDetailModel extends Equatable {
    const FinancialDetailModel({
        required this.costType,
        required this.startDate,
        required this.endDate,
        required this.branchName,
        required this.details,
    });

    final String? costType;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? branchName;
    final List<Detail> details;

    factory FinancialDetailModel.fromJson(Map<String, dynamic> json){ 
        return FinancialDetailModel(
            costType: json["cost_type"],
            startDate: DateTime.tryParse(json["start_date"] ?? ""),
            endDate: DateTime.tryParse(json["end_date"] ?? ""),
            branchName: json["branch_name"],
            details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
        );
    }

    @override
    List<Object?> get props => [
    costType, startDate, endDate, branchName, details, ];
}

class Detail extends Equatable {
    const Detail({
        required this.itemDescription,
        required this.amount,
        required this.transactionDate,
        required this.relatedDocumentId,
    });

    final String? itemDescription;
    final int? amount;
    final DateTime? transactionDate;
    final String? relatedDocumentId;

    factory Detail.fromJson(Map<String, dynamic> json){ 
        return Detail(
            itemDescription: json["item_description"],
            amount: json["amount"],
            transactionDate: DateTime.tryParse(json["transaction_date"] ?? ""),
            relatedDocumentId: json["related_document_id"],
        );
    }

    @override
    List<Object?> get props => [
    itemDescription, amount, transactionDate, relatedDocumentId, ];
}
