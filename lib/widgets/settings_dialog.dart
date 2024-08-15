import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/providers/limit_provider.dart';
import 'package:image_gallery/utils/limits.dart';

class SettingsDialog extends ConsumerStatefulWidget {
  const SettingsDialog({super.key});

  @override
  ConsumerState<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends ConsumerState<SettingsDialog> {
  int? _value;

  @override
  Widget build(BuildContext context) {
    _value ??= ref.watch(requestLimitProvider);

    return AlertDialog(
      scrollable: true,
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: ref.read(requestLimitProvider) != _value
              ? () {
                  ref.read(requestLimitProvider.notifier).setLimit(_value!);
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text(
            'Apply',
          ),
        ),
      ],
      title: const Text('Settings'),
      content: Column(
        children: [
          const Text('Adjust the amount of images fetched with every request'),
          const SizedBox(height: 16),
          DropdownButton(
            value: _value,
            items: kRequestLimitOptions
                .map(
                  (option) =>
                      DropdownMenuItem(value: option, child: Text('${option.toString()} images')),
                )
                .toList(),
            onChanged: (limit) {
              if (limit != null) {
                setState(() {
                  _value = limit;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
