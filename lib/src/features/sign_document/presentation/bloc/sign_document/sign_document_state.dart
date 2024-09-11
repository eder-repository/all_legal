part of 'sign_document_bloc.dart';

enum PdfStatus {
  initial,
  loading,
  loaded,
  error,
}

enum SignatureStatus {
  initial,
  loading,
  loaded,
  error,
}

enum SignatureSignedStatus {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class SignDocumentState with _$SignDocumentState {
  const factory SignDocumentState({
    @Default([]) List<PdfEntitie> pdfs,
    @Default([]) List<PdfEntitie> signs,
    @Default(PdfStatus.initial) PdfStatus status,
    @Default(SignatureStatus.initial) SignatureStatus signatureStatus,
    PdfEntitie? selectedSignature,
    @Default(SignatureSignedStatus.initial)
    SignatureSignedStatus signatureSignedStatus,
    @Default([]) List<PdfEntitie> signedPdfs,
  }) = _SignDocumentState;
}
