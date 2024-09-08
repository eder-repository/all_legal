import 'package:all_legal/src/core/core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const HomeScreen._();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return Scaffold(
      appBar: const AlAppBar(),
      body: Stack(
        children: [
          const Positioned(
            bottom: 180,
            right: -10,
            child: Opacity(
              opacity: .5,
              child: ALCachedImage(
                url:
                    'https://www.securitydata.net.ec/wp-content/uploads/2022/11/E-31-1.png',
                height: 150,
                width: 150,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: edgeInsetsH20,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gap30,
                          Text(
                            'Dashboard',
                            style: textTheme.headlineMedium?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                          gap4,
                          Text(
                            'Bienvenido Paul',
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.secondary,
                            ),
                          ),
                          gap30,
                          Align(
                            child: Text(
                              '¿Qué Quieres hacer?',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.tertiary,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          gap20,
                          DetailCard(
                            onTap: () =>
                                context.pushNamed(Routes.signDocuemnt.name),
                            title: 'Firmar Documentos',
                            description:
                                'Firmar Documentos electronicos y solicita firma de terceros',
                            prefixIcon: AlIcon(
                              icon: AllLegalIcons.doc,
                              color: colorScheme.onSurface,
                              size: AlIconSize.bigBigger,
                            ),
                          ),
                          gap20,
                          DetailCard(
                            title: 'Solicitudes de acceso a información',
                            description:
                                'Tienes 4 solicitudes de acceso a tu información personal',
                            prefixIcon: AlIcon(
                              icon: AllLegalIcons.doc_add,
                              color: colorScheme.onSurface,
                              size: AlIconSize.bigBigger,
                            ),
                          ),
                          gap20,
                          DetailCard(
                            title: 'Gestionar información personal',
                            description:
                                'Actualiza información, solicita acceso, rectificación, eliminación ',
                            prefixIcon: AlIcon(
                              icon: AllLegalIcons.phonelink_lock,
                              color: colorScheme.onSurface,
                              size: AlIconSize.bigBigger,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Smart Contracts Suite - Un producto de ',
                        style: textTheme.bodyMedium,
                        children: [
                          TextSpan(
                              text: 'Todolegal SAS ',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.secondary,
                                fontWeight: AppFontWeight.semiBold,
                              )),
                          TextSpan(
                              text: '- 2023',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: colorScheme.tertiary)),
                        ]),
                  ),
                  gap20,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
