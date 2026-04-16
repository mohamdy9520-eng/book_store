import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/govornorate_cubit.dart';
import '../cubit/govornorate_state.dart';
import '../model/gov_nerate.dart';

class GovernorateList extends StatefulWidget {
  const GovernorateList({super.key});

  @override
  State<GovernorateList> createState() => _GovernorateListState();
}

class _GovernorateListState extends State<GovernorateList> {

  @override
  void initState() {
    super.initState();
    context.read<GovCubit>().getGovernorates(); // 🔥 أهم سطر
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GovCubit, GovState>(
      builder: (context, state) {

        if (state is GovLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GovError) {
          return Text(state.message);
        }

        if (state is GovSuccess) {
          final cubit = context.read<GovCubit>();
          final list = state.governorates;

          return DropdownButtonFormField<Governorate>(
            decoration: const InputDecoration(
              labelText: "Select Governorate",
              border: OutlineInputBorder(),
            ),

            value: cubit.selectedGovernorate,

            items: list.map((gov) {
              return DropdownMenuItem<Governorate>(
                value: gov,
                child: Text(gov.governorateNameEn),
              );
            }).toList(),

            onChanged: (value) {
              if (value != null) {
                cubit.changeGovernorate(value);
              }
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}