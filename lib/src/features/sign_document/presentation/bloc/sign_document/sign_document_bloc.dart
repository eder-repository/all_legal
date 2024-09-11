import 'dart:async';
import 'dart:io';

import 'package:all_legal_core/all_legal_core.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_document_bloc.freezed.dart';
part 'sign_document_event.dart';
part 'sign_document_state.dart';

class SignDocumentBloc extends Bloc<SignDocumentEvent, SignDocumentState> {
  SignDocumentBloc({
    required IUploadDocumentRepository uploadDocumentRepository,
  })  : _iUploadDocumentRepository = uploadDocumentRepository,
        super(const SignDocumentState()) {
    on<_SavePdf>(_onSavePdf);
    on<_GetListPdf>(_onGetListPdf);
    on<_DeletePdf>(_onDeletePdf);
    on<_SaveSignature>(_onSaveSignature);
    on<_GetSignature>(_onGetSignature);
    on<_DeleteSignature>(_onDeleteSignature);
    on<_SelectedSignature>(_onSelectedSignature);
    on<_SavePdfSigned>(_onSavePdfSigned);
    on<_GetPdfSigned>(_onGetPdfSigned);
  }

  final IUploadDocumentRepository _iUploadDocumentRepository;

  Future<void> _onSavePdf(
      _SavePdf event, Emitter<SignDocumentState> emit) async {
    final result = await _iUploadDocumentRepository.uploadDocument();
    if (result == true) {
      add(const SignDocumentEvent.getListPdf());
    }
  }

  Future<void> _onGetListPdf(
    _GetListPdf event,
    Emitter<SignDocumentState> emit,
  ) async {
    emit(state.copyWith(status: PdfStatus.loading));
    final pdfs = await _iUploadDocumentRepository.getSavedPDFs();

    emit(state.copyWith(pdfs: pdfs, status: PdfStatus.loaded));
  }

  Future<void> _onDeletePdf(
      _DeletePdf event, Emitter<SignDocumentState> emit) async {
    final pdfs = await _iUploadDocumentRepository.deletePdf(event.index);
    if (pdfs == true) {
      add(const SignDocumentEvent.getListPdf());
    }
  }

  Future<void> _onSaveSignature(
      _SaveSignature event, Emitter<SignDocumentState> emit) async {
    final result = await _iUploadDocumentRepository.saveSignature();
    if (result == true) {
      add(const SignDocumentEvent.getSignature());
    }
  }

  Future<void> _onGetSignature(
      _GetSignature event, Emitter<SignDocumentState> emit) async {
    emit(state.copyWith(signatureStatus: SignatureStatus.loading));
    final sign = await _iUploadDocumentRepository.getSignature();

    emit(state.copyWith(signs: sign, signatureStatus: SignatureStatus.loaded));
  }

  Future<void> _onDeleteSignature(
      _DeleteSignature event, Emitter<SignDocumentState> emit) async {
    final signs = await _iUploadDocumentRepository.deleteSignature(event.index);
    if (signs == true) {
      add(const SignDocumentEvent.getSignature());
    }
  }

  FutureOr<void> _onSelectedSignature(
      _SelectedSignature event, Emitter<SignDocumentState> emit) {
    emit(state.copyWith(selectedSignature: event.sign));
  }

  Future<void> _onSavePdfSigned(
      _SavePdfSigned event, Emitter<SignDocumentState> emit) async {
    await _iUploadDocumentRepository.savePdfSigned(event.file);
  }

  Future<void> _onGetPdfSigned(
      _GetPdfSigned event, Emitter<SignDocumentState> emit) async {
    emit(state.copyWith(signatureSignedStatus: SignatureSignedStatus.loading));
    final pdfs = await _iUploadDocumentRepository.getPdfSigned();
    emit(state.copyWith(
        signedPdfs: pdfs, signatureSignedStatus: SignatureSignedStatus.loaded));
  }
}
