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
        title:
            const Text('Number Trivia', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => get<NumberTriviaBloc>(),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Gap(10.0),
            TriviaContent(),
            Gap(10.0),
            TriviaControls(),
          ],
        ),
      ),
    );
  }
}

class TriviaContent extends StatelessWidget {
  const TriviaContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is EmptyState) {
          return const MessageDisplay(message: 'Start Searching!');
        } else if (state is LoadingState) {
          return const LoadingWidget();
        } else if (state is LoadedState) {
          return TriviaDisplay(numberTrivia: state.trivia);
        } else if (state is ErrorState) {
          return MessageDisplay(message: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
