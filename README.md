# StockMotion Interview Problem

At StockMotion, we use conditional logic in our database activity documents to dynamically customize the experience for an end user. At a high level, we have a JSON configuration that represents this conditional logic in the following way (somewhat simplified):

```
{
    index: 1,
    operator: 'equals',
    value: 'Yes'
}
```

We also have a list of responses that could look something like this:

```
['No', 'Yes', '2', '7', ...]
```

In this case, since the response value at index 1 equals 'Yes', then this condition returns True.

Your task is, create a solution that can read a JSON config (following the example above) and a list of responses
and returns a boolean (true/false) of whether or not the condition passes.

Your solution should pass the following test cases:

1.
    input:
    ```
    {
        index: 1,
        operator: 'equals',
        value: 'Yes'
    },
    ['No', 'Yes', '2', '7']
    ```

    output: true


2.
    input:
    ```
    {
        index: 0,
        operator: 'equals',
        value: 'False'
    },
    ['True', 'False', 'Sometimes']
    ```

    output: false

3.
    input:
    ```
    {
        index: 2,
        operator: 'equals',
        value: 'Sometimes'
    },
    ['True', 'False', 'Sometimes']
    ```

    output: true


Stretch:

If you finish the task above and want an additional challenge, try implementing some of these
additional 'operator' types. Here is a list of conditional operators we support:

- 'equals'
- 'notEquals'
- 'greaterThan'
- 'lessThan'
- 'contains' (if the result string contains the provided substring value, then true)

Example:
input:
```
{
    index: 0,
    operator: 'greaterThan',
    value: '0'
},
['1', '3', '2']
```

output: true

(note, you can assume that the 'value' provided in the case of greaterThan/lessThan will be a string
that can be converted to an integer)