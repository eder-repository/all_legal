import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';

class TabBarCustom extends StatefulWidget {
  const TabBarCustom({
    super.key,
    this.heightTab = 42,
    this.paddingTab,
    this.boxShadowTab,
    this.colorTab = Palette.lightGrayishCyan,
    this.borderRadiusTab = borderRadius12,
    this.borderRadiusItem = borderRadius12,
    this.isScrollable = false,
    this.tabs = const <Tab>[],
    required this.tabViews,
    this.physics = const BouncingScrollPhysics(),
    this.tabViewPhysics = const BouncingScrollPhysics(),
    this.leading,
    this.trailing,
    this.labelStyle,
    this.labelColor = Palette.darkCyan,
    this.unselectedLabelStyle,
    this.unselectedLabelColor = Colors.black,
    this.currentTab = 0,
    this.onTab,
    this.onTabChanged,
    this.indicator,
    this.enableShadow = true,
    this.controller,
    this.bottom,
    this.indicatorColor,
    this.labelPadding,
    this.defaultIndicator = false,
    this.maxLines = 1,
    this.textAlign,
    this.style,
    this.dividerColor,
  });

  /// Item tab colour
  final double heightTab;

  /// Padding in Tab Bar
  final EdgeInsetsGeometry? paddingTab;

  /// Box Shadow in Tab Bar
  final List<BoxShadow>? boxShadowTab;

  /// Item tab colour
  final Color colorTab;

  /// Border radius of the tab
  final BorderRadius borderRadiusTab;

  /// Border radius of the item inside the tab
  final BorderRadius borderRadiusItem;

  /// The widget to display before the tabs.
  final bool isScrollable;

  /// The tabs to be displayed.
  final List<Tab> tabs;

  /// The views to be displayed.
  final List<Widget> tabViews;

  /// The physics used to scroll the tabs.
  final ScrollPhysics physics;

  /// The physics used to scroll the tabs.
  final ScrollPhysics tabViewPhysics;

  /// The widget to display before the tabs.
  final Widget? leading;

  /// The widget to display after the tabs.
  final Widget? trailing;

  /// The style of the text of the selected tab.
  final TextStyle? labelStyle;

  /// The color of the text of the selected tab.
  final Color? labelColor;

  /// The style of the text of the unselected tabs.
  final TextStyle? unselectedLabelStyle;

  /// The color of the text of the unselected tabs.
  final Color? unselectedLabelColor;

  /// The current Step.
  final int currentTab;

  /// On tab
  final ValueChanged<int>? onTab;

  /// On tab changed
  final ValueChanged<int>? onTabChanged;

  final EdgeInsetsGeometry? labelPadding;

  /// Sets the default indicator of the Tab Bar
  final bool defaultIndicator;

  /// The indicator used to indicate the selected tab.
  /// [TDotIndicator], [TRectangularIndicator],
  /// [TLineIndicator], [TIndicator]
  final Decoration? indicator;

  /// Enable Shadow of TabBar container
  final bool enableShadow;

  final TabController? controller;

  final Widget Function(int index)? bottom;

  /// The color of the tab selected.
  final Color? indicatorColor;

  final int maxLines;

  final TextAlign? textAlign;

  final TextStyle? style;

  final Color? dividerColor;

  @override
  State<TabBarCustom> createState() => _TabBarCustomState();
}

class _TabBarCustomState extends State<TabBarCustom>
    with SingleTickerProviderStateMixin {
  late int currentIndex = widget.currentTab;

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = widget.controller ??
        TabController(
          length: widget.tabViews.length,
          vsync: this,
          initialIndex: widget.currentTab,
        );
    _tabController.addListener(_currentIndexListener);
    super.initState();
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_currentIndexListener)
      ..dispose();
    super.dispose();
  }

  void _currentIndexListener() {
    setState(() => currentIndex = _tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        if (metrics is PageMetrics) {
          final page = (metrics.page ?? 0).round();
          widget.onTabChanged?.call(page);
        }
        return false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.tabs.isNotEmpty)
            Padding(
              padding: widget.paddingTab ??
                  const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: widget.heightTab,
                child: Row(
                  children: [
                    if (widget.leading != null) widget.leading!,
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            if (widget.enableShadow)
                              BoxShadow(
                                offset: const Offset(0, 2),
                                blurRadius: 50,
                                color: Palette.black.withOpacity(0.12),
                              ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: widget.borderRadiusTab,
                          child: Container(
                            height: widget.heightTab,
                            decoration: BoxDecoration(
                              borderRadius: widget.borderRadiusTab,
                              color: widget.colorTab,
                            ),
                            child: TabBar(
                              dividerColor: widget.dividerColor,
                              tabAlignment: widget.isScrollable
                                  ? TabAlignment.start
                                  : null,
                              labelPadding:
                                  widget.labelPadding ?? edgeInsetsH20,
                              onTap: widget.onTab,
                              controller: _tabController,
                              isScrollable: widget.isScrollable,
                              overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              unselectedLabelColor: widget.unselectedLabelColor,
                              labelColor: widget.labelColor,
                              labelStyle: widget.labelStyle ??
                                  context.textTheme.titleSmall,
                              unselectedLabelStyle: widget.unselectedLabelStyle,
                              physics: widget.physics,
                              indicator: widget.defaultIndicator
                                  ? null
                                  : widget.indicator ??
                                      BoxDecoration(
                                        color: widget.indicatorColor ??
                                            Palette.black,
                                        borderRadius: widget.borderRadiusItem,
                                      ),
                              indicatorColor: widget.indicatorColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: widget.tabs.map((element) {
                                return Tab(
                                  iconMargin: element.iconMargin,
                                  height: element.height,
                                  icon: element.icon,
                                  child: element.text != null &&
                                          element.child == null
                                      ? Transform.translate(
                                          offset: Offset(
                                            0,
                                            element.icon != null ? 0 : 2,
                                          ),
                                          child: Text(
                                            element.text.toString(),
                                            maxLines: widget.maxLines,
                                            textAlign: widget.textAlign,
                                            style: widget.style,
                                          ),
                                        )
                                      : element.child,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.trailing != null) widget.trailing!,
                  ],
                ),
              ),
            ),
          if (widget.bottom != null) widget.bottom!.call(currentIndex),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: widget.tabViewPhysics,
              children: widget.tabViews,
            ),
          ),
        ],
      ),
    );
  }
}
