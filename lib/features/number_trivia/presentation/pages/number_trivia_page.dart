import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/widgets_export.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[700],
        title: const Text(
          'Number Trivia',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => get<NumberTriviaBloc>(),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const Gap(10.0),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is EmptyState) {
                    return const MessageDisplay(
                      message: 'Start Searching!',
                    );
                  } else if (state is LoadingState) {
                    return const LoadingWidget();
                  } else if (state is LoadedState) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is ErrorState) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const Gap(10.0),
            const TriviaControls(),
          ],
        ),
      ),
    );
  }
}
