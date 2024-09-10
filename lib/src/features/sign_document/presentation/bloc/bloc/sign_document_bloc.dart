import 'dart:async';

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
}
