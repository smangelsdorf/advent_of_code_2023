exercise1(File) :-
    open(File, read, Stream),
    process_lines(Stream, 0, Sum),
    write('Sum: '), write(Sum), nl,
    close(Stream).

process_lines(Stream, Acc, Sum) :-
    read_line(Stream, Line),
    (Line \= end_of_file ->
        atom_chars(Line, CharList),
        process_line(CharList, Number),
        NewAcc is Acc + Number,
        write(Number), nl,
        process_lines(Stream, NewAcc, Sum)
    ; Sum = Acc).

process_line([], _) :- false.
process_line([Head | Tail], Out) :-
    (char_digit(Head, Upper) ->
       (process_line(Tail, Upper, Out) ->
            true;
            Out is Upper * 10 + Upper);
        process_line(Tail, Out)).

process_line([], _, _) :- false.
process_line([Head | Tail], Upper, Out) :-
    (process_line(Tail, Upper, Out) ->
        true;
        (char_digit(Head, Lower) ->
            Out is Upper * 10 + Lower;
        false)).

read_line(Stream, Line) :-
    read_line_to_codes(Stream, LineCodes),
    (LineCodes = end_of_file -> Line = end_of_file ; atom_codes(Line, LineCodes)).

char_digit(Char, Digit) :-
    char_type(Char, digit),
    char_code(Char, Code),
    Digit is Code - 48.
