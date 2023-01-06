/*Knowledge base*/

/*Tasks*/

activity('Know your Train: 12123 Deccan Queen Express').
tasks(route,'The train runs between Mumbai CSMT to Pune JN. It passes through 67 Intermediate stations and takes 3 scheduled halts - Karjat, Lonavla and Shivajinagar.').
tasks(fare,'
            2s - Rs. 105
            CC - Rs. 385
            EC - Rs. 995').

tasks(platform,'
                CSMT - 9
                KJT  - 1
                LNL  - 1
                SVJR - 2
                PUNE - 5').
tasks(timings,'The train departs from CSMT at 17:10 hrs and arrives Pune at 20:25 hrs').
tasks(coach,'ENG->EV1->DL1->D8->D7->D6->D5->D4->D3->PC->C4->C3->C2->C1->D2->D1->EOG').
tasks(rake, 'The train runs with exotic LHB boggies of green livery.').
tasks(locomotive, 'The train is hauled by WAP-7, The White Stallion').
tasks(pantry,'The train has a beautiful dining coach with a pantry car.').
tasks(info,'Mumbai CSMT PUNE Deccan queen express, also nicknamed as "Deccan chi Rani", was started on 1st june 1930 and It celebrated its 92nd birthday this year. It is the first Electric hauled train and the first train to feature a dining car').
tasks(day,'The train runs everyday between CSMT-PUNE').

/*tellme tasks*/
tellme(joke,'Why the cars could not go to petrol pump -
> Cause the petrol pump was on first floor').
tellme(sing,' I cannot sing ').

/*facts for checking if the person is in positive or negative mood*/
positive(happy).
positive(nice).
positive(well).
positive(good).
positive(excited).
negative(bored).
negative(sad).
negative(unwell).
negative(stressed).
negative(depressed).

/*facts for checking if the person is giving positive or negative feedback for gwen*/
positivef(awesome).
positivef(amazing).
positivef(nice).
positivef(smart).
positivef(interesting).
negativef(boring).
negativef(irritating).
negativef(stupid).
negativef(frustating).

/*dynamic list for randomly slecting a response*/
:- dynamic confuse/1.
confuse(['Please speak again.','Ok,thats something new.', 'Oh I see.', 'Oh,I didnt know that.']).


bholu:-
    write('Hello, Im Bholu, your guide for 12123 Deccan Queen Express.'),
    nl,
    bholu_loop.

bholu_loop:-
    write('Bholu:-'),
    nl,
    write('You can Ask Your Query about deccan queen express'),
    nl,
    write('Write your queries in Square brackets with comman seperated words'),
    nl,
    read(Input),
    nl,
    reply(Input).

/*can you questions*/
reply([can,you,tell,me,about,X | _ ]):-
    ( tasks(X,Y) /*check*/
    ->write( 'Yes i can tell you about '),write(X),nl,nl/*if fact checked*/
    ,bholu_loop
    ; write('No i cannot tell you about '),write(X),nl,nl/*else*/
    ,bholu_loop
    ).

/*intro reply*/
reply([hello,i,am,Name | _ ]) :-
    write('Hello, '), write(Name), write('! Pleased to meet you.'),nl,write('How can I Help You.'),nl,
    bholu_loop.

/* reply*/
reply([tell,me,about,X | _ ]):-
    ( tasks(X,Y)
    ->write(Y),nl,nl/*if fact checked*/
    ,bholu_loop
    ;write('Sorry, i cant tell about '),write(X),nl,nl/*else*/
    ,bholu_loop
    ).

/*perform tasks*/
reply([X | _]):-
    tasks(X,Y),write(Y),nl,nl,bholu_loop.

/*tell todays date*/
reply([tell,me,todays,date]) :-
    date(X),write(X),nl,nl,
    bholu_loop.

/*activities*/
reply([what,can,you,do | _ ]) :-
    write('I will help you '),activity(X),write(X),nl,nl,
    bholu_loop.

/*how are you reply*/
reply([how,are,you]) :-
    write('i am good, its nice talking to you.'),nl,
    write('How are you?'),nl,nl,
    bholu_loop.

/*reply to persons mood*/
reply([i,am,X | _ ]):-
    /*if positive mood*/
    (positive(X) ->
        write('Thats great that you are '),write(X),nl,nl,bholu_loop
    /*if negative mood*/
    ; (negative(X) ->
      write('Oh, please dont feel yourself '),write(X),nl,nl,bholu_loop
      /*else if didnt understood*/
    ; write('Oh i didnt knew it...'),nl,nl,bholu_loop
      )
).

/*reply to feedback*/
reply([you,are,X | _ ]):-
    /*if positive feedback*/
    (positivef(X) ->
       write('Thank you! You too are '),write(X),nl,nl,bholu_loop
       /*if negative feedback*/
    ; (negativef(X) ->
            write('I am sorry for being a '),write(X),write(' chatbot'),nl,nl,bholu_loop
       /*else if didnt understood feedback*/
      ; write('Oh i might be so...'),nl,nl,bholu_loop
      )
).

reply([bye | _ ]):-
    write('Felt nice talking to you!, Bye....').

reply([thanks | _ ]):-
    write('Felt nice talking to you!, For Additional Information contact us at 12345567890').

/*random reply if didnt understand query*/
reply([ Y | _ ]) :-
    retract(confuse([ Next | Rest ])),
    append(Rest, [ Next ], NewExcuseList),
    asserta(confuse(NewExcuseList)),
    write(Next), nl,nl,
    bholu_loop.

/*reply if the query is not in brackets*/
reply(X):-
    write('please type your query in square brackets.'),nl,nl,
    bholu_loop.
