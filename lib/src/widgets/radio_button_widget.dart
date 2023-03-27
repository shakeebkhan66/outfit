import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/home/views/outfit_ideas_view.dart';
import 'package:outfit/src/components/search/search_page.dart';
import 'package:reusables/reusables.dart';

class RadioWidgetController<T> extends ChangeNotifier {
  final List<T> items;
  T? value;
  final void Function(T) onChanged;

  RadioWidgetController({
    required this.items,
    required this.value,
    required this.onChanged,
  });

  void change(T? value) {
    this.value = value as T;
    notifyListeners();
    onChanged(value);
  }
}

class AppRadioGroup<T> extends ControlledWidget<RadioWidgetController<T>> {
  const AppRadioGroup({Key? key, required this.groupController})
      : super(key: key, controller: groupController);

  final RadioWidgetController<T> groupController;

  @override
  State<AppRadioGroup> createState() => _AppRadioGroupState();
}

class _AppRadioGroupState<T> extends State<AppRadioGroup<T>>
    with ControlledStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.controller.items
          .map(
            (e) => RadioListTile<T>(
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              activeColor: const Color(0xFF2770DC),
              contentPadding: EdgeInsets.zero,
              value: e,
              groupValue: widget.controller.value,
              onChanged: widget.controller.change,
              title: Text(
                e is Styles
                    ? e.value
                    : e is Hijab
                        ? e.value
                        : e is Seasons
                            ? e.value
                            : e.toString(),
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class SearchStyleRadioWidget<T>
    extends ControlledWidget<RadioWidgetController<T>> {
  const SearchStyleRadioWidget({Key? key, required this.groupController})
      : super(key: key, controller: groupController);

  final RadioWidgetController<T> groupController;

  @override
  State<SearchStyleRadioWidget> createState() => _SearchStyleRadioWidgetState();
}

class _SearchStyleRadioWidgetState<T> extends State<SearchStyleRadioWidget<T>>
    with ControlledStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.controller.items.map((e) {
        return Column(children: [
          RadioListTile<T>(
            dense: true,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            activeColor: AppColors.primaryColor,
            contentPadding: const EdgeInsets.fromLTRB(26, 14, 16, 16),
            value: e,
            controlAffinity: ListTileControlAffinity.trailing,
            groupValue: widget.controller.value,
            onChanged: widget.controller.change,
            title: Text(
              e is SearchStyle
                  ? e.value
                  : e is Hijab
                      ? e.value
                      : e is Seasons
                          ? e.value
                          : e is Styles
                              ? e.value
                              : e.toString(),
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: AppColors.blackColor,
              ),
            ),
          ),
          if (!(e is SearchStyle && e == SearchStyle.jacketCoat))
            const Divider(color: Color(0xFFE1DFDF), thickness: 1, height: 0),
        ]);
      }).toList(),
    );
  }
}
