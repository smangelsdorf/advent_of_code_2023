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


% Only one digit from the line.
process_line([], First, Last, Out) :-
    var(Last), process_line([], First, First, Out).

% When we have two digits, compute the output.
process_line([], First, Last, Out) :-
    Out is First * 10 + Last.

% Take the first digit from the list and use it.
process_line(List, First, _, Out) :-
    take_digit(List, Digit, Rest),
    var(First),
    process_line(Rest, Digit, Digit, Out).

% Take a digit from the list and retain it as a possible "last" value.
process_line(List, First, _, Out) :-
    take_digit(List, Digit, Rest),
    process_line(Rest, First, Digit, Out).

% Skip a non-digit character.
process_line([_ | Rest], First, Last, Out) :-
    process_line(Rest, First, Last, Out).


% Take a digit from the list and return the rest of the list.
take_digit([Head | Tail], Digit, Rest) :-
    code_digit(Head, Digit),
    Rest = Tail.


% Convert a character code to a digit.
code_digit(Code, Digit) :-
    code_type(Code, digit),
    Digit is Code - 48.
