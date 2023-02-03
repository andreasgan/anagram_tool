import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';

class CharInfo {
  String char;
  bool? used;
  CharInfo(this.char, {this.used});
}

class AnagramSolver extends HookWidget {
  const AnagramSolver({super.key});

  final anagram = 'dog in darkness teaching riots as train';

  List<CharInfo> getCharInfos(String input) {
    input = input.toLowerCase();
    var anagramChars = anagram.characters.map((c) => CharInfo(c)).toList();
    print(input);

    for (final inputC in input.characters) {
      anagramChars
          .firstWhereOrNull(
              (anagramC) => anagramC.used != true && inputC == anagramC.char)
          ?.used = true;
    }

    return anagramChars;
  }

  List<String> errors(String input) {
    input = input.toLowerCase();
    var anagramChars = anagram.characters.map((c) => CharInfo(c)).toList();
    print(input);

    List<String> result = [];
    for (final inputC in input.characters) {
      var a = anagramChars.where((anagramC) => inputC == anagramC.char);
      if (a.every((element) => element.used == true)) {
        result.add('overused: $inputC');
      } else {
        anagramChars
            .firstWhereOrNull(
                (anagramC) => anagramC.used != true && inputC == anagramC.char)
            ?.used = true;
      }
    }
    for (final inputC in input.characters) {}
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final tc = useTextEditingController();
    final text = useState("");
    final remainingCharInfos = useState<List<CharInfo>>(
        anagram.characters.map((c) => CharInfo(c)).toList());
    final charInfos = getCharInfos(text.value);

    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 50,
              child: Row(
                children: charInfos
                    .map(
                      (e) => Text(
                        e.char,
                        style: TextStyle(
                            backgroundColor: e.used == true
                                ? Color.fromARGB(255, 17, 108, 46)
                                : null),
                      ),
                    )
                    .toList(),
              )),
          const Text(
            'Unused characters: ',
            textAlign: TextAlign.start,
          ),
          Row(
            children: [
              ...charInfos
                  .where((c) =>
                      c.char != ' ' &&
                      //charInfos.firstWhere((ch) => ch.char == c.char) == c &&
                      c.used != true)
                  .map(
                    (e) => Text(
                      e.char,
                    ),
                  )
                  .toList()
            ],
          ),
          TextField(
            controller: tc,
            onChanged: (val) => text.value = val,
          ),
          ...errors(text.value).map((err) => Text(err))
        ],
      ),
    );
  }
}
