class ContractModel {
  final int id;
  final String code;
  final String contractNumber;
  final String previousEndDate;
  final String startDate;
  final String endDate;
  final String status;
  final String contractDate;
  final bool expired;
  final DocumentTemplateModel docTemplate;
  final ContractTypeModel contractType;
  final DocumentModel contractDocument;

  ContractModel({
    required this.id,
    required this.code,
    required this.contractNumber,
    required this.previousEndDate,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.contractDate,
    required this.expired,
    required this.docTemplate,
    required this.contractType,
    required this.contractDocument,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json['id'],
      code: json['code'],
      contractNumber: json['contract_number'].toString(),
      previousEndDate: json['previous_end_date'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      status: json['status'],
      contractDate: json['contract_date'],
      expired: json['expired'],
      docTemplate: DocumentTemplateModel.fromJson(json['doc_template'] ?? {}),
      contractType: ContractTypeModel.fromJson(json['contract_type'] ?? {}),
      contractDocument: DocumentModel.fromJson(json['contract_document'] ?? {}),
    );
  }
}

class DocumentTemplateModel {
  final int id;
  final String name;
  final String file;

  DocumentTemplateModel({
    required this.id,
    required this.name,
    required this.file,
  });

  factory DocumentTemplateModel.fromJson(Map<String, dynamic> json) {
    return DocumentTemplateModel(
      id: json['id'],
      name: json['name'],
      file: json['file'],
    );
  }
}

class ContractTypeModel {
  final String name;
  final String duration;

  ContractTypeModel({required this.name, required this.duration});

  factory ContractTypeModel.fromJson(Map<String, dynamic> json) {
    return ContractTypeModel(name: json['name'], duration: json['duration']);
  }
}

class DocumentModel {
  final int contractId;
  final String file;
  final String? pdf;

  DocumentModel({required this.contractId, required this.file, this.pdf});

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      contractId: json['contract_id'],
      file: json['file'],
      pdf: json['pdf'],
    );
  }
}
