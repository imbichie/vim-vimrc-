" MCCB - Move the Character to the Column from the Begin of line
" This is a function for Moving the specified Character 
" in a given range of lines to a the specified Column from the Begin of the line
" NOTE 1 :- If the specified character and the first character of the line are same
"           then the number of Occurance (num_occr) will be one less than the actual
" NOTE 2 :- Maximum space between the specified character with in the range 
"           of lines should be less than or equal to 80, if we need more than 80
"           then we need to insert more spaces by increasing the value 80 in the 
"           "nmap s 80i <ESC>" line inside the function
" Usage :-  in command mode do it like below
" Eg 1:-    :5,11call MCCB(1, '=', 8)
"           The above command will move the 1st Occurance from the begin of Character =
"           to the 8th Column of the lines from 5 to 11
" Eg 2 :-   :7,10call MCCB(2, '+', 12)
"           The above command will move the 2nd Occurance of Character = to the 12th
"           Column of the lines from 7 to 10
    function! MCCB (num_occr, mv_char, col_num) range
        if (a:firstline <= a:lastline)
            nmap s 80i <ESC>
            let line_num = a:firstline
            while line_num <= a:lastline
                execute "normal " . line_num . "G0" . a:num_occr . "f" . a:mv_char . "s" . a:col_num . "|dw"
                let line_num = line_num + 1
            endwhile
            nunmap s
        else
            execute printf('ERROR : Start line %d is higher thatn End line %d, a:firstline, a:lastline)
        endif
    endfunction
    
" MCCE - Move the Character to the Column from the End of line
" This is a function for Moving the specified Character 
" in a given range of lines to a the specified Column from the End of the line
" NOTE 1 :- If the specified character and the last character of the line are same
"           then the number of Occurance (num_occr) will be one less than the actual
" NOTE 2 :- Maximum space between the specified character with in the range 
"           of lines should be less than or equal to 80, if we need more than 80
"           then we need to insert more spaces by increasing the value 80 in the 
"           "nmap s 80i <ESC>" line inside the function
" Usage :-  in command mode do it like below
" Eg 1:-    :5,11call MCCE(1, ';', 20)
"           The above command will move the 1st Occurance from the End of Character ;
"           to the 20th Column of the lines from 5 to 11
" Eg 2 :-   :7,10call MCCE(5, 'i', 26)
"           The above command will move the 5th Occurance from the End of Character i
"           to the 26th Column of the lines from 7 to 10
    function! MCCE (num_occr, mv_char, col_num) range
        if (a:firstline <= a:lastline)
            nmap s 80i <ESC>
            let line_num = a:firstline
            while line_num <= a:lastline
                execute "normal " . line_num . "G$" . a:num_occr . "F" . a:mv_char . "s" . a:col_num . "|dw"
                let line_num = line_num + 1
            endwhile
            nunmap s
        else
            execute printf('ERROR : Start line %d is higher thatn End line %d, a:firstline, a:lastline)
        endif
    endfunction
