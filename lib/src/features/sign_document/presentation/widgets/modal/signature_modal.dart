import 'package:all_legal/src/features/sign_document/presentation/bloc/sign_document/sign_document_bloc.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

class SignatureModal extends StatelessWidget {
  const SignatureModal._({required this.signDocumentBloc});

  static void show(BuildContext context,
      {required SignDocumentBloc signDocumentBloc}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => SignatureModal._(
        signDocumentBloc: signDocumentBloc,
      ),
    );
  }

  final SignDocumentBloc signDocumentBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: signDocumentBloc,
      child:
          BlocSelector<SignDocumentBloc, SignDocumentState, List<PdfEntitie>>(
        selector: (state) => state.signs,
        builder: (context, signs) {
          return BottomSheetBase(
            isDismissible: true,
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Column(
              children: [
                Text(
                  'Firmas',
                  style: context.textTheme.titleLarge?.copyWith(fontSize: 24),
                ),
                gap30,
                Expanded(
                  child: ListView.separated(
                    padding: edgeInsetsH20,
                    separatorBuilder: (context, index) => gap10,
                    itemCount: signs.length,
                    itemBuilder: (context, index) {
                      String filePath = signs[index].filePath;
                      String fileName = p.basename(filePath);

                      return AlCard(
                        onPressed: () {
                          signDocumentBloc.add(
                            SignDocumentEvent.selectedSignature(signs[index]),
                          );
                          Navigator.pop(context);
                        },
                        padding: edgeInsets16,
                        shadow: false,
                        child: Row(
                          children: [
                            Icon(
                              Icons.more_vert_sharp,
                              color: context.theme.primaryColor,
                            ),
                            space10,
                            Expanded(
                              child: Text(fileName,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                      color: context.theme.colorScheme.primary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
