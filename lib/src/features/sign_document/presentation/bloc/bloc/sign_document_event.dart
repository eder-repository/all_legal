part of 'sign_document_bloc.dart';

@freezed
class SignDocumentEvent with _$SignDocumentEvent {
  const factory SignDocumentEvent.savePdf() = _SavePdf;
  const factory SignDocumentEvent.getListPdf() = _GetListPdf;
  const factory SignDocumentEvent.deletePdf(int index) = _DeletePdf;
  const factory SignDocumentEvent.saveSignature() = _SaveSignature;
  const factory SignDocumentEvent.getSignature() = _GetSignature;
  const factory SignDocumentEvent.deleteSignature(int index) = _DeleteSignature;
  const factory SignDocumentEvent.selectedSignature(PdfEntitie sign) =
      _SelectedSignature;
}
