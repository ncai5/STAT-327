# 20181025
a = c("Brown,Joe 123456789 jbrown@wisc.edu 1000",
      "Roukos,Sally 456789123 sroukos@wisc.edu 5000",
      "Chen,Jean 789123456 chen@wisc.edu 24000",
      "Juniper,Jack 345678912 jjuniper@wisc.edu 300000")

gsub(pattern = "[aeiou]", replacement = "", x = a) # strip vowels
[1] "Brwn,J 123456789 jbrwn@wsc.d 1000"     "Rks,Slly 456789123 srks@wsc.d 5000"   
[3] "Chn,Jn 789123456 chn@wsc.d 24000"      "Jnpr,Jck 345678912 jjnpr@wsc.d 300000"

gsub(pattern = "[^aeiou]", replacement = "", x = a) # strip non-vowels
[1] "ooeoieu"    "ouoaouoieu" "eeaeieu"    "uieauieieu"

grep(pattern = ".n", x = a) # dot means any one character
[1] 1 3 4

grep(pattern = "s.w", x = a)
[1] 2

grep(pattern = "^J", x = a) # start with
[1] 4

gsub(pattern="3",replacement = "three",x=a)
[1] "Brown,Joe 12three456789 jbrown@wisc.edu 1000"           
[2] "Roukos,Sally 45678912three sroukos@wisc.edu 5000"       
[3] "Chen,Jean 78912three456 chen@wisc.edu 24000"            
[4] "Juniper,Jack three45678912 jjuniper@wisc.edu three00000"

grep(pattern = "\\d", x = a)
grep(pattern = "\\d{10}", x = a)

b=c("3","234","a5v2c1","hello");
b

grep(pattern = "\\d", x = b) # digit
[1] 1 2 3 4
grep(pattern = "\\d{3}", x = b) # braces: 3 consecutive digits
[1] 2
gsub(pattern = "\\D",replacement = "#", x = b) # inverse of digit
[1] "3"      "234"    "#5#2#1" "#####"
gsub(pattern = "\\D{3}",replacement = "#", x = b) 
[1] "3"      "234"    "a5v2c1" "#lo"

b=c("3","234","a5v2c1","hello","_","!!!!")
grep(pattern = "\\w", x = b) # word, digit, under score
[1] 1 2 3 4 5
grep(pattern = "\\w{5}", x = b)
[1] 3 4

d=c("3r","!2rs")
gsub(pattern = "\\w", replacement = "#", x = d)
[1] "##"   "!###"
gsub(pattern = "\\w{3}", replacement = "#", x = d) # treat it like whole
[1] "3r" "!#"

f=c("3 r","!  2rs","kr3"," ")
grep(pattern = "\\s", x = f) # space
[1] 1 2 4
grep(pattern = "\\s{2}", x = f)
[1] 2
grep(pattern = "\\S", x = f) # non space
[1] 1 2 3
grep(pattern = "\\S{2}", x = f)
[1] 2 3
gsub(pattern = "\\S", replacement = "#", x = f)
[1] "# #"    "#  ###" "###"    " "

a = c("Brown,Joe 123456789 jbrown@wisc.edu 1000",
      "Roukos,Sally 456789123 sroukos@wisc.edu 5000",
      "Chen,Jean 789123456 chen@wisc.edu 24000",
      "Juniper,Jack 345678912 jjuniper@wisc.edu 300000")

gsub(pattern = "[aeiou]", replacement = "", x = a) # strip vowels
[1] "Brwn,J 123456789 jbrwn@wsc.d 1000"     "Rks,Slly 456789123 srks@wsc.d 5000"   
[3] "Chn,Jn 789123456 chn@wsc.d 24000"      "Jnpr,Jck 345678912 jjnpr@wsc.d 300000"
gsub(pattern = "[^aeiou]", replacement = "", x = a) # strip non-vowels
[1] "ooeoieu"    "ouoaouoieu" "eeaeieu"    "uieauieieu"

grep(pattern = "^r", x = a)
integer(0)
grep(pattern = "^r", ignore.case = TRUE, x = a) # start with r 
[1] 2
gsub(pattern = "n\\>", replacement = "#",x = a) # end with n
[1] "Brow#,Joe 123456789 jbrow#@wisc.edu 1000"        "Roukos,Sally 456789123 sroukos@wisc.edu 5000"   
[3] "Che#,Jea# 789123456 che#@wisc.edu 24000"         "Juniper,Jack 345678912 jjuniper@wisc.edu 300000"
gsub(pattern = "\\<J", replacement = "#",x = a) # end with J
[1] "Brown,#oe 123456789 jbrown@wisc.edu 1000"        "Roukos,Sally 456789123 sroukos@wisc.edu 5000"   
[3] "Chen,#ean 789123456 chen@wisc.edu 24000"         "#uniper,#ack 345678912 jjuniper@wisc.edu 300000"

b=c("3","234","a5v2c1","hello")
gsub(pattern = "\\d{3}",replacement = "#", x = b) 
[1] "3"      "#"      "a5v2c1" "hello"
gsub(pattern = "\\d{2}",replacement = "#", x = b) 
[1] "3"      "#4"     "a5v2c1" "hello" 
gsub(pattern = "\\d{2,}",replacement = "#", x = b) 
[1] "3"      "#"      "a5v2c1" "hello"
gsub(pattern = "\\d{1,}",replacement = "#", x = b) 
[1] "#"      "#"      "a#v#c#" "hello"
gsub(pattern = "\\d{0,}",replacement = "#", x = b) 
[1] "#"           "#"           "#a#v#c#"     "#h#e#l#l#o#"
gsub(pattern = "\\D{0,}",replacement = "#", x = b) 
[1] "#3#"     "#2#3#4#" "#5#2#1#" "#"
gsub(pattern = "\\D{2,}",replacement = "#", x = b) 
[1] "3"      "234"    "a5v2c1" "#"
gsub(pattern = "\\D{6,}",replacement = "#", x = b) 
[1] "3"      "234"    "a5v2c1" "hello"
gsub(pattern = "\\D{0}",replacement = "#", x = b) 
[1] "#3#"           "#2#3#4#"       "#a#5#v#2#c#1#" "#h#e#l#l#o#"
gsub(pattern = "\\D{1}",replacement = "#", x = b) 
[1] "3"      "234"    "#5#2#1" "#####"












