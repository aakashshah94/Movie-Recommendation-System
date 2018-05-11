-show all the data
(from other files as well)

-show the list approach giving scores to each one
1>person_prop 
likes(genre,action).
likes(genre,suspense).
likes(time,new).
likes(studio,marvel).

2>person_prop
likes(genre,scifi).
likes(genre,suspense).
likes(time,old).
likes(studio,vb).


command:rec1(Z).
score given to both the movies

-show rec2(Z,Age).
  show that watching with and abnormal works
  show that sorting works
  sohw that not providing likes takes defaults
  if you specify it takes those only.
  
  



-show the 2 argument recommend approach
 show the rule, show that how abnormal is implemented,show watching with family, basis for all others
-show the main 3 argument recommend

1>recommend(X,aakash,10)
	1-person_prop
		nothing
	no change
	avengers recommended
	murder not recommend
	alien recommended
	
	if you change any of the defaults ,..same will not be recommended..change age_studio(kids,[pixar,vb]).

2>recommend(X,aakash,25).
   1-person_prop
      nothing
	2-  
	age_genre(kids,[animation,action,comedy,suspense]).	
	age_genre(youth,[comedy,suspense]).
	age_genre(oldpeople,[drama,suspense,comedy]).


	age_time(kids,[new]).
	age_time(youth,[old,new,normal]).
	age_time(oldpeople,[old,normal]).

	age_studio(kids,[jungle,pixar,dc,marvel]).
	age_studio(youth,[dc,marvel,za,jungle,vb]).
	age_studio(oldpeople,[za,vb,dharmaproduction,priyadarshan]).

	show that changing it to 15 will not recommend murder
	alien recommend
	show that with family with age 25 also does not recommend murder

3>recommend(X,aakash,45).

	1>movie-prop
		age_genre(kids,[animation,action,comedy,suspense]).
		age_genre(youth,[comedy,suspense]).
		age_genre(oldpeople,[drama,comedy]).


		age_time(kids,[new]).
		age_time(youth,[old,new,normal]).
		age_time(oldpeople,[old,normal]).

		age_studio(kids,[jungle,pixar,dc,marvel]).
		age_studio(youth,[dc,marvel,za,jungle,vb]).
		age_studio(oldpeople,[za,vb,dharmaproduction,priyadarshan]).

     does not recommend anything	
	 
	 but adding specific genre works
	 
4>recommend(X,aakash,45).
   1>person_prop:
       likes(genre,suspense).   
	   
	remove vb from age_studio(oldpeople,)
    will not recommned murder
5>

show that similar kind of thing is implemented for each one
show all the rules


6>recommend(X,aakash,25).

   1>person_prop:
		likes(actor,emraan).
		
	recommends(murder)
	
	 removing emraan and adding srk
	 will not suggest murder
	 
	 
	
	