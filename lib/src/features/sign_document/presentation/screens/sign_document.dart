import 'package:all_legal/src/core/core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignDocument extends StatelessWidget {
  const SignDocument._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const SignDocument._();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AlAppBar(
        automaticallyImplyLeading: false,
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsH20,
      child: Column(
        children: [
          gap20,
          Row(
            children: [
              InkWell(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.chevron_left,
                    size: 30,
                  )),
              space12,
              Text(
                'Firmar Documentos',
                style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.secondary, fontSize: 30),
              ),
            ],
          ),
          gap30,
          Expanded(
            child: TabBarCustom(
                dividerColor: Palette.black,
                colorTab: Colors.transparent,
                borderRadiusTab: BorderRadius.zero,
                paddingTab: EdgeInsets.zero,
                labelColor: Colors.black,
                heightTab: 60,
                unselectedLabelColor: Palette.smokeGray.withOpacity(.5),
                indicatorColor: Palette.darkCyan,
                defaultIndicator: true,
                boxShadowTab: const [],
                tabs: const [
                  Tab(
                    child: Column(
                      children: [
                        AlIcon(
                          icon: AllLegalIcons.doc,
                          // color: colorScheme.onSurface,
                          size: AlIconSize.medium,
                        ),
                        gap10,
                        Text(
                          'Cargar documentos',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        AlIcon(
                          icon: AllLegalIcons.doc,
                          // color: colorScheme.onSurface,
                          size: AlIconSize.medium,
                        ),
                        gap10,
                        Text(
                          'Indicar firmantes',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
                tabViews: const [
                  Text('data'),
                  Text('data')
                ]),
          )
        ],
      ),
    );
  }
}
