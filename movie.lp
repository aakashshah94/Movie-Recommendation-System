#include('moviedata.lp').
#include('movie_prop.lp').
#include('person_prop.lp').

%%%%%%%%%%%%%%%%%recommendation rules
-adult(X):- not adult(X).
recommend(X,Y):-movie(X),not abnor(X),genrerule(X),timerule(X),studiorule(X).


%%%%kids
recommend(X,Y,A):-movie(X),person(Y),A<13,specified_actor(Ac1),has_actor(X,Ac),likes(actor,Ac),not specified_genre(G),age_genre(kids,L1),age_genre_rule(X,L1,kids),not property(X,adult).
recommend(X,Y,A):-movie(X),person(Y),A<13,not specified_actor(Ac1),not specified_genre(G),age_genre(kids,L1),age_genre_rule(X,L1,kids),not property(X,adult).

recommend(X,Y,A):-movie(X),person(Y),A<13,specified_genre(T),genrerule(X,kids),not property(X,adult).
recommend(X,Y,A):-movie(X),person(Y),A<13,not specified_actor(Ac1),specified_genre(T),genrerule(X,kids),not property(X,adult).

%%%%youth
recommend(X,Y,A):-movie(X),person(Y),A>12,A<35,not ab(X,A),specified_actor(Ac1),has_actor(X,Ac),likes(actor,Ac),not specified_genre(G),age_genre(youth,L1),age_genre_rule(X,L1,youth).
recommend(X,Y,A):-movie(X),person(Y),A>12,A<35,not ab(X,A),not specified_actor(Ac1),not specified_genre(G),age_genre(youth,L1),age_genre_rule(X,L1,youth).


recommend(X,Y,A):-movie(X),person(Y),A>19,A<35,not ab(X,A),specified_actor(Ac1),has_actor(X,Ac),likes(actor,Ac),specified_genre(T),genrerule(X,youth).
recommend(X,Y,A):-movie(X),person(Y),A>19,A<35,not ab(X,A),not specified_actor(Ac1),specified_genre(T),genrerule(X,youth).

%%%old people
recommend(X,Y,A):-movie(X),person(Y),A>=35,not ab(X,A),specified_actor(Ac1),has_actor(X,Ac),likes(actor,Ac),not specified_genre(G),age_genre(oldpeople,L1),age_genre_rule(X,L1,oldpeople).
recommend(X,Y,A):-movie(X),person(Y),A>=35,not ab(X,A),not specified_actor(Ac1),not specified_genre(G),age_genre(oldpeople,L1),age_genre_rule(X,L1,oldpeople).

recommend(X,Y,A):-movie(X),person(Y),A>=35,not ab(X,A),specified_actor(R),has_actor(X,Ac),likes(actor,Ac),specified_genre(T),genrerule(X,oldpeople).
recommend(X,Y,A):-movie(X),person(Y),A>=35,not ab(X,A),not specified_actor(Ac1),specified_genre(T),genrerule(X,oldpeople).


specified_actor(Y):-likes(actor,M).



rec1(Z):-rec1([],Z).
rec1(Z,Z):-length(Z,0,N),N=:=4.
rec1(P,Z):-movie(X),not member(X,P),score_g(X,[],0,N),score_s(X,[],N,N1),score_t(X,[],N1,N2),rec1([X,N2|P],Z).

rec2(Z,A):-rec2([],Z,[],A).
rec2(Z,Z,Visited,A):-length(Visited,0,N),N=:=3.
rec2(P,Z,Visited,A):-movie(X),not member(X,Visited),not ab(X,A),actor_rule(X,0,N,A),rec2([X,N|P],Z,[X|Visited],A).
rec2(P,Z,Visited,A):-movie(X),not member(X,Visited),ab(X,A),rec2(P,Z,[X|Visited],A).



actor_rule(X,P,N,A):-specified_actor(G),score_actor(X,[],0,R),genre_rule_new(X,R,N,A).
actor_rule(X,P,N,A):-not specified_actor(G),genre_rule_new(X,0,N,A).

genre_rule_new(X,P,N,A):-specified_genre(G),score_g(X,[],P,R),time_rule_new(X,R,N,A).
genre_rule_new(X,P,N,A):-not specified_genre(G),get_genre_list(A,L1),score(X,L1,P,R),time_rule_new(X,R,N,A).


time_rule_new(X,P,N,A):-specified_time(G),score_t(X,[],P,R),studio_rule_new(X,R,N,A).
time_rule_new(X,P,N,A):-not specified_time(G),get_time_list(A,L1),score(X,L1,P,R),studio_rule_new(X,R,N,A).


studio_rule_new(X,P,N,A):-specified_studio(G),score_s(X,[],P,N).
studio_rule_new(X,P,N,A):-not specified_studio(G),get_studio_list(A,L1),score(X,L1,P,N).




get_genre_list(A,L):-A<13,age_genre(kids,L).
get_genre_list(A,L):-A>12,A<35,age_genre(youth,L).
get_genre_list(A,L):-A>=35,age_genre(oldpeople,L).

get_time_list(A,L):-A<13,age_time(kids,L).
get_time_list(A,L):-A>12,A<35,age_time(youth,L).
get_time_list(A,L):-A>=35,age_time(oldpeople,L).

get_studio_list(A,L):-A<13,age_studio(kids,L).
get_studio_list(A,L):-A>12,A<35,age_studio(youth,L).
get_studio_list(A,L):-A>=35,age_studio(oldpeople,L).

score(X,[],P,P).
score(X,[Z|T],P,N):-movie(X),property(X,Z),P1 is P+1,score(X,T,P1,N).
score(X,[Z|T],P,N):-movie(X),not property(X,Z),score(X,T,P,N).


score_actor(X,Lv,P,P):-length(Lv,0,N),N=:=3.
score_actor(X,Lv,P,N):-movie(X),likes(actor,Z),not member(Z,Lv),property(X,Z),P1 is P+1,score_actor(X,[Z|Lv],P1,N).
score_actor(X,Lv,P,N):-movie(X),likes(actor,Z),not member(Z,Lv),not property(X,Z),score_actor(X,[Z|Lv],P,N).
score_actor(X,Lv,P,N):-movie(X),actor(Z),not likes(actor,Z),not member(Z,Lv),score_actor(X,[Z|Lv],P,N).


score_g(X,Lv,P,P):-length(Lv,0,N),N=:=8.
score_g(X,Lv,P,N):-movie(X),likes(genre,Z),not member(Z,Lv),property(X,Z),P1 is P+1,score_g(X,[Z|Lv],P1,N).
score_g(X,Lv,P,N):-movie(X),likes(genre,Z),not member(Z,Lv),not property(X,Z),score_g(X,[Z|Lv],P,N).
score_g(X,Lv,P,N):-movie(X),genre(Z),not likes(genre,Z),not member(Z,Lv),score_g(X,[Z|Lv],P,N).

score_s(X,Lv,P,P):-length(Lv,0,N),N=:=2.
score_s(X,Lv,P,N):-movie(X),likes(studio,Z),not member(Z,Lv),property(X,Z),P1 is P+1,score_s(X,[Z|Lv],P1,N).
score_s(X,Lv,P,N):-movie(X),likes(studio,Z),not member(Z,Lv),not property(X,Z),score_s(X,[Z|Lv],P,N).
score_s(X,Lv,P,N):-movie(X),studio(Z),not likes(genre,Z),not member(Z,Lv),score_s(X,[Z|Lv],P,N).

score_t(X,Lv,P,P):-length(Lv,0,N),N=:=3.
score_t(X,Lv,P,N):-movie(X),likes(time,Z),not member(Z,Lv),property(X,Z),P1 is P+1,score_t(X,[Z|Lv],P1,N).
score_t(X,Lv,P,N):-movie(X),likes(time,Z),not member(Z,Lv),not property(X,Z),score_t(X,[Z|Lv],P,N).
score_t(X,Lv,P,N):-movie(X),time(Z),not likes(time,Z),not member(Z,Lv),score_t(X,[Z|Lv],P,N).


specified_genre(X):-genre(Z),likes(genre,Z).


length([],N1,N1).
length([X|T],P,N):- P1 is P+1,length(T,P1,N).


%%%%%%%%%%%%%%%%%%%%%%%genre%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
genrerule(X,Y):-genre(Z),property(X,Z),not -likes(genre,Z),not specified_time(T),age_time(Y,L1),time_age_rule(X,L1,Y).
genrerule(X,Y):-genre(Z),property(X,Z),not -likes(genre,Z),specified_time(T),timerule(X,Y).



age_genre_rule(X,Y,P):-movie(X),property(X,Z),member(Z,Y),not specified_time(G),age_time(P,L1),time_age_rule(X,L1,P).
age_genre_rule(X,Y,P):-movie(X),property(X,Z),member(Z,Y),specified_time(T),timerule(X,P).
	
specified_time(X):-time(B),likes(time,B).

specified_studio(X):-studio(Y),likes(studio,Y).

time_age_rule(X,Y,P):-property(X,Z),member(Z,Y),not specified_studio(S),age_studio(P,L1),studio_age_rule(X,L1).
time_age_rule(X,Y,P):-property(X,Z),member(Z,Y),specified_studio(S),studiorule(X).


%%%%%%%%%%%%%%%%%%%%%%time rule%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timerule(X,P):-time(M),property(X,M),not -likes(time,M),not specified_studio(S),age_studio(P,L1),studio_age_rule(X,L1).
timerule(X,P):-time(M),property(X,M),not -likes(time,M),specified_studio(S),studiorule(X).


%%%%%%%%%%%%%%%%%%%%%%%%studio rule%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%studiorule(X):-studio(S),property(X,S),not -likes(studio,S),specified_actor(Y),actor(Z),has_actor(X,Z),likes(actor,Z).
%studiorule(X):-studio(S),property(X,S),not -likes(studio,S),not specified_actor(Y).
studiorule(X):-studio(S),property(X,S),not -likes(studio,S).


%studio_age_rule(X,L1):-property(X,Z),member(Z,Y),specified_actor(Y),actor(Z),has_actor(X,Z),likes(actor,Z).
%studio_age_rule(X,L1):-property(X,Z),member(Z,Y),not specified_actor(Y).

studio_age_rule(X,L1):-property(X,Z),member(Z,L1).



member(X,[X|T]).
member(X,[H|T]):-member(X,T).

%%%%%%%%%%%abnormal conditions%%%%%%%%%%%%%%%%%%%%%%%%%5
-likes(genre,X):- not likes(genre,X),genre(Y),likes(genre,Y).
-likes(time,X):- not likes(time,X),time(Y),likes(time,Y).
-likes(studio,X):- not likes(studio,X),studio(Y),likes(studio,Y).

ab(X,A):-movie(X),A<18,property(X,adult).
ab(X,A):-movie(X),property(X,adult),watchingwith(family).

abnor(X,Y):-movie(X),person(Y),property(X,adult),-adult(Y).
abnor(X,Y):-movie(X),person(Y),property(X,adult),watchingwith(family).


%%%%%%%%%%%%sorting
sortmy(X,Y):-sortmy(X,[],Y).


sortmy([],P,P).
sortmy([X,Y|T],P,L):-insert(X,Y,P,S),sortmy(T,S,L).


insert(X,Y,[],[X,Y]).
insert(X,Y,[H,S|T],[X,Y,H,S|T]):- S =< Y.
insert(X,Y,[H,S|T],[H,S|T1]):- Y < S,insert(X,Y,T,T1).



