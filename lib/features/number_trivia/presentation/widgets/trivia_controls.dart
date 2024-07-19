import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({super.key});

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(errorMessage!, style: const TextStyle(color: Colors.red)),
          ),
        const Gap(10.0),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Input a number',
        errorText: errorMessage,
      ),
      onChanged: (value) {
        if (errorMessage != null) {
          setState(() {
            errorMessage = null;
          });
        }
      },
      onSubmitted: (_) => _addConcreteEvent(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _addRandomEvent,
            child: const Text('Get Random Trivia'),
          ),
        ),
        const Gap(10.0),
        Expanded(
          child: ElevatedButton(
            onPressed: _addConcreteEvent,
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
    );
  }

  void _addConcreteEvent() {
    final inputNumber = int.tryParse(controller.text);
    if (inputNumber == null) {
      setState(() {
        errorMessage = 'Please enter a valid number';
      });
      return;
    }
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumberEvent(controller.text));
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  void _addRandomEvent() {
    FocusScope.of(context).unfocus();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(const GetTriviaForRandomNumberEvent());
  }
}
