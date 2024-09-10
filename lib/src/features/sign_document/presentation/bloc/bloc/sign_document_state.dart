part of 'sign_document_bloc.dart';

enum PdfStatus {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class SignDocumentState with _$SignDocumentState {
  const factory SignDocumentState({
    @Default([]) List<PdfEntitie> pdfs,
    @Default(PdfStatus.initial) PdfStatus status,
  }) = _SignDocumentState;
}
