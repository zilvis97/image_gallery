import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/providers/authors_provider.dart';

class FiltersDrawer extends ConsumerStatefulWidget {
  const FiltersDrawer({super.key});

  @override
  ConsumerState<FiltersDrawer> createState() => _FiltersDrawerState();
}

class _FiltersDrawerState extends ConsumerState<FiltersDrawer> {
  final Set<String> _selectedAuthors = {};

  @override
  void initState() {
    super.initState();
    _selectedAuthors.addAll(ref.read(selectedAuthorsProvider));
  }

  @override
  Widget build(BuildContext context) {
    final authors = ref.watch(authorsProvider);

    return Drawer(
      elevation: 32,
      width: 500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select authors to filter by',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            Expanded(
                child: Material(
              color: Colors.transparent,
              child: ListView.builder(
                itemBuilder: (ctx, idx) {
                  final author = authors.elementAt(idx);
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _selectedAuthors.contains(author),
                    onChanged: (selected) {
                      if (selected != null) {
                        setState(() {
                          if (selected) {
                            _selectedAuthors.add(author);
                          } else {
                            _selectedAuthors.remove(author);
                          }
                        });
                      }
                    },
                    title: Text(author),
                  );
                },
                itemCount: authors.length,
              ),
            )),
            const Spacer(),
            FilterBottomBar(_selectedAuthors),
          ],
        ),
      ),
    );
  }
}

class FilterBottomBar extends ConsumerWidget {
  const FilterBottomBar(this.selectedAuthors, {super.key});

  final Set<String> selectedAuthors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            ref.read(selectedAuthorsProvider.notifier).select(selectedAuthors);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
