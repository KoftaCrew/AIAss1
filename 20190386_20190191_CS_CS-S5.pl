% Kareem Mohamed Morsy, ID: 20190386, Group: CS-S5, Program: CS
% David Emad Philip   , ID: 20190191, Group: CS-S5, Program: CS

% Utility Functions
append([], L, L).
append([H|T], L2, [H|NT]):-
	append(T, L2, NT).

member(H, [H|_]).
member(X, [_|T]) :- member(X, T).

not(X) :- X, !, fail.
not(_).

count([], 0).
count([_|T], N) :-
    count(T, N1), N is N1+1.
 
max(Max, [H|T], MaxGrade) :-
    (
        H > Max ->
            max(H, T, MaxGrade);
            max(Max, T, MaxGrade)
    ).

max(Max, [], MaxGrade) :-
    MaxGrade is Max.


% Task 1
studentsInCourse(C, Students):-
    studentsInCourse([], C, Students).
    
studentsInCourse(TmpList, C, Students):-
    student(X, C, N),
    not(member([X, N], TmpList)), !,
    append(TmpList, [[X, N]], TmpNewList),
    studentsInCourse(TmpNewList, C, Students).

studentsInCourse(TmpList, _, TmpList).
    
% Task 2
numStudents(C,Num):-
    studentsInCourse(C, Students),
    count(Students, Num).

% Task 3
studentCourseGrades(TmpList, S, Courses):-
    student(S, _, N),
    not(member(N, TmpList)), !,
    append(TmpList, [N], TmpNewList),
    studentCourseGrades(TmpNewList, S, Courses).

studentCourseGrades(TmpList, _, TmpList).

maxStudentGrade(S, MaxGrade) :-
    studentCourseGrades([], S, Courses),
    max(0, Courses, MaxGrade).

% Task 4 map 👍
digit(0, zero).
digit(1, one).
digit(2, two).
digit(3, three).
digit(4, four).
digit(5, five).
digit(6, six).
digit(7, seven).
digit(8, eight).
digit(9, nine).

convertNumberToDigitsWords(Grade, DigitsWords) :-
    D is Grade rem 10,
    DivGrade is Grade // 10,
    (
        Grade < 10 -> 
            digit(D, Word),
            append([], [Word], DigitsWords);
            convertNumberToDigitsWords(DivGrade, NewDigitsWords),
            digit(D, Word),
            append(NewDigitsWords, [Word], DigitsWords)
    ).

gradeInWords(S, C, DigitsWords):-
    student(S, C, Grade),
    convertNumberToDigitsWords(Grade, DigitsWords).

% Task 5
courseTaken(S, C) :-
    student(S, C, Grade),
    Grade > 50.

remainingCourses(S, C, Courses):-
	prerequisite(Pre, C),
    (
        not(courseTaken(S, Pre)) ->
        	remainingCourses(S, Pre, PrePreCourses),
        	append(PrePreCourses, [Pre], Courses);
            append([], [], Courses)
    ).
