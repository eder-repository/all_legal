part of 'sign_document_bloc.dart';

@freezed
class SignDocumentEvent with _$SignDocumentEvent {
  const factory SignDocumentEvent.savePdf() = _SavePdf;
  const factory SignDocumentEvent.getListPdf() = _GetListPdf;
  const factory SignDocumentEvent.deletePdf(int index) = _DeletePdf;
}
