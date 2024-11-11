import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal/bloc/filter/filter_bloc.dart';
import 'package:meal/bloc/filter/filter_event.dart';
import 'package:meal/bloc/filter/filter_state.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filters',
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          context.read<FiltersBloc>().add(UpdateFiltersEvent());
          await Future.delayed(const Duration(milliseconds: 100));
          return true;
        },
        child: BlocListener<FiltersBloc, FiltersState>(
          listener: (context, state) {
            if (state.status == FiltersStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to update filters: ${state.errorMessage}'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: BlocBuilder<FiltersBloc, FiltersState>(
            builder: (context, state) {
              return Column(
                children: [
                  SwitchListTile(
                    value: state.isGlutenFree,
                    onChanged: (isChecked) {
                      context.read<FiltersBloc>().add(UpdateFilterEvent(isGlutenFree: isChecked));
                    },
                    title: Text(
                      'Gluten-free',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    subtitle: Text(
                      'Only include gluten-free meals',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    contentPadding: const EdgeInsets.only(
                      left: 34,
                      right: 22,
                    ),
                  ),
                  SwitchListTile(
                    value: state.isLactoseFree,
                    onChanged: (isChecked) {
                      context.read<FiltersBloc>().add(UpdateFilterEvent(isLactoseFree: isChecked));
                    },
                    title: Text(
                      'Lactose-free',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    subtitle: Text(
                      'Only include lactose-free meals',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    contentPadding: const EdgeInsets.only(
                      left: 34,
                      right: 22,
                    ),
                  ),
                  SwitchListTile(
                    value: state.isVegetarian,
                    onChanged: (isChecked) {
                      context.read<FiltersBloc>().add(UpdateFilterEvent(isVegetarian: isChecked));
                    },
                    title: Text(
                      'Vegetarian',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    subtitle: Text(
                      'Only include vegetarian meals',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    contentPadding: const EdgeInsets.only(
                      left: 34,
                      right: 22,
                    ),
                  ),
                  SwitchListTile(
                    value: state.isVegan,
                    onChanged: (isChecked) {
                      context.read<FiltersBloc>().add(UpdateFilterEvent(isVegan: isChecked));
                    },
                    title: Text(
                      'Vegan',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    subtitle: Text(
                      'Only include vegan meals',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    contentPadding: const EdgeInsets.only(
                      left: 34,
                      right: 22,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
