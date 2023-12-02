exercise1(File) :-
    open(File, read, Stream),
    process_lines(Stream, 0, Sum),
    write('Sum: '), write(Sum), nl,
    close(Stream).

process_lines(Stream, Acc, Sum) :-
    read_line_to_codes(Stream, Line),
    (Line \= end_of_file ->
        process_line(Line, _, _, Number),
        NewAcc is Acc + Number,
        write(Number), nl,
        process_lines(Stream, NewAcc, Sum)
    ; Sum = Acc).


% Finished. Compute the output.
process_line([], First, Last, Out) :-
    Out is First * 10 + Last.

% Take the first digit from the list and use it.
process_line(List, First, _, Out) :-
    identify_digit(List, Digit),
    var(First),
    [_ | Tail] = List,
    process_line(Tail, Digit, Digit, Out).

% Take a digit from the list and retain it as a possible "last" value.
process_line(List, First, _, Out) :-
    identify_digit(List, Digit),
    [_ | Tail] = List,
    process_line(Tail, First, Digit, Out).

% Skip a non-digit character.
process_line([_ | Tail], First, Last, Out) :-
    process_line(Tail, First, Last, Out).


% Recognise a digit at the start of the list.
identify_digit([0'o, 0'n, 0'e | _], Digit) :- Digit = 1.
identify_digit([0't, 0'w, 0'o | _], Digit) :- Digit = 2.
identify_digit([0't, 0'h, 0'r, 0'e, 0'e | _], Digit) :- Digit = 3.
identify_digit([0'f, 0'o, 0'u, 0'r | _], Digit) :- Digit = 4.
identify_digit([0'f, 0'i, 0'v, 0'e | _], Digit) :- Digit = 5.
identify_digit([0's, 0'i, 0'x | _], Digit) :- Digit = 6.
identify_digit([0's, 0'e, 0'v, 0'e, 0'n | _], Digit) :- Digit = 7.
identify_digit([0'e, 0'i, 0'g, 0'h, 0't | _], Digit) :- Digit = 8.
identify_digit([0'n, 0'i, 0'n, 0'e | _], Digit) :- Digit = 9.
identify_digit([Head | _], Digit) :- code_digit(Head, Digit).


% Convert a character code to a digit.
code_digit(Code, Digit) :-
    code_type(Code, digit),
    Digit is Code - 48.
