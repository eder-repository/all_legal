import 'package:all_legal/src/core/core.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllLegalApp extends StatefulWidget {
  const AllLegalApp({super.key, required this.iUploadDocumentRepository});

  final IUploadDocumentRepository iUploadDocumentRepository;

  @override
  State<AllLegalApp> createState() => _AllLegalAppState();
}

class _AllLegalAppState extends State<AllLegalApp> {
  late final GoRouter router;

  @override
  void initState() {
    router = AppRouter.router(
      context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => widget.iUploadDocumentRepository),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        themeMode: ThemeMode.light,
        theme: AlTheme.light,
        darkTheme: AlTheme.dark,
      ),
    );
  }
}
