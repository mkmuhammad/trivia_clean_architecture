import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    super.key,
  });

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputStr = '';
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            addConcreteEvent();
          },
        ),
        const Gap(10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: addRandomEvent,
                child: const Text('Get Random Trivia'),
              ),
            ),
            const Gap(10.0),
            Expanded(
              child: ElevatedButton(
                onPressed: addConcreteEvent,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.tealAccent[700]),
                ),
                child: const Text(
                  'Search Trivia',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addConcreteEvent() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumberEvent(inputStr));
  }

  void addRandomEvent() {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(const GetTriviaForRandomNumberEvent());
  }
}
