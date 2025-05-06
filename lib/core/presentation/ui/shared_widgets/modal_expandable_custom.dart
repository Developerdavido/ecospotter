import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import 'default_back_button.dart';

class ModalExpandableCustom extends StatefulWidget {
  final Stream<Map<String, dynamic>?> dataStream;
  final Widget Function(Map<String, dynamic> data, bool isExpanded) contentBuilder;
  final double collapsedHeight;
  final double expandedHeight;
  final Duration animationDuration;
  final Function()? onBackPressed;

  const ModalExpandableCustom({
    super.key,
    required this.dataStream,
    required this.contentBuilder,
    this.collapsedHeight = 100.0,
    this.expandedHeight = 400.0,
    this.onBackPressed,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<ModalExpandableCustom> createState() => _ModalExpandableCustomState();
}

class _ModalExpandableCustomState extends State<ModalExpandableCustom> with SingleTickerProviderStateMixin {
  Map<String, dynamic>? _currentData;
  bool _isExpanded = false;
  bool _isVisible = false;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();

    // Set up animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _heightAnimation = Tween<double>(
      begin: widget.collapsedHeight,
      end: widget.expandedHeight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Listen to the data stream
    widget.dataStream.listen((data) {
      setState(() {
        _currentData = data;
        _isVisible = data != null && data.isNotEmpty;

        // Reset to collapsed state when new data arrives
        if (_isExpanded && _isVisible) {
          _isExpanded = false;
          _animationController.reverse();
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _close() {
    setState(() {
      _isVisible = false;
      _isExpanded = false;
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible || _currentData == null) {
      return const SizedBox.shrink(); // Don't show anything if no data
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          height: _heightAnimation.value,
          decoration: BoxDecoration(
            color: AppColors.primaryColorWhiteBackground,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32.r),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.mainPrimaryColor.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Modal header with close button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultBackButton(
                      onBackTap: () {
                        _close();
                        widget.onBackPressed ?? (){};
                      },
                    ),
                    DefaultBackButton(
                      onBackTap: () {
                        _toggleExpand();
                      },
                      icon: _isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up
                    ),
                  ],
                ),
              ),

              // Divider
              const Divider(height: 1),

              // Modal content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: widget.contentBuilder(_currentData!, _isExpanded),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}