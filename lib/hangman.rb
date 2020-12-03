#Load File
File.exist? "5desk.txt"
words=File.readlines "5desk.txt"
#selects word from list 
pick = words.select{|w| w.size>5&& w.size<12}.sample 
