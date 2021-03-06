#Homework 05
###2/20/2018 Wilton G. Burns 

####1. The primary reason for using Excel to set up data frames is that people like to have the columns aligned. However, if there are not too many columns, it may be faster to do the job in a plain text editor first and align the columns with tabs. In your text editor, type in (or copy and paste from here) the following lines of text:

```
First String    Second      1.22      3.4
Second          More Text   1.555555  2.2220
Third           x           3         124
```
Don’t worry about how many tab spaces are needed to set this up, just make sure the columns are aligned. Now, using a single regular expression, transform these lines into what we need for a `.csv` file:

```
First String,Second,1.2,3.4
Second,More Text,1.55555,2.2220
Third,x3,124
```

**1. Solution and explanation**
FIND = `\t+ ` searches for all the places with tabs and the `+ ` signifies any number of tabs (not just one) 
REPLACE = `, `

####2. A True Regex Story. I am preparing a collaborative NSF grant with a colleague at another university. One of the pieces of an NSF grant is a listing of potential conflicts of interest. NSF wants to know the first and last name of the collaborator and their institution.

Here are a few lines of my conflict list:

```
Ballif, Bryan, University of Vermont
Ellison, Aaron, Harvard Forest
Record, Sydne, Bryn Mawr
```

However, my collaborator asked me to please provide to her the list in this format:

```
Bryan Ballif (University of Vermont)
Aaron Ellison (Harvard Forest)
Sydne Record (Bryn Mawr)
```
Write a single regular expression that will make the change.

**2. Solution and explanation**
FIND = `(\w+), (\w+), (.*)` which  captures the three phrases separately (tricky part is getting the rest of the line)
REPLACE = `\2 \1 (\3) ` which reorders the names and puts a parantheses around the third phrase 


####3. A Second True Regex Story. A few weeks ago, at [Radio Bean’s](https://www.radiobean.com/) Sunday afternoon old-time music session, one of the mandolin players gave me a DVD with over 1000 historic recordings of old-time fiddle tunes.

The list of tunes (shown here as a single line of text) looks like this:

```
0001 Georgia Horseshoe.mp3 0002 Billy In The Lowground.mp3 003 Cherokee Shuffle.mp3 0004 Walking Cane.mp3
```

Unfortunately, in this form, you can’t re-order the file names to put them in alphabetical order. I thought I could just strip out the leading numbers, but this will cause a conflict, because, for wildly popular tunes such as “Shove That Pig’s Foot A Little Further In The Fire”, there are multiple copies somewhere in the list.

All of these files are on a single line, so first write a regular expression to place each file name on its own line:

```
0001 Georgia Horseshoe.mp3
0002 Billy In The Lowground.mp3
0003 Cherokee Shuffle.mp3
0004 Walking Cane.mp3
```
**3a. Solution and explanation**
FIND = `\s(\d{3,5}) ` which finds all the numbers with 3, 4, or 5 integers that have a space before them
REPLACE = `\n\1 ` which makes a line break in front of the number


Now write a regular expression to grab the four digit number and put it at the end of the title:

```
Georgia Horseshoe_0001.mp3
Billy In The Lowground_0002.mp3
Cherokee Shuffle_0003.mp3
Walking Cane_0004.mp3
```

**3b. Solution and explanation**
FIND =` (\d{3,5})\s(.*)(.mp3) `  which captures song number, song name, and  (.mp3) and makes them 3 separate phrases
REPLACE =` \2_\1\3 ` to get it in the desired order/format


####4. Here is a data frame with genus, species, and two numeric variables.

```
Camponotus,pennsylvanicus,10.2,44
Camponotus,herculeanus,10.5,3
Myrmica,punctiventris,12.2,4
Lasius,neoniger,3.3,55
```

Write a single regular expression to rearrange the data set like this:

```
C_pennsylvanicus,44
C_herculeanus,3
M_punctiventris,4
L_neoniger,55
```
**4a. Solution and explanation**
FIND = `(^\w)(\w+),(\w+)(.*)(\d+) ` which first captures the first letter, then captures the rest of the first one, then captures the next word, the next number, and the last number
REPLACE =` \1_\3,\5 ` which gives me only the elements in the correct format

Beginning with the original expression, rearrange it to abbreviate the species name like this:

```
C_penn,44
C_herc,3
M_punc,4
L_neon,55
```
**4b. Solution and explanation**
FIND = `(^\w)(\w+),(\w{1,4})(.*)(\d+) ` which captures the first letter of each line, the rest of that first word, the first 4 letters of the second word, then the rest of the line until the last number 
REPLACE = `\1_\3,\5 ` which puts it in the correct format
