
%%%%%%properties of movies%%%%%%%%%%%%%%%%%%%5
property(murder,suspense).
property(murder,old).
property(murder,adult).
property(murder,vb).

property(avengers,scifi).
property(avengers,action).
property(avengers,new).
property(avengers,ua).
property(avengers,marvel).

property(alien,scifi).
property(alien,suspense).
property(alien,new).
property(alien,jungle).



%%%%%%%%%%%%% actors %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
has_actor(avengers,emraan).


has_actor(murder,emraan).
has_actor(murder,malika).
has_lead(murder,malika).




%%%%%%%%%%%%%%%%%%%%%%actors%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
actor(emraan).
actor(malika).
actor(jeniffer).

%%%%%%%%%%%%%%%%%% gender of actor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
male(robert).
male(hrithik).
male(farhan).
male(paresh).
male(akshay).
male(srk).
male(amitabh).
male(emraan).
female(X):- not male(X).




%%%%%%%%%%%%%%age-genre%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%deafult likes%%%%%%%%%%%%%%%%%%%%
age_genre(kids,[animation,action,comedy,suspense]).	
	age_genre(youth,[comedy,suspense]).
	age_genre(oldpeople,[drama,suspense,comedy]).


	age_time(kids,[new]).
	age_time(youth,[old,new,normal]).
	age_time(oldpeople,[old,normal]).

	age_studio(kids,[jungle,pixar,dc,marvel]).
	age_studio(youth,[dc,marvel,za,jungle,vb]).
	age_studio(oldpeople,[za,vb,dharmaproduction,priyadarshan]).
