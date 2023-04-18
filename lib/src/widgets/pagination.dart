library pagination;

import 'package:flutter/material.dart';
import 'package:outfit/src/base/theme.dart';

class Pagination extends StatefulWidget {
  const Pagination(
      {super.key,

      /// Total number of pages
      required this.numOfPages,

      /// Current selected page
      required this.selectedPage,

      /// Number of pages visible in the widget between the previous and next buttons
      required this.pagesVisible,

      /// Callback function when a page is selected
      required this.onPageChanged,

      /// Style for the active page text

      /// Style for the active page button

      /// Style for the inactive page text

      /// Style for the inactive page button

      /// Icon for the previous button
      this.previousIcon,

      /// Icon for the next button
      this.nextIcon,

      /// Spacing between the individual page buttons
      this.spacing});

  final int numOfPages;
  final int selectedPage;
  final int pagesVisible;
  final Function onPageChanged;
  final Icon? previousIcon;
  final Icon? nextIcon;
  final double? spacing;

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  late int _startPage;
  late int _endPage;

  @override
  void initState() {
    super.initState();
    _calculateVisiblePages();
  }

  @override
  void didUpdateWidget(Pagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    _calculateVisiblePages();
  }

  void _calculateVisiblePages() {
    /// If the number of pages is less than or equal to the number of pages visible, then show all the pages
    if (widget.numOfPages <= widget.pagesVisible) {
      _startPage = 1;
      _endPage = widget.numOfPages;
    } else {
      /// If the number of pages is greater than the number of pages visible, then show the pages visible
      int middle = (widget.pagesVisible - 1) ~/ 2;
      if (widget.selectedPage <= middle + 1) {
        _startPage = 1;
        _endPage = widget.pagesVisible;
      } else if (widget.selectedPage >= widget.numOfPages - middle) {
        _startPage = widget.numOfPages - (widget.pagesVisible - 1);
        _endPage = widget.numOfPages;
      } else {
        _startPage = widget.selectedPage - middle;
        _endPage = widget.selectedPage + middle;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: widget.numOfPages > 6 ? WrapAlignment.start : WrapAlignment.spaceBetween,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Previous button
        InkWell(
          onTap: widget.selectedPage > 1
            ? () => widget.onPageChanged(widget.selectedPage - 1)
            : null,
          child: SizedBox(
            height: 40.0,
            width: 40.0,
            child: widget.previousIcon ?? Icon(Icons.arrow_back_ios,
              size: 15.0,
              color: widget.selectedPage > 1 ? AppColors.primaryColor : Colors.grey, 
            ),
          ),
        ),

        /// loop through the pages and show the page buttons
        for (int i = _startPage; i <= _endPage; i++)
          InkWell(
            onTap: () => widget.onPageChanged(i),
            child: AnimatedContainer(
              height: 40.0,
              width: 40.0,
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == widget.selectedPage
                    ? AppColors.primaryColor
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  '$i',
                  style: TextStyle(
                    color: i == widget.selectedPage
                    ? AppColors.white
                    : AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        InkWell(
          onTap: widget.selectedPage < widget.numOfPages
              ? () => widget.onPageChanged(widget.selectedPage + 1)
              : null,
          child: SizedBox(
            height: 40.0,
            width: 40.0,
            child: widget.nextIcon ?? Icon(Icons.arrow_forward_ios,
              size: 15.0,
              color: widget.selectedPage < widget.numOfPages ? AppColors.primaryColor : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
