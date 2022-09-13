//
// StockMotion Coding Problem
// See [Problem.md] for requirements
//
// May have added a little more past the requirements, but this problem also helped introduce me to Dart
//

import 'dart:io';
import 'dart:convert';

/// Evaluates the [condition] against [responses]
bool EvaluateCondition(Map<String, String> condition, List<dynamic> responses) {
  int index = int.parse(condition["index"] as String);
  String action = condition["operator"] as String;
  String value = condition["value"] as String;

  int length = responses.length;

  if (index >= length)
    throw "Index out of range (given $index but only $length responses were given)";

  bool result = false;

  switch (action) {
    case "equals":
      if (responses[index] == value) result = true;
      break;
    case "notEquals":
      if (responses[index] != value) result = true;
      break;
    case "greaterThan":
      int responseInt = int.parse(responses[index]);
      int valueInt = int.parse(value);

      if (responseInt > valueInt) result = true;

      break;
    case "lessThan":
      int responseInt = int.parse(responses[index]);
      int valueInt = int.parse(value);

      if (responseInt < valueInt) result = true;

      break;
    case "contains":
      if ((responses[index] as String).contains(value)) result = true;
      break;
    default:
      throw "Unknown operation: $action";
  }

  return result;
}

/// Uses data from [input] (as path) to evaluate whether a condition will return true of false
List<bool> CheckCondition(String input) {
  // List<String>, but not sure how to convert result from json.decode to static type.
  List<dynamic> responses = <String>[];
  Map<String, String> condition = {};
  bool expectedOutput;

  // Parses file contents into Dart objects.
  {
    // Assumes file is formatted correctly.
    String fileContents = File(input).readAsStringSync();
    fileContents = fileContents.replaceAll('\'', '"');

    List<String> lines = fileContents.split("\n");
    expectedOutput = lines.removeLast() == "true";
    String rawResponses = lines.removeLast();

    responses = json.decode(rawResponses) as List<dynamic>;

    for (int i = 1; i < lines.length - 1; i++) {
      List<String> line = lines[i].split(':');
      String key = line[0].trim();
      String value = line[1].trim();
      value = value.replaceAll('"', '');

      if (value.endsWith(',')) value = value.substring(0, value.length - 1);

      condition[key] = value;
    }
  }

  return [EvaluateCondition(condition, responses), expectedOutput];
}

/// Takes in singular file path from [args] to read in and evaluate its condition
int main(List<String> args) {
  if (args.length < 1) {
    // Very primitive arg-parsing.
    throw "Expected at least one command-line argument (path to test file)";
  }

  int testIndex = 0;

  for (String input in args) {
    List<bool> output = CheckCondition(input);

    bool result = output[0];
    bool expectedResult = output[1];

    stdout.write("Test $testIndex: ");

    if (result == expectedResult)
      print("Passed");
    else
      print("Failed");

    testIndex++;
  }

  return 0;
}
