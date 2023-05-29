import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final numberFormatter = NumberFormat("#,##0.00", "nl_NL");

class MoneyFormField extends FormField<int> {
  MoneyFormField({
    super.key,
    int initialValue = 0,
    FormFieldSetter<int>? onSaved,
    FormFieldValidator<int>? validator,
    ValueChanged<int>? onChanged,
    InputDecoration? decoration,
    bool allowNegative = true,
    bool autofocus = false,
    TextAlign textAlign = TextAlign.start,
    TextStyle? style,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<int> state) {
            return TextFormField(
              initialValue: numberFormatter.format(initialValue / 100.0),
              textAlign: textAlign,
              inputFormatters: [
                MoneyInputFormatter(allowNegative: allowNegative),
              ],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              style: style,
              decoration: decoration,
              autofocus: autofocus,
              onChanged: (value) {
                final number = int.tryParse(value
                    .replaceAll(numberFormatter.symbols.GROUP_SEP, '')
                    .replaceAll(numberFormatter.symbols.DECIMAL_SEP, ''));
                if (number == null) {
                  return;
                }
                onChanged?.call(number);
              },
            );
          },
        );
}

class MoneyInputFormatter extends TextInputFormatter {
  final bool allowNegative;

  MoneyInputFormatter({this.allowNegative = true});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '0.00');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,##0.00");
      final number = int.tryParse(newValue.text
          .replaceAll(f.symbols.GROUP_SEP, '')
          .replaceAll(f.symbols.DECIMAL_SEP, ''));
      if (number == null) {
        if (allowNegative &&
            (newValue.text == '0.00-' || newValue.text == '-')) {
          return newValue.copyWith(
            text: '-0.00',
            selection: const TextSelection.collapsed(offset: 5),
          );
        }
        print('number is null $newValue');
        return oldValue;
      }
      final newString = f.format(number / 100.0);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
