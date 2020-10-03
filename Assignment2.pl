book("J.K. Rowling", "Harry Potter and the Philospher's Stone", "Fantasy", 1997).
book("J.K. Rowling", "Harry Potter and the Chamber of Secrets", "Fantasy", 1998).
book("J.K. Rowling", "Harry Potter and the Prisoner of Azkaban", "Fantasy", 1999).
book("J.K. Rowling", "Harry Potter and the Goblet of Fire", "Fantasy", 2000).
book("J.K. Rowling", "Harry Potter and the Order of the Pheonix", "Fantasy", 2003).
book("J.K. Rowling", "Harry Potter and the Half-Blood Prince", "Fantasy", 2005).
book("J.K. Rowling", "Harry Potter and the Deathly Hallows", "Fantasy", 2007).
book("William Faulkner", "The Sound and the Fury", "Novel", 1929).
book("Harper Lee", "To Kill a Mockingbird", "Southern Gothic", 1960).
book("Charles Dickens", "Great Expectations", "Novel", 1861).
book("Salman Rushdie", "Midnight's Children", "Magic realism", 1981).
book("Walt Whitman", "Leaves of Grass", "Poetry", 1855).
book("Ernest Hemingway", "For Whom the Bell Tolls", "Novel", 1940).
book("Fyodor Dostoevsky", "The Idiot", "Philosophical novel", 1869).
book("James Joyce", "Ulysses", "Modernist novel", 1922).
book("Miguel de Cervantes", "Don Quixote", "Novel", 1605).
book("F. Scott Fitzgerald", "The Great Gatsby", "Tragedy", 1925).
book("Leo Tolstoy", "War and Peace", "Historical novel", 1869).
book("Vladimir Nabokov", "Lolita", "Novel", 1955).
book("William Shakespeare", "Hamlet", "Tragedy", 1601).
book("Homer", "Odyssey", "Epic", 1938).
book("William Faunlkner", "The Sound and the Fury", "Modernist novel", 1929).
book("J.R.R. Tolkin", "The Fellowship of the Ring", "Fantasy", 1954).
book("J.R.R. Tolkin", "Two Towers", "Fantasy", 1954).
book("J.R.R. Tolkin", "The Return of the King", "Fantasy", 1955).


search :-
            writeln("Welcome to catalog"), optionActivity. %just main query

%some handle options
optionActivity :-
            writeln("Select parametr to search:"), 
    		writeln("1 - Author"),
            writeln("2 - Book title"), 
            writeln("3 - Genre"), 
            writeln("4 - Year of publishing"), 
    		read_string(user_input,"\n","\r\t", _,Option),
            atom_string(Opt, Option),
    		check(Opt).

%checks wrote options and calls query
check(K):-
    	K == exit -> 
    		writeln("Farewell!"), fail;
    	K == '1' -> 
    		forauthor;
    	K == '2' ->  
    		fortitle;
     	K == '3' ->  
    		forgenre;
    	K == '4' ->  
    		foryearpub;
    	(writeln('Incorrect value!'), optionActivity).

%prints books and their attributes
printall(A,T,G,Y) :-
            writeln(''),
    		writeln('Book'),
            write('Author -- '), writeln(A),
			write('Title -- '), writeln(T),
			write('Genre -- '), writeln(G),
			write('Published -- '), writeln(Y),
			writeln('_________________________________'), writeln('').  %just for pretty output

%searchs books by author
forauthor:- writeln('Searching by author'), 
    		writeln('Write the author: '), 
            read_string(user_input,"\n", "\r\t",_,AuthorFinding), %user writes which author he needs
    		book(Author,Title, Genre, Yearpub),					%books query
    		AuthorFinding == Author,							%find books that have given  author
    		printall(Author,Title, Genre, Yearpub),fail;		%print all books that have given author
    			writeln("No more books."),						%If there are no more books (also message if user wrote query for non-existing book)
            writeln('Wanna search more?'), optionActivity.		%returns to option "menu"

fortitle:-	writeln('Searching by title'), 
			writeln('Write the title: '), 
            read_string(user_input,"\n","\r\t",_,TitleFinding),	%user writes which title he needs
			book(Author,Title, Genre, Yearpub),					%books query
			TitleFinding == Title,								%find books that have given title
            printall(Author,Title, Genre, Yearpub), fail;		%print all books that have given title
				writeln("No more books."),						%If there are no more books (also message if user wrote query for non-existing book)
    		writeln('Wanna search more?'), optionActivity.		%returns to option "menu"
                        
forgenre:-  writeln('Searching by genre'),
			writeln('Write the genre: '), 
            read_string(user_input,"\n","\r\t",_,GenreFinding),	%user writes which title he needs
			book(Author,Title, Genre, Yearpub),					%books query
			GenreFinding == Genre,								%find books that have given genre
            printall(Author,Title, Genre, Yearpub), fail;		%print all books that have given title
				writeln("No more books."),						%If there are no more books (also message if user wrote query for non-existing book)
    		writeln('Wanna search more?'), optionActivity.		%returns to option "menu"

foryearpub:-writeln('Searching by year of publishing'),
			writeln('Write the Lower bound: '), 
            read_string(user_input,"\n","\r\t",_,Low),		    %user writes lowerbound published year
    		writeln('Write the Upper bound: '), 
            read_string(user_input,"\n","\r\t",_,Up),		    %user writes upperbound	publishedyear
            checkbounds(Up,Low).
                
		
%find books that have given bound of published year            
checkbounds(Up,Low) :-
            (not(number_string(_,Up)), not(number_string(_, Low))) -> %no bounds
                turnToOptionActivity;
            (number_string(_,Up), number_string(_, Low))->            %two bounds are given
                turnToUpLow(Up, Low);
            number_string(_,Up) -> turnToUp(Up);                      %given only Upper bound
            turnToLow(Low).                                           %given only Lower bound

%if there are no bounds
turnToOptionActivity:-
            writeln("No more books."),                        %If there are no more books (also message if user wrote query for non-existing book)
            writeln('Wanna search more?'), optionActivity.      %returns to option "menu"

%if Upper and Lower bouds are written
turnToUpLow(Up, Low):- 
            book(Author, Title, Genre, Yearpub), number_string(UpNum, Up), number_string(LowNum, Low),
            Yearpub > LowNum-1, Yearpub < UpNum + 1,            %conditions for Year of publishing
            printall(Author,Title, Genre, Yearpub), fail;       %print all books that have given Yearpub
                writeln("No more books."),                      %If there are no more books (also message if user wrote query for non-existing book)
            writeln('Wanna search more?'), optionActivity.      %returns to option "menu" 

%if written only Upper bound
turnToUp(Up):-
            book(Author, Title, Genre, Yearpub), number_string(UpNum, Up),
            Yearpub < UpNum + 1,                                %condition for Year of publishing
            printall(Author,Title, Genre, Yearpub), fail;       %print all books that have given Yearpub
                writeln("No more books."),                      %If there are no more books (also message if user wrote query for non-existing book)
            writeln('Wanna search more?'), optionActivity.      %returns to option "menu" 

%if written only Upper bound
turnToLow(Low):-
            book(Author, Title, Genre, Yearpub), number_string(LowNum, Low),
            Yearpub > LowNum - 1,
            printall(Author,Title, Genre, Yearpub), fail;       %print all books that have given title
                writeln("No more books."),                      %If there are no more books (also message if user wrote query for non-existing book)
            writeln('Wanna search more?'), optionActivity.      %returns to option "menu" 




% to start program write 'search.' query and write options


