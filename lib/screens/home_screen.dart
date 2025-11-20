import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../constants/constants.dart';
import '../styles/styles.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.uiAppTitle),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppStyles.backgroundGradient),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppStyles.backgroundGradient),
        child: SafeArea(
          child: BlocBuilder<FileBloc, FileState>(
            builder: (_, state) {
              final counter = StateUtils.getCounterFromState(state);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.paddingDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CounterCard(counter: counter),
                    const SizedBox(height: AppConstants.spacingLarge),
                    ActionButton(state: state),
                    const SizedBox(height: AppConstants.spacingLarge),
                    FileContentCard(state: state),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
