subject('LP','Логическое программирование').
subject('MTH','Математический анализ').
subject('FP','Функциональное программирование').
subject('INF','Информатика').
subject('ENG','Английский язык').
subject('PSY','Психология').
student(102,'Петров',[grade('LP',3),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(101,'Петровский',[grade('LP',5),grade('MTH',4),grade('FP',3),grade('INF',4),grade('ENG',2),grade('PSY',4)]).
student(104,'Иванов',[grade('LP',4),grade('MTH',5),grade('FP',5),grade('INF',4),grade('ENG',3),grade('PSY',3)]).
student(102,'Ивановский',[grade('LP',3),grade('MTH',4),grade('FP',3),grade('INF',3),grade('ENG',3),grade('PSY',5)]).
student(104,'Запорожцев',[grade('LP',3),grade('MTH',3),grade('FP',3),grade('INF',5),grade('ENG',5),grade('PSY',2)]).
student(101,'Сидоров',[grade('LP',5),grade('MTH',3),grade('FP',5),grade('INF',5),grade('ENG',4),grade('PSY',2)]).
student(103,'Сидоркин',[grade('LP',4),grade('MTH',4),grade('FP',2),grade('INF',3),grade('ENG',4),grade('PSY',3)]).
student(102,'Биткоинов',[grade('LP',4),grade('MTH',5),grade('FP',5),grade('INF',3),grade('ENG',3),grade('PSY',4)]).
student(103,'Эфиркина',[grade('LP',4),grade('MTH',5),grade('FP',3),grade('INF',3),grade('ENG',4),grade('PSY',4)]).
student(103,'Сиплюсплюсов',[grade('LP',3),grade('MTH',5),grade('FP',3),grade('INF',4),grade('ENG',3),grade('PSY',4)]).
student(103,'Программиро',[grade('LP',3),grade('MTH',5),grade('FP',4),grade('INF',3),grade('ENG',5),grade('PSY',4)]).
student(104,'Джаво',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',5),grade('ENG',3),grade('PSY',4)]).
student(103,'Клавиатурникова',[grade('LP',3),grade('MTH',2),grade('FP',3),grade('INF',2),grade('ENG',5),grade('PSY',4)]).
student(101,'Мышин',[grade('LP',5),grade('MTH',5),grade('FP',2),grade('INF',4),grade('ENG',4),grade('PSY',2)]).
student(104,'Фулл',[grade('LP',5),grade('MTH',4),grade('FP',5),grade('INF',4),grade('ENG',4),grade('PSY',4)]).
student(101,'Безумников',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(102,'Шарпин',[grade('LP',4),grade('MTH',3),grade('FP',2),grade('INF',3),grade('ENG',3),grade('PSY',4)]).
student(104,'Круглосчиталкин',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',2),grade('PSY',4)]).
student(103,'Решетников',[grade('LP',3),grade('MTH',3),grade('FP',5),grade('INF',5),grade('ENG',5),grade('PSY',4)]).
student(102,'Эксель',[grade('LP',4),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',4),grade('PSY',3)]).
student(102,'Текстописов',[grade('LP',5),grade('MTH',4),grade('FP',5),grade('INF',2),grade('ENG',3),grade('PSY',4)]).
student(103,'Текстописова',[grade('LP',3),grade('MTH',4),grade('FP',3),grade('INF',4),grade('ENG',4),grade('PSY',4)]).
student(101,'Густобуквенникова',[grade('LP',4),grade('MTH',5),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(102,'Криптовалютников',[grade('LP',4),grade('MTH',3),grade('FP',4),grade('INF',4),grade('ENG',3),grade('PSY',4)]).
student(104,'Блокчейнис',[grade('LP',4),grade('MTH',2),grade('FP',5),grade('INF',2),grade('ENG',5),grade('PSY',3)]).
student(102,'Азурин',[grade('LP',5),grade('MTH',2),grade('FP',5),grade('INF',5),grade('ENG',4),grade('PSY',5)]).
student(103,'Вебсервисов',[grade('LP',4),grade('MTH',5),grade('FP',4),grade('INF',5),grade('ENG',4),grade('PSY',4)]).
student(102,'Круглотличников',[grade('LP',3),grade('MTH',4),grade('FP',5),grade('INF',3),grade('ENG',4),grade('PSY',5)]).

average_grade([], 0, 0).
average_grade([grade(_, G)|T], Sum, Count) :-
    average_grade(T, Sum1, Count1),
    Sum is Sum1 + G,
    Count is Count1 + 1.

average_grade_student(Student, Avg) :-
    student(_, Student, Grades),
    average_grade(Grades, Sum, Count),
    Avg is Sum / Count.

passed_exams(Student) :-
    student(_, Student, Grades),
    \+ (member(grade(_, G), Grades), G < 3).

student_info(Student) :-
    average_grade_student(Student, Avg),
    (passed_exams(Student) -> Passed = 'Yes' ; Passed = 'No'),
    format('Student: ~w, Average Grade: ~2f, Passed: ~w~n', [Student, Avg, Passed]).

failed_students_count(Subject, Count) :-
    findall(Student, (student(_, Student, Grades), member(grade(Subject, G), Grades), G < 3), FailedStudents),
    length(FailedStudents, Count).

subject_info(Subject) :-
    subject(Subject, Name),
    failed_students_count(Subject, Count),
    format('Subject: ~w (~w), Failed Students: ~d~n', [Subject, Name, Count]).

max_average_student(Group, Student, MaxAvg) :-
    findall(Avg-Student, (student(Group, Student, _), average_grade_student(Student, Avg)), Avgs),
    max_member(MaxAvg-Student, Avgs).

group_info(Group) :-
    max_average_student(Group, Student, MaxAvg),
    format('Group: ~d, Top Student: ~w, Max Average Grade: ~2f~n', [Group, Student, MaxAvg]).


main :-
    findall(Student, student(_, Student, _), Students),
    maplist(student_info, Students),

    findall(Subject, subject(Subject, _), Subjects),
    maplist(subject_info, Subjects),

    findall(Group, student(Group, _, _), Groups),
    maplist(group_info, Groups).