°
vC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Validations\VoterAgeAttribute.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
Validations( 3
{ 
public 

class 
VoterAgeAttribute "
:# $
ValidationAttribute% 8
{ 
	protected 
override 
ValidationResult +
?+ ,
IsValid- 4
(4 5
object5 ;
?; <
value= B
,B C
ValidationContextD U
validationContextV g
)g h
{ 	
if		 
(		 
value		 
is		 
DateOnly		 !
	dateValue		" +
)		+ ,
{

 
int 
age 
= 
DateOnly "
." #
FromDateTime# /
(/ 0
DateTime0 8
.8 9
Now9 <
)< =
.= >
Year> B
-C D
	dateValueE N
.N O
YearO S
;S T
if 
( 
	dateValue 
> 
DateOnly  (
.( )
FromDateTime) 5
(5 6
DateTime6 >
.> ?
Now? B
)B C
)C D
{ 
return 
new 
ValidationResult /
(/ 0
$str0 L
)L M
;M N
} 
else 
if 
( 
age 
< 
$num !
||" $
age% (
>) *
$num+ .
). /
{ 
return 
new 
ValidationResult /
(/ 0
$str0 h
)h i
;i j
} 
else 
{ 
return 
ValidationResult +
.+ ,
Success, 3
;3 4
} 
} 
return 
new 
ValidationResult '
(' (
$str( C
)C D
;D E
} 	
} 
} ó
zC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Validations\CandidateAgeAttribute.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
Validations( 3
{ 
public 

class !
CandidateAgeAttribute &
:' (
ValidationAttribute) <
{ 
	protected 
override 
ValidationResult +
?+ ,
IsValid- 4
(4 5
object5 ;
?; <
value= B
,B C
ValidationContextD U
validationContextV g
)g h
{ 	
if		 
(		 
value		 
is		 
DateOnly		 !
	dateValue		" +
)		+ ,
{

 
int 
age 
= 
DateOnly "
." #
FromDateTime# /
(/ 0
DateTime0 8
.8 9
Now9 <
)< =
.= >
Year> B
-C D
	dateValueE N
.N O
YearO S
;S T
if 
( 
	dateValue 
> 
DateOnly  (
.( )
FromDateTime) 5
(5 6
DateTime6 >
.> ?
Now? B
)B C
)C D
{ 
return 
new 
ValidationResult /
(/ 0
$str0 L
)L M
;M N
} 
if 
( 
age 
< 
$num 
|| 
age  #
>$ %
$num& (
)( )
{ 
return 
new 
ValidationResult /
(/ 0
$str0 j
)j k
;k l
} 
else 
{ 
return 
ValidationResult +
.+ ,
Success, 3
;3 4
} 
} 
return 
new 
ValidationResult '
(' (
$str( C
)C D
;D E
} 	
} 
} ˙ë
nC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Services\VoterService.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
Services( 0
{ 
public 

class 
VoterService 
: 
IVoterService  -
{ 
private 
readonly 
IGenericRepository +
<+ ,
Voter, 1
>1 2
_voterRepository3 C
;C D
private 
readonly 
IGenericRepository +
<+ ,
	Candidate, 5
>5 6 
_candidateRepository7 K
;K L
private 
readonly 
IMapper  
_mapper! (
;( )
private 
readonly 
ApplicationContext +
_applicationContext, ?
;? @
public 
VoterService 
( 
IGenericRepository .
<. /
Voter/ 4
>4 5

repository6 @
,@ A
IMapperB I
mapperJ P
,P Q
IGenericRepositoryR d
<d e
	Candidatee n
>n o 
candidateRepository	p É
,
É Ñ 
ApplicationContext
Ö ó 
applicationContext
ò ™
)
™ ´
{ 	
_mapper 
= 
mapper 
; 
_voterRepository 
= 

repository )
;) * 
_candidateRepository  
=! "
candidateRepository# 6
;6 7
_applicationContext 
=  !
applicationContext" 4
;4 5
} 	
public 
async 
Task 
< 
VoterResponseDto *
>* +
AddVoter, 4
(4 5
CreateVoterDto5 C
createVoterDtoD R
)R S
{   	
var"" 
	voterList"" 
="" 
await"" !
_voterRepository""" 2
.""2 3
GetAllAsync""3 >
(""> ?
$num""? @
,""@ A
$num""B C
,""C D
true""E I
)""I J
;""J K
for## 
(## 
int## 
i## 
=## 
$num## 
;## 
i## 
<## 
	voterList##  )
.##) *
Count##* /
(##/ 0
)##0 1
;##1 2
i##3 4
++##4 6
)##6 7
{$$ 
if%% 
(%% 
	voterList%% 
.%% 
	ElementAt%% '
(%%' (
i%%( )
)%%) *
.%%* +
Email%%+ 0
==%%1 3
createVoterDto%%4 B
.%%B C
Email%%C H
&&%%I K
!%%L M
	voterList%%M V
.%%V W
	ElementAt%%W `
(%%` a
i%%a b
)%%b c
.%%c d
	IsDeleted%%d m
)%%m n
{&& 
throw'' 
new'' "
DuplicateNameException'' 4
(''4 5
$str''5 Z
)''Z [
;''[ \
}(( 
})) 
SHA25655 
sha25655 
=55 
SHA25655 "
.55" #
Create55# )
(55) *
)55* +
;55+ ,
byte66 
[66 
]66 
	hashBytes66 
=66 
sha25666 %
.66% &
ComputeHash66& 1
(661 2
Encoding662 :
.66: ;
UTF866; ?
.66? @
GetBytes66@ H
(66H I
createVoterDto66I W
.66W X
Password66X `
)66` a
)66a b
;66b c
createVoterDto77 
.77 
Password77 #
=77$ %
Convert77& -
.77- .
ToBase64String77. <
(77< =
	hashBytes77= F
)77F G
;77G H
var99 
mappedVoter99 
=99 
_mapper99 %
.99% &
Map99& )
<99) *
Voter99* /
>99/ 0
(990 1
createVoterDto991 ?
)99? @
;99@ A
await:: 
_voterRepository:: "
.::" #
CreateAsync::# .
(::. /
mappedVoter::/ :
)::: ;
;::; <
await;; 
_voterRepository;; "
.;;" #
	SaveAsync;;# ,
(;;, -
);;- .
;;;. /
return<< 
_mapper<< 
.<< 
Map<< 
<<< 
VoterResponseDto<< /
><</ 0
(<<0 1
mappedVoter<<1 <
)<<< =
;<<= >
}== 	
public@@ 
async@@ 
Task@@ 
<@@ 
VoterResponseDto@@ *
>@@* +
DeleteVoter@@, 7
(@@7 8
long@@8 <
voterId@@= D
)@@D E
{AA 	
varBB 
voterBB 
=BB 
awaitBB 
_voterRepositoryBB .
.BB. /
GetByIdAsyncBB/ ;
(BB; <
voterIdBB< C
)BBC D
;BBD E
ifEE 
(EE 
voterEE 
==EE 
nullEE 
)EE 
{FF 
throwGG 
newGG  
KeyNotFoundExceptionGG .
(GG. /
$strGG/ M
)GGM N
;GGN O
}HH 
ifJJ 
(JJ 
voterJJ 
.JJ 
	IsDeletedJJ 
)JJ  
{KK 
throwLL 
newLL  
KeyNotFoundExceptionLL .
(LL. /
$strLL/ O
)LLO P
;LLP Q
}MM 
ifOO 
(OO 
!OO 
voterOO 
.OO 
HasVotedOO 
)OO  
{PP 
voterQQ 
.QQ 
	IsDeletedQQ 
=QQ  !
trueQQ" &
;QQ& '
}RR 
elseSS 
{TT 
throwUU 
newUU %
InvalidOperationExceptionUU 3
(UU3 4
$strUU4 W
)UUW X
;UUX Y
}VV 
awaitXX 
_voterRepositoryXX "
.XX" #
	SaveAsyncXX# ,
(XX, -
)XX- .
;XX. /
returnYY 
_mapperYY 
.YY 
MapYY 
<YY 
VoterResponseDtoYY /
>YY/ 0
(YY0 1
voterYY1 6
)YY6 7
;YY7 8
}ZZ 	
public]] 
async]] 
Task]] 
<]] 
VoterResponseDto]] *
>]]* +
GetVoter]], 4
(]]4 5
long]]5 9
voterId]]: A
)]]A B
{^^ 	
var__ 
voter__ 
=__ 
await__ 
_voterRepository__ .
.__. /
GetByIdAsync__/ ;
(__; <
voterId__< C
)__C D
;__D E
ifbb 
(bb 
voterbb 
==bb 
nullbb 
)bb 
{cc 
throwdd 
newdd  
KeyNotFoundExceptiondd .
(dd. /
$strdd/ M
)ddM N
;ddN O
}ee 
ifhh 
(hh 
voterhh 
.hh 
	IsDeletedhh 
)hh  
{ii 
throwjj 
newjj  
KeyNotFoundExceptionjj .
(jj. /
$strjj/ O
)jjO P
;jjP Q
}kk 
varmm 
resmm 
=mm 
_mappermm 
.mm 
Mapmm !
<mm! "
VoterResponseDtomm" 2
>mm2 3
(mm3 4
votermm4 9
)mm9 :
;mm: ;
returnnn 
resnn 
;nn 
}oo 	
publicrr 
asyncrr 
Taskrr 
<rr 
VoterResponseDtorr *
>rr* +
UpdateVoterrr, 7
(rr7 8
VoterUpdateDtorr8 F
voterUpdateDtorrG U
,rrU V
longrrW [
voterIdrr\ c
)rrc d
{ss 	
vartt 
votertt 
=tt 
awaittt 
_voterRepositorytt .
.tt. /
GetByIdAsynctt/ ;
(tt; <
voterIdtt< C
)ttC D
;ttD E
ifww 
(ww 
voterww 
==ww 
nullww 
)ww 
{xx 
throwyy 
newyy  
KeyNotFoundExceptionyy .
(yy. /
$stryy/ M
)yyM N
;yyN O
}zz 
if}} 
(}} 
voter}} 
.}} 
	IsDeleted}} 
)}}  
{~~ 
throw 
new  
KeyNotFoundException .
(. /
$str/ O
)O P
;P Q
}
ÄÄ 
bool
ÉÉ 

hasChanges
ÉÉ 
=
ÉÉ 
false
ÉÉ #
;
ÉÉ# $
if
ÖÖ 
(
ÖÖ 
voter
ÖÖ 
.
ÖÖ 
Name
ÖÖ 
!=
ÖÖ 
voterUpdateDto
ÖÖ ,
.
ÖÖ, -
Name
ÖÖ- 1
)
ÖÖ1 2
{
ÜÜ 
voter
áá 
.
áá 
Name
áá 
=
áá 
voterUpdateDto
áá +
.
áá+ ,
Name
áá, 0
;
áá0 1

hasChanges
àà 
=
àà 
true
àà !
;
àà! "
}
ââ 
if
ää 
(
ää 
voter
ää 
.
ää 
Email
ää 
!=
ää 
voterUpdateDto
ää -
.
ää- .
Email
ää. 3
)
ää3 4
{
ãã 
voter
åå 
.
åå 
Email
åå 
=
åå 
voterUpdateDto
åå ,
.
åå, -
Email
åå- 2
;
åå2 3

hasChanges
çç 
=
çç 
true
çç !
;
çç! "
}
éé 
if
êê 
(
êê 
voter
êê 
.
êê 
DOB
êê 
!=
êê 
voterUpdateDto
êê +
.
êê+ ,
DOB
êê, /
)
êê/ 0
{
ëë 
voter
íí 
.
íí 
DOB
íí 
=
íí 
voterUpdateDto
íí *
.
íí* +
DOB
íí+ .
;
íí. /

hasChanges
ìì 
=
ìì 
true
ìì !
;
ìì! "
}
îî 
if
ññ 
(
ññ 
voter
ññ 
.
ññ 
Gender
ññ 
!=
ññ 
voterUpdateDto
ññ  .
.
ññ. /
Gender
ññ/ 5
)
ññ5 6
{
óó 
voter
òò 
.
òò 
Gender
òò 
=
òò 
voterUpdateDto
òò -
.
òò- .
Gender
òò. 4
;
òò4 5

hasChanges
ôô 
=
ôô 
true
ôô !
;
ôô! "
}
öö 
if
ùù 
(
ùù 

hasChanges
ùù 
)
ùù 
{
ûû 
var
°° 
	voterList
°° 
=
°° 
await
°°  %
_voterRepository
°°& 6
.
°°6 7
GetAllAsync
°°7 B
(
°°B C
$num
°°C D
,
°°D E
$num
°°F G
,
°°G H
true
°°I M
)
°°M N
;
°°N O
for
¢¢ 
(
¢¢ 
int
¢¢ 
i
¢¢ 
=
¢¢ 
$num
¢¢ 
;
¢¢ 
i
¢¢  !
<
¢¢" #
	voterList
¢¢$ -
.
¢¢- .
Count
¢¢. 3
(
¢¢3 4
)
¢¢4 5
;
¢¢5 6
i
¢¢7 8
++
¢¢8 :
)
¢¢: ;
{
££ 
if
§§ 
(
§§ 
	voterList
§§ !
.
§§! "
	ElementAt
§§" +
(
§§+ ,
i
§§, -
)
§§- .
.
§§. /
Email
§§/ 4
==
§§5 7
voterUpdateDto
§§8 F
.
§§F G
Email
§§G L
&&
§§M O
!
§§P Q
	voterList
§§Q Z
.
§§Z [
	ElementAt
§§[ d
(
§§d e
i
§§e f
)
§§f g
.
§§g h
	IsDeleted
§§h q
)
§§q r
{
•• 
throw
¶¶ 
new
¶¶ !$
DuplicateNameException
¶¶" 8
(
¶¶8 9
$str
¶¶9 f
)
¶¶f g
;
¶¶g h
}
ßß 
}
®® 
voter
™™ 
.
™™ 
DateUpdated
™™ !
=
™™" #
DateTimeOffset
™™$ 2
.
™™2 3
Now
™™3 6
;
™™6 7
_voterRepository
´´  
.
´´  !
Update
´´! '
(
´´' (
voter
´´( -
)
´´- .
;
´´. /
await
¨¨ 
_voterRepository
¨¨ &
.
¨¨& '
	SaveAsync
¨¨' 0
(
¨¨0 1
)
¨¨1 2
;
¨¨2 3
return
≠≠ 
_mapper
≠≠ 
.
≠≠ 
Map
≠≠ "
<
≠≠" #
VoterResponseDto
≠≠# 3
>
≠≠3 4
(
≠≠4 5
voterUpdateDto
≠≠5 C
)
≠≠C D
;
≠≠D E
}
ÆÆ 
throw
∞∞ 
new
∞∞ '
InvalidOperationException
∞∞ /
(
∞∞/ 0
$str
∞∞0 Z
)
∞∞Z [
;
∞∞[ \
}
±± 	
public
≥≥ 
async
≥≥ 
Task
≥≥ 
<
≥≥ 
VoterResponseDto
≥≥ *
>
≥≥* +
VoteToCandidate
≥≥, ;
(
≥≥; <
long
≥≥< @
candidateId
≥≥A L
,
≥≥L M
long
≥≥N R
voterId
≥≥S Z
)
≥≥Z [
{
¥¥ 	
var
µµ 
voter
µµ 
=
µµ 
await
µµ 
_voterRepository
µµ .
.
µµ. /
GetByIdAsync
µµ/ ;
(
µµ; <
voterId
µµ< C
)
µµC D
;
µµD E
if
∏∏ 
(
∏∏ 
voter
∏∏ 
==
∏∏ 
null
∏∏ 
)
∏∏ 
{
ππ 
throw
∫∫ 
new
∫∫ "
KeyNotFoundException
∫∫ .
(
∫∫. /
$str
∫∫/ M
)
∫∫M N
;
∫∫N O
}
ªª 
if
ææ 
(
ææ 
voter
ææ 
.
ææ 
	IsDeleted
ææ 
)
ææ  
{
øø 
throw
¿¿ 
new
¿¿ "
KeyNotFoundException
¿¿ .
(
¿¿. /
$str
¿¿/ O
)
¿¿O P
;
¿¿P Q
}
¡¡ 
if
ƒƒ 
(
ƒƒ 
!
ƒƒ 
voter
ƒƒ 
.
ƒƒ 
HasVoted
ƒƒ 
)
ƒƒ  
{
≈≈ 
voter
∆∆ 
.
∆∆ 
HasVoted
∆∆ 
=
∆∆  
true
∆∆! %
;
∆∆% &
}
«« 
else
»» 
{
…… 
throw
   
new
   '
InvalidOperationException
   3
(
  3 4
$str
  4 W
)
  W X
;
  X Y
}
ÀÀ 
var
ŒŒ 
	candidate
ŒŒ 
=
ŒŒ 
await
ŒŒ !"
_candidateRepository
ŒŒ" 6
.
ŒŒ6 7
GetByIdAsync
ŒŒ7 C
(
ŒŒC D
candidateId
ŒŒD O
)
ŒŒO P
;
ŒŒP Q
if
—— 
(
—— 
	candidate
—— 
==
—— 
null
—— !
)
——! "
{
““ 
throw
”” 
new
”” "
KeyNotFoundException
”” .
(
””. /
$str
””/ Q
)
””Q R
;
””R S
}
‘‘ 
if
÷÷ 
(
÷÷ 
	candidate
÷÷ 
.
÷÷ 
	IsDeleted
÷÷ #
)
÷÷# $
{
◊◊ 
throw
ÿÿ 
new
ÿÿ "
KeyNotFoundException
ÿÿ .
(
ÿÿ. /
$str
ÿÿ/ Q
)
ÿÿQ R
;
ÿÿR S
}
ŸŸ 
	candidate
⁄⁄ 
.
⁄⁄ 

TotalVotes
⁄⁄  
+=
⁄⁄! #
$num
⁄⁄$ %
;
⁄⁄% &
await
€€ 
_voterRepository
€€ "
.
€€" #
	SaveAsync
€€# ,
(
€€, -
)
€€- .
;
€€. /
await
‹‹ "
_candidateRepository
‹‹ &
.
‹‹& '
	SaveAsync
‹‹' 0
(
‹‹0 1
)
‹‹1 2
;
‹‹2 3
return
ﬁﬁ 
_mapper
ﬁﬁ 
.
ﬁﬁ 
Map
ﬁﬁ 
<
ﬁﬁ 
VoterResponseDto
ﬁﬁ /
>
ﬁﬁ/ 0
(
ﬁﬁ0 1
voter
ﬁﬁ1 6
)
ﬁﬁ6 7
;
ﬁﬁ7 8
}
ﬂﬂ 	
public
‚‚ 
async
‚‚ 
Task
‚‚ 
<
‚‚ 
IEnumerable
‚‚ %
<
‚‚% &
Voter
‚‚& +
>
‚‚+ ,
>
‚‚, -
GetAllVoters
‚‚. :
(
‚‚: ;
int
‚‚; >

pageNumber
‚‚? I
,
‚‚I J
int
‚‚K N
pageSize
‚‚O W
,
‚‚W X
bool
‚‚Y ]
fetchAll
‚‚^ f
)
‚‚f g
{
„„ 	
return
‰‰ 
await
‰‰ 
_voterRepository
‰‰ )
.
‰‰) *
GetAllAsync
‰‰* 5
(
‰‰5 6

pageNumber
‰‰6 @
,
‰‰@ A
pageSize
‰‰B J
,
‰‰J K
fetchAll
‰‰L T
)
‰‰T U
;
‰‰U V
}
ÂÂ 	
public
ÁÁ 
Task
ÁÁ 
<
ÁÁ 
VoterResponseDto
ÁÁ $
>
ÁÁ$ %
SearchVoter
ÁÁ& 1
(
ÁÁ1 2
string
ÁÁ2 8
	voterName
ÁÁ9 B
)
ÁÁB C
{
ËË 	
if
ÈÈ 
(
ÈÈ 
	voterName
ÈÈ 
==
ÈÈ 
null
ÈÈ !
)
ÈÈ! "
{
ÍÍ 
throw
ÎÎ 
new
ÎÎ '
InvalidOperationException
ÎÎ 3
(
ÎÎ3 4
$str
ÎÎ4 T
)
ÎÎT U
;
ÎÎU V
}
ÏÏ 
throw
ÓÓ 
new
ÓÓ %
NotImplementedException
ÓÓ -
(
ÓÓ- .
)
ÓÓ. /
;
ÓÓ/ 0
}
ÔÔ 	
public
ÒÒ 
async
ÒÒ 
Task
ÒÒ 
<
ÒÒ 
IEnumerable
ÒÒ %
<
ÒÒ% &
Voter
ÒÒ& +
>
ÒÒ+ ,
>
ÒÒ, -
SearchVoterByName
ÒÒ. ?
(
ÒÒ? @
string
ÒÒ@ F
	voterName
ÒÒG P
)
ÒÒP Q
{
ÚÚ 	
if
ÛÛ 
(
ÛÛ 
	voterName
ÛÛ 
==
ÛÛ 
null
ÛÛ !
)
ÛÛ! "
{
ÙÙ 
throw
ıı 
new
ıı '
InvalidOperationException
ıı 3
(
ıı3 4
$str
ıı4 K
)
ııK L
;
ııL M
}
ˆˆ 
var
˜˜ 
query
˜˜ 
=
˜˜ 
$"
˜˜ 
$str
˜˜ 1
{
˜˜1 2
	voterName
˜˜2 ;
}
˜˜; <
"
˜˜< =
;
˜˜= >
return
¯¯ 
await
¯¯ !
_applicationContext
¯¯ ,
.
¯¯, -
Voters
¯¯- 3
.
¯¯3 4

FromSqlRaw
¯¯4 >
(
¯¯> ?
query
¯¯? D
)
¯¯D E
.
¯¯E F
ToListAsync
¯¯F Q
(
¯¯Q R
)
¯¯R S
;
¯¯S T
}
˘˘ 	
}
˙˙ 
}˚˚ ¥c
nC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Services\PartyService.cs
	namespace

 	
VotingApplication


 
.

 
Application

 '
.

' (
Services

( 0
{ 
public 

class 
PartyService 
: 
IPartyService  -
{ 
private 
readonly 
IGenericRepository +
<+ ,
Party, 1
>1 2
_partyRepository3 C
;C D
private 
readonly 
IGenericRepository +
<+ ,
	Candidate, 5
>5 6 
_candidateRepository7 K
;K L
private 
readonly 
ApplicationContext +
_context, 4
;4 5
private 
readonly 
IMapper  
_mapper! (
;( )
public 
PartyService 
( 
IGenericRepository .
<. /
Party/ 4
>4 5
partyRepository6 E
,E F
IMapperG N
mapperO U
,U V
IGenericRepositoryW i
<i j
	Candidatej s
>s t 
candidateRepository	u à
,
à â 
ApplicationContext
ä ú
context
ù §
)
§ •
{ 	
_partyRepository 
= 
partyRepository .
;. /
_mapper 
= 
mapper 
;  
_candidateRepository  
=! "
candidateRepository# 6
;6 7
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
PartyResponseDto *
>* +
AddParty, 4
(4 5
CreatePartyDto5 C
createPartyDtoD R
)R S
{ 	
var 
	partyList 
= 
await !
_partyRepository" 2
.2 3
GetAllAsync3 >
(> ?
$num? @
,@ A
$numB C
,C D
trueE I
)I J
;J K
for 
( 
int 
i 
= 
$num 
; 
i 
< 
	partyList  )
.) *
Count* /
(/ 0
)0 1
;1 2
i3 4
++4 6
)6 7
{   
if!! 
(!! 
	partyList!! 
.!! 
	ElementAt!! '
(!!' (
i!!( )
)!!) *
.!!* +
	PartyName!!+ 4
==!!5 7
createPartyDto!!8 F
.!!F G
	PartyName!!G P
&&!!Q S
!!!T U
	partyList!!U ^
.!!^ _
	ElementAt!!_ h
(!!h i
i!!i j
)!!j k
.!!k l
	IsDeleted!!l u
)!!u v
{"" 
throw## 
new## "
DuplicateNameException## 4
(##4 5
$str##5 O
)##O P
;##P Q
}$$ 
}%% 
var'' 
_mappedParty'' 
='' 
_mapper'' &
.''& '
Map''' *
<''* +
Party''+ 0
>''0 1
(''1 2
createPartyDto''2 @
)''@ A
;''A B
_mappedParty(( 
.(( 
	PartyName(( "
=((# $
_mappedParty((% 1
.((1 2
	PartyName((2 ;
.((; <
ToUpper((< C
(((C D
)((D E
;((E F
await)) 
_partyRepository)) "
.))" #
CreateAsync))# .
()). /
_mappedParty))/ ;
))); <
;))< =
await** 
_partyRepository** "
.**" #
	SaveAsync**# ,
(**, -
)**- .
;**. /
return++ 
_mapper++ 
.++ 
Map++ 
<++ 
PartyResponseDto++ /
>++/ 0
(++0 1
_mappedParty++1 =
)++= >
;++> ?
},, 	
public.. 
async.. 
Task.. 
<.. 
PartyResponseDto.. *
>..* +
DeleteParty.., 7
(..7 8
long..8 <
PartyId..= D
)..D E
{// 	
var00 
candidateList00 
=00 
await00  % 
_candidateRepository00& :
.00: ;
GetAllAsync00; F
(00F G
$num00G H
,00H I
$num00J K
,00K L
true00M Q
)00Q R
;00R S
var11 
party11 
=11 
await11 
_partyRepository11 .
.11. /
GetByIdAsync11/ ;
(11; <
PartyId11< C
)11C D
;11D E
if33 
(33 
party33 
==33 
null33 
)33 
{44 
throw55 
new55  
KeyNotFoundException55 .
(55. /
$str55/ M
)55M N
;55N O
}66 
if88 
(88 
party88 
.88 
	IsDeleted88 
)88  
{99 
throw:: 
new::  
KeyNotFoundException:: .
(::. /
$str::/ O
)::O P
;::P Q
};; 
foreach== 
(== 
var== 
	candidate== "
in==# %
candidateList==& 3
)==3 4
{>> 
if?? 
(?? 
	candidate?? 
.?? 
	PartyName?? '
==??( *
party??+ 0
.??0 1
	PartyName??1 :
)??: ;
{@@ 
throwAA 
newAA %
InvalidOperationExceptionAA 7
(AA7 8
$strAA8 p
)AAp q
;AAq r
}BB 
}CC 
partyEE 
.EE 
	IsDeletedEE 
=EE 
trueEE "
;EE" #
awaitFF 
_partyRepositoryFF "
.FF" #
	SaveAsyncFF# ,
(FF, -
)FF- .
;FF. /
returnGG 
_mapperGG 
.GG 
MapGG 
<GG 
PartyResponseDtoGG /
>GG/ 0
(GG0 1
partyGG1 6
)GG6 7
;GG7 8
}HH 	
publicJJ 
TaskJJ 
<JJ 
IEnumerableJJ 
<JJ  
PartyJJ  %
>JJ% &
>JJ& '
GetAllPartiesJJ( 5
(JJ5 6
intJJ6 9

pageNumberJJ: D
,JJD E
intJJF I
pageSizeJJJ R
,JJR S
boolJJT X
fetchAllJJY a
)JJa b
{KK 	
returnLL 
_partyRepositoryLL #
.LL# $
GetAllAsyncLL$ /
(LL/ 0

pageNumberLL0 :
,LL: ;
pageSizeLL< D
,LLD E
fetchAllLLF N
)LLN O
;LLO P
}MM 	
publicOO 
asyncOO 
TaskOO 
<OO 
PartyResponseDtoOO *
>OO* +
GetPartyByIdOO, 8
(OO8 9
longOO9 =
PartyIdOO> E
)OOE F
{PP 	
varQQ 
partyQQ 
=QQ 
awaitQQ 
_partyRepositoryQQ .
.QQ. /
GetByIdAsyncQQ/ ;
(QQ; <
PartyIdQQ< C
)QQC D
;QQD E
ifSS 
(SS 
partySS 
==SS 
nullSS 
)SS 
{TT 
throwUU 
newUU  
KeyNotFoundExceptionUU .
(UU. /
$strUU/ M
)UUM N
;UUN O
}VV 
ifXX 
(XX 
partyXX 
.XX 
	IsDeletedXX 
)XX  
{YY 
throwZZ 
newZZ  
KeyNotFoundExceptionZZ .
(ZZ. /
$strZZ/ O
)ZZO P
;ZZP Q
}[[ 
return\\ 
_mapper\\ 
.\\ 
Map\\ 
<\\ 
PartyResponseDto\\ /
>\\/ 0
(\\0 1
party\\1 6
)\\6 7
;\\7 8
}]] 	
public__ 
async__ 
Task__ 
<__ 
IEnumerable__ %
<__% &
Party__& +
>__+ ,
>__, -
SearchByPartyName__. ?
(__? @
string__@ F
	partyName__G P
)__P Q
{`` 	
ifaa 
(aa 
	partyNameaa 
==aa 
nullaa !
)aa! "
{bb 
throwcc 
newcc %
InvalidOperationExceptioncc 3
(cc3 4
$strcc4 K
)ccK L
;ccL M
}dd 
varee 
queryee 
=ee 
$"ee 
$stree 1
{ee1 2
	partyNameee2 ;
}ee; <
$stree< =
"ee= >
;ee> ?
returnff 
awaitff 
_contextff !
.ff! "
Partiesff" )
.ff) *

FromSqlRawff* 4
(ff4 5
queryff5 :
)ff: ;
.ff; <
ToListAsyncff< G
(ffG H
)ffH I
;ffI J
}gg 	
publicii 
asyncii 
Taskii 
<ii 
PartyResponseDtoii *
>ii* +
UpdatePartyii, 7
(ii7 8
UpdatePartyDtoii8 F
updatePartyDtoiiG U
,iiU V
longiiW [
PartyIdii\ c
)iic d
{jj 	
varkk 
candidateListkk 
=kk 
awaitkk  % 
_candidateRepositorykk& :
.kk: ;
GetAllAsynckk; F
(kkF G
$numkkG H
,kkH I
$numkkJ K
,kkK L
truekkM Q
)kkQ R
;kkR S
varll 
partyll 
=ll 
awaitll 
_partyRepositoryll .
.ll. /
GetByIdAsyncll/ ;
(ll; <
PartyIdll< C
)llC D
;llD E
ifoo 
(oo 
partyoo 
==oo 
nulloo 
)oo 
{pp 
throwqq 
newqq  
KeyNotFoundExceptionqq .
(qq. /
$strqq/ M
)qqM N
;qqN O
}rr 
iftt 
(tt 
partytt 
.tt 
	IsDeletedtt 
)tt  
{uu 
throwvv 
newvv  
KeyNotFoundExceptionvv .
(vv. /
$strvv/ O
)vvO P
;vvP Q
}ww 
foreachxx 
(xx 
varxx 
	candidatexx "
inxx# %
candidateListxx& 3
)xx3 4
{yy 
ifzz 
(zz 
	candidatezz 
.zz 
	PartyNamezz '
==zz( *
partyzz+ 0
.zz0 1
	PartyNamezz1 :
)zz: ;
{{{ 
throw|| 
new|| %
InvalidOperationException|| 7
(||7 8
$str||8 p
)||p q
;||q r
}}} 
}~~ 
bool
ÅÅ 

hasChanges
ÅÅ 
=
ÅÅ 
false
ÅÅ #
;
ÅÅ# $
if
ÑÑ 
(
ÑÑ 
party
ÑÑ 
.
ÑÑ 
	PartyName
ÑÑ 
!=
ÑÑ  "
updatePartyDto
ÑÑ# 1
.
ÑÑ1 2
	PartyName
ÑÑ2 ;
)
ÑÑ; <
{
ÖÖ 
party
ÜÜ 
.
ÜÜ 
	PartyName
ÜÜ 
=
ÜÜ  !
updatePartyDto
ÜÜ" 0
.
ÜÜ0 1
	PartyName
ÜÜ1 :
;
ÜÜ: ;
party
áá 
.
áá 
	PartyName
áá 
.
áá  
ToUpper
áá  '
(
áá' (
)
áá( )
;
áá) *

hasChanges
àà 
=
àà 
true
àà !
;
àà! "
}
ââ 
if
åå 
(
åå 

hasChanges
åå 
)
åå 
{
çç 
party
éé 
.
éé 
DateUpdated
éé !
=
éé" #
DateTimeOffset
éé$ 2
.
éé2 3
Now
éé3 6
;
éé6 7
_partyRepository
èè  
.
èè  !
Update
èè! '
(
èè' (
party
èè( -
)
èè- .
;
èè. /
await
êê 
_partyRepository
êê &
.
êê& '
	SaveAsync
êê' 0
(
êê0 1
)
êê1 2
;
êê2 3
return
ëë 
_mapper
ëë 
.
ëë 
Map
ëë "
<
ëë" #
PartyResponseDto
ëë# 3
>
ëë3 4
(
ëë4 5
party
ëë5 :
)
ëë: ;
;
ëë; <
}
íí 
throw
îî 
new
îî '
InvalidOperationException
îî /
(
îî/ 0
$str
îî0 Z
)
îîZ [
;
îî[ \
}
ïï 	
}
ññ 
}óó º™
nC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Services\LoginService.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
Services( 0
{ 
public 

class 
LoginService 
: 
ILoginService  -
{ 
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
private 
readonly 
IVoterService &
_voterService' 4
;4 5
private 
readonly 
IAdminService &
_adminService' 4
;4 5
private 
readonly 
IGenericRepository +
<+ ,
RefreshToken, 8
>8 9#
_refreshTokenRepository: Q
;Q R
private 
readonly 
ApplicationContext +
_context, 4
;4 5
private 
long 
Id 
; 
public 
LoginService 
( 
IConfiguration *
configuration+ 8
,8 9
IVoterService: G
voterServiceH T
,T U
IAdminServiceV c
adminServiced p
,p q
IGenericRepository	r Ñ
<
Ñ Ö
RefreshToken
Ö ë
>
ë í$
refreshTokenRepository
ì ©
,
© ™ 
ApplicationContext
´ Ω
context
æ ≈
)
≈ ∆
{ 	
_configuration   
=   
configuration   *
;  * +
_adminService!! 
=!! 
adminService!! (
;!!( )
_voterService"" 
="" 
voterService"" (
;""( )
_context## 
=## 
context## 
;## #
_refreshTokenRepository$$ #
=$$$ %"
refreshTokenRepository$$& <
;$$< =
}%% 	
public'' 
async'' 
Task'' 
<'' 
LoginResponseDto'' *
>''* +
Login'', 1
(''1 2
LoginDto''2 :
loginDto''; C
)''C D
{(( 	
if)) 
()) 
loginDto)) 
.)) 
Role)) 
==))  
$str))! (
)))( )
{** 
var++ 
	voterList++ 
=++ 
await++  %
_voterService++& 3
.++3 4
GetAllVoters++4 @
(++@ A
$num++A B
,++B C
$num++D E
,++E F
true++G K
)++K L
;++L M
var,, 
voter,, 
=,, 
new,, 
Voter,,  %
(,,% &
),,& '
;,,' (
for-- 
(-- 
int-- 
i-- 
=-- 
$num-- 
;-- 
i--  !
<--" #
	voterList--$ -
.--- .
Count--. 3
(--3 4
)--4 5
;--5 6
i--7 8
++--8 :
)--: ;
{.. 
if// 
(// 
	voterList// !
.//! "
	ElementAt//" +
(//+ ,
i//, -
)//- .
.//. /
Email/// 4
==//5 7
loginDto//8 @
.//@ A
Email//A F
&&//G I
!//J K
	voterList//K T
.//T U
	ElementAt//U ^
(//^ _
i//_ `
)//` a
.//a b
	IsDeleted//b k
)//k l
{00 
voter11 
=11 
	voterList11  )
.11) *
	ElementAt11* 3
(113 4
i114 5
)115 6
;116 7
}22 
}33 
if55 
(55 
voter55 
.55 
Email55 
==55  "
$str55# %
)55% &
{66 
throw77 
new77  
KeyNotFoundException77 2
(772 3
$str773 ^
)77^ _
;77_ `
}88 
else99 
{:: 
Id<< 
=<< 
voter<< 
.<< 
VoterId<< &
;<<& '
if== 
(== 
_verifyPassword== '
(==' (
loginDto==( 0
.==0 1
Password==1 9
,==9 :
voter==; @
.==@ A
Password==A I
)==I J
)==J K
{>> 
var?? 
refreshToken?? (
=??) *
await??+ 0!
_generateRefreshToken??1 F
(??F G
$str??G N
,??N O
voter??P U
,??U V
null??W [
)??[ \
;??\ ]
var@@ 
jwtToken@@ $
=@@% &
_generateJwtToken@@' 8
(@@8 9
loginDto@@9 A
)@@A B
;@@B C
returnAA 
newAA "
LoginResponseDtoAA# 3
(AA3 4
)AA4 5
{BB 
RefreshTokenCC (
=CC) *
refreshTokenCC+ 7
,CC7 8
JwtTokenDD $
=DD% &
jwtTokenDD' /
,DD/ 0
}EE 
;EE 
}FF 
elseGG 
{HH 
throwII 
newII !&
InvalidCredentialExceptionII" <
(II< =
$strII= T
)IIT U
;IIU V
}JJ 
}KK 
}LL 
ifMM 
(MM 
loginDtoMM 
.MM 
RoleMM 
==MM  
$strMM! (
)MM( )
{NN 
varPP 
adminsPP 
=PP 
awaitPP "
_adminServicePP# 0
.PP0 1
GetAllAdminPP1 <
(PP< =
$numPP= >
,PP> ?
$numPP@ A
,PPA B
truePPC G
)PPG H
;PPH I
varQQ 
adminQQ 
=QQ 
adminsQQ "
.QQ" #
FirstOrDefaultQQ# 1
(QQ1 2
(QQ2 3
adminQQ3 8
)QQ8 9
=>QQ: <
adminQQ= B
.QQB C
EmailQQC H
==QQI K
loginDtoQQL T
.QQT U
EmailQQU Z
)QQZ [
;QQ[ \
ifRR 
(RR 
adminRR 
==RR 
nullRR !
)RR! "
{SS 
throwTT 
newTT  
KeyNotFoundExceptionTT 2
(TT2 3
$strTT3 Q
)TTQ R
;TTR S
}UU 
elseVV 
{WW 
IdYY 
=YY 
adminYY 
.YY 
AdminIdYY &
;YY& '
ifZZ 
(ZZ 
_verifyPasswordZZ '
(ZZ' (
loginDtoZZ( 0
.ZZ0 1
PasswordZZ1 9
,ZZ9 :
adminZZ; @
.ZZ@ A
PasswordZZA I
)ZZI J
)ZZJ K
{[[ 
var\\ 
refreshToken\\ (
=\\) *
await\\+ 0!
_generateRefreshToken\\1 F
(\\F G
$str\\G N
,\\N O
null\\P T
,\\T U
admin\\V [
)\\[ \
;\\\ ]
var]] 
jwtToken]] $
=]]% &
_generateJwtToken]]' 8
(]]8 9
loginDto]]9 A
)]]A B
;]]B C
return^^ 
new^^ "
LoginResponseDto^^# 3
(^^3 4
)^^4 5
{__ 
RefreshToken`` (
=``) *
refreshToken``+ 7
,``7 8
JwtTokenaa $
=aa% &
jwtTokenaa' /
,aa/ 0
}bb 
;bb 
}cc 
elsedd 
{ee 
throwff 
newff !&
InvalidCredentialExceptionff" <
(ff< =
$strff= P
)ffP Q
;ffQ R
}gg 
}hh 
}ii 
returnjj 
newjj 
LoginResponseDtojj '
(jj' (
)jj( )
;jj) *
}kk 	
privatemm 
stringmm 
_generateJwtTokenmm (
(mm( )
LoginDtomm) 1
loginDtomm2 :
)mm: ;
{nn 	
varoo 
securityKeyoo 
=oo 
newoo ! 
SymmetricSecurityKeyoo" 6
(oo6 7
Encodingoo7 ?
.oo? @
UTF8oo@ D
.ooD E
GetBytesooE M
(ooM N
_configurationooN \
[oo\ ]
$stroo] f
]oof g
!oog h
)ooh i
)ooi j
;ooj k
varpp 
credentialspp 
=pp 
newpp !
SigningCredentialspp" 4
(pp4 5
securityKeypp5 @
,pp@ A
SecurityAlgorithmsppB T
.ppT U

HmacSha256ppU _
)pp_ `
;pp` a
varrr 
claimsrr 
=rr 
newrr 
[rr 
]rr 
{rr  
newss 
Claimss 
(ss 

ClaimTypesss $
.ss$ %
Roless% )
,ss) *
loginDtoss+ 3
.ss3 4
Roless4 8
)ss8 9
,ss9 :
newtt 
Claimtt 
(tt 

ClaimTypestt $
.tt$ %
Emailtt% *
,tt* +
loginDtott, 4
.tt4 5
Emailtt5 :
)tt: ;
,tt; <
newuu 
Claimuu 
(uu 

ClaimTypesuu $
.uu$ %
NameIdentifieruu% 3
,uu3 4
Iduu5 7
.uu7 8
ToStringuu8 @
(uu@ A
)uuA B
)uuB C
}uuD E
;uuE F
varww 
tokenww 
=ww 
newww 
JwtSecurityTokenww ,
(ww, -
claimsxx 
:xx 
claimsxx 
,xx 
expiresyy 
:yy 
DateTimeyy 
.yy  
Nowyy  #
.yy# $

AddMinutesyy$ .
(yy. /
$numyy/ 1
)yy1 2
,yy2 3
signingCredentialszz  
:zz  !
credentialszz" -
)zz- .
;zz. /
return|| 
new|| #
JwtSecurityTokenHandler|| .
(||. /
)||/ 0
.||0 1

WriteToken||1 ;
(||; <
token||< A
)||A B
;||B C
}}} 	
private 
bool 
_verifyPassword $
($ %
string% +
password, 4
,4 5
string6 <

dbPassword= G
)G H
{
ÄÄ 	
SHA256
ÅÅ 
sha256
ÅÅ 
=
ÅÅ 
SHA256
ÅÅ "
.
ÅÅ" #
Create
ÅÅ# )
(
ÅÅ) *
)
ÅÅ* +
;
ÅÅ+ ,
byte
ÇÇ 
[
ÇÇ 
]
ÇÇ 
inputHashBytes
ÇÇ !
=
ÇÇ" #
sha256
ÇÇ$ *
.
ÇÇ* +
ComputeHash
ÇÇ+ 6
(
ÇÇ6 7
Encoding
ÇÇ7 ?
.
ÇÇ? @
UTF8
ÇÇ@ D
.
ÇÇD E
GetBytes
ÇÇE M
(
ÇÇM N
password
ÇÇN V
)
ÇÇV W
)
ÇÇW X
;
ÇÇX Y
var
ÉÉ 
encryptedPassword
ÉÉ !
=
ÉÉ" #
Convert
ÉÉ$ +
.
ÉÉ+ ,
ToBase64String
ÉÉ, :
(
ÉÉ: ;
inputHashBytes
ÉÉ; I
)
ÉÉI J
;
ÉÉJ K
if
ÖÖ 
(
ÖÖ 
encryptedPassword
ÖÖ !
==
ÖÖ" $

dbPassword
ÖÖ% /
)
ÖÖ/ 0
{
ÜÜ 
return
áá 
true
áá 
;
áá 
}
àà 
else
ââ 
{
ää 
return
ãã 
false
ãã 
;
ãã 
}
åå 
}
çç 	
private
èè 
async
èè 
Task
èè 
<
èè 
string
èè !
>
èè! "#
_generateRefreshToken
èè# 8
(
èè8 9
String
èè9 ?
role
èè@ D
,
èèD E
Voter
èèF K
?
èèK L
voter
èèM R
,
èèR S
Admin
èèT Y
?
èèY Z
admin
èè[ `
)
èè` a
{
êê 	
var
íí 
token
íí 
=
íí 
Convert
íí 
.
íí  
ToBase64String
íí  .
(
íí. /#
RandomNumberGenerator
íí/ D
.
ííD E
GetBytes
ííE M
(
ííM N
$num
ííN P
)
ííP Q
)
ííQ R
;
ííR S
if
îî 
(
îî 
role
îî 
==
îî 
$str
îî 
)
îî  
{
ïï 
var
ññ 
refreshTokenList
ññ $
=
ññ% &
await
ññ' ,%
_refreshTokenRepository
ññ- D
.
ññD E
GetAllAsync
ññE P
(
ññP Q
$num
ññQ R
,
ññR S
$num
ññT U
,
ññU V
true
ññW [
)
ññ[ \
;
ññ\ ]
var
óó 
refreshToken
óó  
=
óó! "
refreshTokenList
óó# 3
.
óó3 4
FirstOrDefault
óó4 B
(
óóB C
x
óóC D
=>
óóE G
x
óóH I
.
óóI J
Voter
óóJ O
==
óóP R
voter
óóS X
)
óóX Y
;
óóY Z
if
òò 
(
òò 
refreshToken
òò  
==
òò! #
null
òò$ (
)
òò( )
{
ôô 
var
õõ 
_refreshToken
õõ %
=
õõ& '
new
õõ( +
RefreshToken
õõ, 8
(
õõ8 9
)
õõ9 :
{
úú 
Admin
ùù 
=
ùù 
null
ùù  $
,
ùù$ %
AdminId
ûû 
=
ûû  !
null
ûû" &
,
ûû& '
Token
üü 
=
üü 
token
üü  %
,
üü% &
TokenExp
††  
=
††! "
DateTime
††# +
.
††+ ,
Now
††, /
.
††/ 0
AddDays
††0 7
(
††7 8
$num
††8 9
)
††9 :
,
††: ;
VoterId
°° 
=
°°  !
voter
°°" '
?
°°' (
.
°°( )
VoterId
°°) 0
,
°°0 1
Voter
¢¢ 
=
¢¢ 
voter
¢¢  %
}
££ 
;
££ 
await
§§ %
_refreshTokenRepository
§§ 1
.
§§1 2
CreateAsync
§§2 =
(
§§= >
_refreshToken
§§> K
)
§§K L
;
§§L M
await
•• %
_refreshTokenRepository
•• 1
.
••1 2
	SaveAsync
••2 ;
(
••; <
)
••< =
;
••= >
}
¶¶ 
else
ßß 
{
®® 
refreshToken
©©  
.
©©  !
Token
©©! &
=
©©' (
token
©©) .
;
©©. /
refreshToken
™™  
.
™™  !
TokenExp
™™! )
=
™™* +
DateTime
™™, 4
.
™™4 5
Now
™™5 8
.
™™8 9
AddDays
™™9 @
(
™™@ A
$num
™™A B
)
™™B C
;
™™C D
await
´´ %
_refreshTokenRepository
´´ 1
.
´´1 2
	SaveAsync
´´2 ;
(
´´; <
)
´´< =
;
´´= >
}
¨¨ 
}
≠≠ 
if
ÆÆ 
(
ÆÆ 
role
ÆÆ 
==
ÆÆ 
$str
ÆÆ 
)
ÆÆ  
{
ØØ 
var
∞∞ 
refreshTokenList
∞∞ $
=
∞∞% &
await
∞∞' ,%
_refreshTokenRepository
∞∞- D
.
∞∞D E
GetAllAsync
∞∞E P
(
∞∞P Q
$num
∞∞Q R
,
∞∞R S
$num
∞∞T U
,
∞∞U V
true
∞∞W [
)
∞∞[ \
;
∞∞\ ]
var
±± 
refreshToken
±±  
=
±±! "
refreshTokenList
±±# 3
.
±±3 4
FirstOrDefault
±±4 B
(
±±B C
x
±±C D
=>
±±E G
x
±±H I
.
±±I J
Admin
±±J O
==
±±P R
admin
±±S X
)
±±X Y
;
±±Y Z
if
≤≤ 
(
≤≤ 
refreshToken
≤≤  
==
≤≤! #
null
≤≤$ (
)
≤≤( )
{
≥≥ 
var
µµ 
_refreshToken
µµ %
=
µµ& '
new
µµ( +
RefreshToken
µµ, 8
(
µµ8 9
)
µµ9 :
{
∂∂ 
Admin
∑∑ 
=
∑∑ 
admin
∑∑  %
,
∑∑% &
AdminId
∏∏ 
=
∏∏  !
admin
∏∏" '
?
∏∏' (
.
∏∏( )
AdminId
∏∏) 0
,
∏∏0 1
Token
ππ 
=
ππ 
token
ππ  %
,
ππ% &
TokenExp
∫∫  
=
∫∫! "
DateTime
∫∫# +
.
∫∫+ ,
Now
∫∫, /
.
∫∫/ 0
AddDays
∫∫0 7
(
∫∫7 8
$num
∫∫8 9
)
∫∫9 :
,
∫∫: ;
VoterId
ªª 
=
ªª  !
null
ªª" &
,
ªª& '
Voter
ºº 
=
ºº 
null
ºº  $
}
ΩΩ 
;
ΩΩ 
await
ææ %
_refreshTokenRepository
ææ 1
.
ææ1 2
CreateAsync
ææ2 =
(
ææ= >
_refreshToken
ææ> K
)
ææK L
;
ææL M
await
øø %
_refreshTokenRepository
øø 1
.
øø1 2
	SaveAsync
øø2 ;
(
øø; <
)
øø< =
;
øø= >
}
¿¿ 
else
¡¡ 
{
¬¬ 
refreshToken
ƒƒ  
.
ƒƒ  !
Token
ƒƒ! &
=
ƒƒ' (
token
ƒƒ) .
;
ƒƒ. /
refreshToken
≈≈  
.
≈≈  !
TokenExp
≈≈! )
=
≈≈* +
DateTime
≈≈, 4
.
≈≈4 5
Now
≈≈5 8
.
≈≈8 9
AddDays
≈≈9 @
(
≈≈@ A
$num
≈≈A B
)
≈≈B C
;
≈≈C D
await
∆∆ %
_refreshTokenRepository
∆∆ 1
.
∆∆1 2
	SaveAsync
∆∆2 ;
(
∆∆; <
)
∆∆< =
;
∆∆= >
}
«« 
}
»» 
return
   
token
   
;
   
}
ÀÀ 	
public
ÕÕ 
async
ÕÕ 
Task
ÕÕ 
<
ÕÕ 
LoginResponseDto
ÕÕ *
>
ÕÕ* +)
GenerateJwtFromRefreshToken
ÕÕ, G
(
ÕÕG H
string
ÕÕH N
refreshToken
ÕÕO [
)
ÕÕ[ \
{
ŒŒ 	
var
œœ 
refreshTokenList
œœ  
=
œœ! "
await
œœ# (%
_refreshTokenRepository
œœ) @
.
œœ@ A
GetAllAsync
œœA L
(
œœL M
$num
œœM N
,
œœN O
$num
œœP Q
,
œœQ R
true
œœS W
)
œœW X
;
œœX Y
var
–– 
dbrefreshToken
–– 
=
––  
_context
––! )
.
––) *
RefreshTokens
––* 7
.
––7 8
Include
––8 ?
(
––? @
x
––@ A
=>
––B D
x
––E F
.
––F G
Voter
––G L
)
––L M
.
––M N
Include
––N U
(
––U V
x
––V W
=>
––X Z
x
––[ \
.
––\ ]
Admin
––] b
)
––b c
.
––c d
FirstOrDefault
––d r
(
––r s
x
––s t
=>
––u w
x
––x y
.
––y z
Token
––z 
==––Ä Ç
refreshToken––É è
)––è ê
;––ê ë
var
““ 
loginDto
““ 
=
““ 
new
““ 
LoginDto
““ '
(
““' (
)
““( )
;
““) *
if
”” 
(
”” 
dbrefreshToken
”” 
==
”” !
null
””" &
)
””& '
{
‘‘ 
throw
’’ 
new
’’ $
NullReferenceException
’’ 0
(
’’0 1
$str
’’1 N
)
’’N O
;
’’O P
}
÷÷ 
else
◊◊ 
{
ÿÿ 
if
ŸŸ 
(
ŸŸ 
dbrefreshToken
ŸŸ "
.
ŸŸ" #
VoterId
ŸŸ# *
!=
ŸŸ+ -
null
ŸŸ. 2
)
ŸŸ2 3
{
⁄⁄ 
loginDto
›› 
.
›› 
Email
›› "
=
››# $
dbrefreshToken
››% 3
.
››3 4
Voter
››4 9
.
››9 :
Email
››: ?
;
››? @
loginDto
ﬁﬁ 
.
ﬁﬁ 
Password
ﬁﬁ %
=
ﬁﬁ& '
dbrefreshToken
ﬁﬁ( 6
.
ﬁﬁ6 7
Voter
ﬁﬁ7 <
.
ﬁﬁ< =
Password
ﬁﬁ= E
;
ﬁﬁE F
loginDto
ﬂﬂ 
.
ﬂﬂ 
Role
ﬂﬂ !
=
ﬂﬂ" #
$str
ﬂﬂ$ +
;
ﬂﬂ+ ,
}
‡‡ 
if
·· 
(
·· 
dbrefreshToken
·· "
.
··" #
AdminId
··# *
!=
··+ -
null
··. 2
)
··2 3
{
‚‚ 
loginDto
ÂÂ 
.
ÂÂ 
Email
ÂÂ "
=
ÂÂ# $
dbrefreshToken
ÂÂ% 3
.
ÂÂ3 4
Admin
ÂÂ4 9
.
ÂÂ9 :
Email
ÂÂ: ?
;
ÂÂ? @
loginDto
ÊÊ 
.
ÊÊ 
Password
ÊÊ %
=
ÊÊ& '
dbrefreshToken
ÊÊ( 6
.
ÊÊ6 7
Admin
ÊÊ7 <
.
ÊÊ< =
Password
ÊÊ= E
;
ÊÊE F
loginDto
ÁÁ 
.
ÁÁ 
Role
ÁÁ !
=
ÁÁ" #
$str
ÁÁ$ +
;
ÁÁ+ ,
}
ËË 
if
ÈÈ 
(
ÈÈ 
dbrefreshToken
ÈÈ "
.
ÈÈ" #
TokenExp
ÈÈ# +
<
ÈÈ, -
DateTime
ÈÈ. 6
.
ÈÈ6 7
Now
ÈÈ7 :
)
ÈÈ: ;
{
ÍÍ 
throw
ÏÏ 
new
ÏÏ '
InvalidOperationException
ÏÏ 7
(
ÏÏ7 8
$str
ÏÏ8 S
)
ÏÏS T
;
ÏÏT U
}
ÌÌ 
else
ÓÓ 
{
ÔÔ 
var
ÒÒ 
jwt
ÒÒ 
=
ÒÒ 
_generateJwtToken
ÒÒ /
(
ÒÒ/ 0
loginDto
ÒÒ0 8
)
ÒÒ8 9
;
ÒÒ9 :
return
ÚÚ 
new
ÚÚ 
LoginResponseDto
ÚÚ /
(
ÚÚ/ 0
)
ÚÚ0 1
{
ÛÛ 
JwtToken
ÙÙ  
=
ÙÙ! "
jwt
ÙÙ# &
,
ÙÙ& '
RefreshToken
ıı $
=
ıı% &
refreshToken
ıı' 3
,
ıı3 4
}
ˆˆ 
;
ˆˆ 
}
˜˜ 
}
¯¯ 
}
˘˘ 	
}
˙˙ 
}˚˚ Œi
rC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Services\CandidateService.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
Services( 0
{ 
public 

class 
CandidateService !
:" #
ICandidateService$ 5
{ 
private 
readonly 
IGenericRepository +
<+ ,
	Candidate, 5
>5 6 
_candidateRepository7 K
;K L
private 
readonly 
ApplicationContext +
_context, 4
;4 5
private 
readonly 
IMapper  
_mapper! (
;( )
public 
CandidateService 
(  
IGenericRepository  2
<2 3
	Candidate3 <
>< =

repository> H
,H I
IMapperJ Q
mapperR X
,X Y
ApplicationContextZ l
contextm t
)t u
{ 	
_mapper 
= 
mapper 
;  
_candidateRepository  
=! "

repository# -
;- .
_context 
= 
context 
; 
} 	
public 
async 
Task 
<  
CandidateResponseDto .
>. /
AddCandidate0 <
(< =
CreateCandidateDto= O
createCandidateDtoP b
)b c
{ 	
SHA256 
sha256 
= 
SHA256 "
." #
Create# )
() *
)* +
;+ ,
byte 
[ 
] 
	hashBytes 
= 
sha256 %
.% &
ComputeHash& 1
(1 2
Encoding2 :
.: ;
UTF8; ?
.? @
GetBytes@ H
(H I
createCandidateDtoI [
.[ \
Password\ d
)d e
)e f
;f g
createCandidateDto   
.   
Password   '
=  ( )
Convert  * 1
.  1 2
ToBase64String  2 @
(  @ A
	hashBytes  A J
)  J K
;  K L
var"" 
mappedCandidate"" 
=""  !
_mapper""" )
."") *
Map""* -
<""- .
	Candidate"". 7
>""7 8
(""8 9
createCandidateDto""9 K
)""K L
;""L M
await##  
_candidateRepository## &
.##& '
CreateAsync##' 2
(##2 3
mappedCandidate##3 B
)##B C
;##C D
await$$  
_candidateRepository$$ &
.$$& '
	SaveAsync$$' 0
($$0 1
)$$1 2
;$$2 3
return%% 
_mapper%% 
.%% 
Map%% 
<%%  
CandidateResponseDto%% 3
>%%3 4
(%%4 5
mappedCandidate%%5 D
)%%D E
;%%E F
}&& 	
public)) 
async)) 
Task)) 
<))  
CandidateResponseDto)) .
>)). /
DeleteCandidate))0 ?
())? @
long))@ D
candidateId))E P
)))P Q
{** 	
var++ 
	candidate++ 
=++ 
await++ ! 
_candidateRepository++" 6
.++6 7
GetByIdAsync++7 C
(++C D
candidateId++D O
)++O P
;++P Q
if.. 
(.. 
	candidate.. 
==.. 
null.. !
)..! "
{// 
throw00 
new00  
KeyNotFoundException00 .
(00. /
$str00/ Q
)00Q R
;00R S
}11 
if33 
(33 
	candidate33 
.33 
	IsDeleted33 #
)33# $
{44 
throw55 
new55  
KeyNotFoundException55 .
(55. /
$str55/ S
)55S T
;55T U
}66 
if88 
(88 
	candidate88 
.88 

TotalVotes88 $
==88% '
$num88( )
)88) *
{99 
	candidate:: 
.:: 
	IsDeleted:: #
=::$ %
true::& *
;::* +
};; 
else<< 
{== 
throw>> 
new>> %
InvalidOperationException>> 3
(>>3 4
$str>>4 [
)>>[ \
;>>\ ]
}?? 
awaitAA  
_candidateRepositoryAA &
.AA& '
	SaveAsyncAA' 0
(AA0 1
)AA1 2
;AA2 3
returnBB 
_mapperBB 
.BB 
MapBB 
<BB  
CandidateResponseDtoBB 3
>BB3 4
(BB4 5
	candidateBB5 >
)BB> ?
;BB? @
}CC 	
publicFF 
asyncFF 
TaskFF 
<FF  
CandidateResponseDtoFF .
>FF. /
GetCandidateFF0 <
(FF< =
longFF= A
candidateIdFFB M
)FFM N
{GG 	
varHH 
	candidateHH 
=HH 
awaitHH ! 
_candidateRepositoryHH" 6
.HH6 7
GetByIdAsyncHH7 C
(HHC D
candidateIdHHD O
)HHO P
;HHP Q
ifKK 
(KK 
	candidateKK 
==KK 
nullKK !
)KK! "
{LL 
throwMM 
newMM  
KeyNotFoundExceptionMM .
(MM. /
$strMM/ P
)MMP Q
;MMQ R
}NN 
ifPP 
(PP 
	candidatePP 
.PP 
	IsDeletedPP #
)PP# $
{QQ 
throwRR 
newRR  
KeyNotFoundExceptionRR .
(RR. /
$strRR/ S
)RRS T
;RRT U
}SS 
varUU 
resUU 
=UU 
_mapperUU 
.UU 
MapUU !
<UU! " 
CandidateResponseDtoUU" 6
>UU6 7
(UU7 8
	candidateUU8 A
)UUA B
;UUB C
returnVV 
resVV 
;VV 
}WW 	
publicZZ 
asyncZZ 
TaskZZ 
<ZZ  
CandidateResponseDtoZZ .
>ZZ. /
UpdateCandidateZZ0 ?
(ZZ? @
CandidateUpdateDtoZZ@ R
candidateUpdateDtoZZS e
,ZZe f
longZZg k
candidateIdZZl w
)ZZw x
{[[ 	
var\\ 
	candidate\\ 
=\\ 
await\\ ! 
_candidateRepository\\" 6
.\\6 7
GetByIdAsync\\7 C
(\\C D
candidateId\\D O
)\\O P
;\\P Q
if__ 
(__ 
	candidate__ 
==__ 
null__ !
)__! "
{`` 
throwaa 
newaa  
KeyNotFoundExceptionaa .
(aa. /
$straa/ L
)aaL M
;aaM N
}bb 
ifdd 
(dd 
	candidatedd 
.dd 
	IsDeleteddd #
)dd# $
{ee 
throwff 
newff  
KeyNotFoundExceptionff .
(ff. /
$strff/ S
)ffS T
;ffT U
}gg 
booljj 

hasChangesjj 
=jj 
falsejj #
;jj# $
ifmm 
(mm 
	candidatemm 
.mm 
Namemm 
!=mm !
candidateUpdateDtomm" 4
.mm4 5
Namemm5 9
)mm9 :
{nn 
	candidateoo 
.oo 
Nameoo 
=oo  
candidateUpdateDtooo! 3
.oo3 4
Nameoo4 8
;oo8 9

hasChangespp 
=pp 
truepp !
;pp! "
}qq 
ifss 
(ss 
	candidatess 
.ss 
DOBss 
!=ss  
candidateUpdateDtoss! 3
.ss3 4
DOBss4 7
)ss7 8
{tt 
	candidateuu 
.uu 
DOBuu 
=uu 
candidateUpdateDtouu  2
.uu2 3
DOBuu3 6
;uu6 7

hasChangesvv 
=vv 
truevv !
;vv! "
}ww 
ifyy 
(yy 
	candidateyy 
.yy 
Genderyy  
!=yy! #
candidateUpdateDtoyy$ 6
.yy6 7
Genderyy7 =
)yy= >
{zz 
	candidate{{ 
.{{ 
Gender{{  
={{! "
candidateUpdateDto{{# 5
.{{5 6
Gender{{6 <
;{{< =

hasChanges|| 
=|| 
true|| !
;||! "
}}} 
if~~ 
(~~ 
	candidate~~ 
.~~ 
	PartyName~~ #
!=~~$ &
candidateUpdateDto~~' 9
.~~9 :
	PartyName~~: C
)~~C D
{ 
	candidate
ÄÄ 
.
ÄÄ 
	PartyName
ÄÄ #
=
ÄÄ$ % 
candidateUpdateDto
ÄÄ& 8
.
ÄÄ8 9
	PartyName
ÄÄ9 B
;
ÄÄB C

hasChanges
ÅÅ 
=
ÅÅ 
true
ÅÅ !
;
ÅÅ! "
}
ÇÇ 
if
ÖÖ 
(
ÖÖ 

hasChanges
ÖÖ 
)
ÖÖ 
{
ÜÜ 
	candidate
áá 
.
áá 
DateUpdated
áá %
=
áá& '
DateTimeOffset
áá( 6
.
áá6 7
Now
áá7 :
;
áá: ;"
_candidateRepository
àà $
.
àà$ %
Update
àà% +
(
àà+ ,
	candidate
àà, 5
)
àà5 6
;
àà6 7
await
ââ "
_candidateRepository
ââ *
.
ââ* +
	SaveAsync
ââ+ 4
(
ââ4 5
)
ââ5 6
;
ââ6 7
return
ää 
_mapper
ää 
.
ää 
Map
ää "
<
ää" #"
CandidateResponseDto
ää# 7
>
ää7 8
(
ää8 9 
candidateUpdateDto
ää9 K
)
ääK L
;
ääL M
}
ãã 
throw
çç 
new
çç '
InvalidOperationException
çç /
(
çç/ 0
$str
çç0 Z
)
ççZ [
;
çç[ \
}
éé 	
public
ëë 
async
ëë 
Task
ëë 
<
ëë 
IEnumerable
ëë %
<
ëë% &
	Candidate
ëë& /
>
ëë/ 0
>
ëë0 1
GetAllCandidate
ëë2 A
(
ëëA B
int
ëëB E

pageNumber
ëëF P
,
ëëP Q
int
ëëR U
pageSize
ëëV ^
,
ëë^ _
bool
ëë` d
fetchAll
ëëe m
)
ëëm n
{
íí 	
return
ìì 
await
ìì "
_candidateRepository
ìì -
.
ìì- .
GetAllAsync
ìì. 9
(
ìì9 :

pageNumber
ìì: D
,
ììD E
pageSize
ììF N
,
ììN O
fetchAll
ììP X
)
ììX Y
;
ììY Z
}
îî 	
public
óó 
async
óó 
Task
óó 
<
óó 
IEnumerable
óó %
<
óó% &
	Candidate
óó& /
>
óó/ 0
>
óó0 1$
GeetTopThreeCandidates
óó2 H
(
óóH I
)
óóI J
{
òò 	
var
ôô 
candidateList
ôô 
=
ôô 
await
ôô  %"
_candidateRepository
ôô& :
.
ôô: ;
GetAllAsync
ôô; F
(
ôôF G
$num
ôôG H
,
ôôH I
$num
ôôJ K
,
ôôK L
true
ôôM Q
)
ôôQ R
;
ôôR S
if
öö 
(
öö 
candidateList
öö 
==
öö  
null
öö! %
)
öö% &
{
õõ 
return
úú 

Enumerable
úú !
.
úú! "
Empty
úú" '
<
úú' (
	Candidate
úú( 1
>
úú1 2
(
úú2 3
)
úú3 4
;
úú4 5
}
ùù 
else
ûû 
{
üü 
var
†† #
topThreeCandidateList
†† )
=
††* +
await
††, 1
_context
††2 :
.
††: ;

Candidates
††; E
.
††E F

FromSqlRaw
††F P
(
††P Q
$str
††Q m
)
††m n
.
††n o
ToListAsync
††o z
(
††z {
)
††{ |
;
††| }
return
°° #
topThreeCandidateList
°° ,
;
°°, -
}
¢¢ 
}
££ 	
public
•• 
async
•• 
Task
•• 
<
•• 
IEnumerable
•• %
<
••% &
	Candidate
••& /
>
••/ 0
>
••0 1#
SearchByCandidateName
••2 G
(
••G H
string
••H N
candidateName
••O \
)
••\ ]
{
¶¶ 	
if
ßß 
(
ßß 
candidateName
ßß 
==
ßß  
null
ßß! %
)
ßß% &
{
®® 
throw
©© 
new
©© '
InvalidOperationException
©© 3
(
©©3 4
$str
©©4 K
)
©©K L
;
©©L M
}
™™ 
var
´´ 
query
´´ 
=
´´ 
$"
´´ 
$str
´´ 5
{
´´5 6
candidateName
´´6 C
}
´´C D
"
´´D E
;
´´E F
return
¨¨ 
await
¨¨ 
_context
¨¨ !
.
¨¨! "

Candidates
¨¨" ,
.
¨¨, -

FromSqlRaw
¨¨- 7
(
¨¨7 8
query
¨¨8 =
)
¨¨= >
.
¨¨> ?
ToListAsync
¨¨? J
(
¨¨J K
)
¨¨K L
;
¨¨L M
}
≠≠ 	
}
ÆÆ 
}ØØ Ê-
nC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Services\AdminService.cs
	namespace

 	
VotingApplication


 
.

 
Application

 '
.

' (
Services

( 0
{ 
public 

class 
AdminService 
: 
IAdminService  -
{ 
private 
readonly 
IGenericRepository +
<+ ,
Admin, 1
>1 2
_adminRespository3 D
;D E
private 
readonly 
IMapper  
_mapper! (
;( )
public 
AdminService 
( 
IGenericRepository .
<. /
Admin/ 4
>4 5
adminRespository6 F
,F G
IMapperH O
mapperP V
)V W
{ 	
_adminRespository 
= 
adminRespository  0
;0 1
_mapper 
= 
mapper 
; 
} 	
public 
async 
Task 
< 
AdminResponseDto *
>* +
AddAdmin, 4
(4 5
CreateAdminDto5 C
createAdminDtoD R
)R S
{ 	
var 
	adminList 
= 
await !
_adminRespository" 3
.3 4
GetAllAsync4 ?
(? @
$num@ A
,A B
$numC D
,D E
trueF J
)J K
;K L
for 
( 
int 
i 
= 
$num 
; 
i 
< 
	adminList  )
.) *
Count* /
(/ 0
)0 1
;1 2
i3 4
++4 6
)6 7
{ 
if 
( 
	adminList 
. 
	ElementAt '
(' (
i( )
)) *
.* +
Email+ 0
==1 3
createAdminDto4 B
.B C
EmailC H
&&I K
!L M
	adminListM V
.V W
	ElementAtW `
(` a
ia b
)b c
.c d
	IsDeletedd m
)m n
{ 
throw 
new "
DuplicateNameException 4
(4 5
$str5 Z
)Z [
;[ \
}   
}!! 
SHA256$$ 
sha256$$ 
=$$ 
SHA256$$ "
.$$" #
Create$$# )
($$) *
)$$* +
;$$+ ,
byte%% 
[%% 
]%% 
	hashBytes%% 
=%% 
sha256%% %
.%%% &
ComputeHash%%& 1
(%%1 2
Encoding%%2 :
.%%: ;
UTF8%%; ?
.%%? @
GetBytes%%@ H
(%%H I
createAdminDto%%I W
.%%W X
Password%%X `
)%%` a
)%%a b
;%%b c
createAdminDto&& 
.&& 
Password&& #
=&&$ %
Convert&&& -
.&&- .
ToBase64String&&. <
(&&< =
	hashBytes&&= F
)&&F G
;&&G H
var'' 
_mappedAdmin'' 
='' 
_mapper'' &
.''& '
Map''' *
<''* +
Admin''+ 0
>''0 1
(''1 2
createAdminDto''2 @
)''@ A
;''A B
await)) 
_adminRespository)) #
.))# $
CreateAsync))$ /
())/ 0
_mappedAdmin))0 <
)))< =
;))= >
await** 
_adminRespository** #
.**# $
	SaveAsync**$ -
(**- .
)**. /
;**/ 0
return++ 
_mapper++ 
.++ 
Map++ 
<++ 
AdminResponseDto++ /
>++/ 0
(++0 1
_mappedAdmin++1 =
)++= >
;++> ?
},, 	
public.. 
async.. 
Task.. 
<.. 
AdminResponseDto.. *
>..* +
GetAdminById.., 8
(..8 9
long..9 =
adminId..> E
)..E F
{// 	
var00 
admin00 
=00 
await00 
_adminRespository00 /
.00/ 0
GetByIdAsync000 <
(00< =
adminId00= D
)00D E
;00E F
if22 
(22 
admin22 
==22 
null22 
)22 
{33 
throw44 
new44  
KeyNotFoundException44 .
(44. /
$str44/ M
)44M N
;44N O
}55 
if77 
(77 
admin77 
.77 
	IsDeleted77 
)77  
{88 
throw99 
new99  
KeyNotFoundException99 .
(99. /
$str99/ O
)99O P
;99P Q
}:: 
return;; 
_mapper;; 
.;; 
Map;; 
<;; 
AdminResponseDto;; /
>;;/ 0
(;;0 1
admin;;1 6
);;6 7
;;;7 8
}<< 	
public>> 
async>> 
Task>> 
<>> 
IEnumerable>> %
<>>% &
Admin>>& +
>>>+ ,
>>>, -
GetAllAdmin>>. 9
(>>9 :
int>>: =

pageNumber>>> H
,>>H I
int>>J M
pageSize>>N V
,>>V W
bool>>X \
fetchAll>>] e
)>>e f
{?? 	
return@@ 
await@@ 
_adminRespository@@ *
.@@* +
GetAllAsync@@+ 6
(@@6 7

pageNumber@@7 A
,@@A B
pageSize@@C K
,@@K L
fetchAll@@M U
)@@U V
;@@V W
}AA 	
}BB 
}CC ´
mC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Response\ApiResponse.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
Response( 0
{ 
public 

class 
ApiResponse 
< 
T 
> 
(  
int  #

statusCode$ .
,. /
T0 1
body2 6
,6 7
T8 9
error: ?
,? @
stringA G
messageH O
)O P
{ 
public 
int 

StatusCode 
{ 
get  #
;# $
set% (
;( )
}* +
=, -

statusCode. 8
;8 9
public

 
T

 
?

 
Body

 
{

 
get

 
;

 
set

 !
;

! "
}

# $
=

% &
body

' +
;

+ ,
public 
T 
Error 
{ 
get 
; 
set !
;! "
}# $
=% &
error' ,
;, -
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
message. 5
;5 6
} 
} ˇ
qC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Interfaces\IVoterService.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (

Interfaces( 2
{ 
public 

	interface 
IVoterService "
{ 
public

 
Task

 
<

 
VoterResponseDto

 $
>

$ %
AddVoter

& .
(

. /
CreateVoterDto

/ =
createVoterDto

> L
)

L M
;

M N
public 
Task 
< 
VoterResponseDto $
>$ %
GetVoter& .
(. /
long/ 3
voterId4 ;
); <
;< =
public 
Task 
< 
VoterResponseDto $
>$ %
UpdateVoter& 1
(1 2
VoterUpdateDto2 @
voterUpdateDtoA O
,O P
longQ U
voterIdV ]
)] ^
;^ _
public 
Task 
< 
VoterResponseDto $
>$ %
DeleteVoter& 1
(1 2
long2 6
voterId7 >
)> ?
;? @
public 
Task 
< 
VoterResponseDto $
>$ %
VoteToCandidate& 5
(5 6
long6 :
candidateId; F
,F G
longH L
voterIdM T
)T U
;U V
public 
Task 
< 
IEnumerable 
<  
Voter  %
>% &
>& '
GetAllVoters( 4
(4 5
int5 8

pageNumber9 C
,C D
intE H
pageSizeI Q
,Q R
boolS W
fetchAllX `
)` a
;a b
public 
Task 
< 
IEnumerable 
<  
Voter  %
>% &
>& '
SearchVoterByName( 9
(9 :
string: @
	voterNameA J
)J K
;K L
} 
} ˜
qC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Interfaces\IPartyService.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (

Interfaces( 2
{ 
public 

	interface 
IPartyService "
{ 
public 
Task 
< 
PartyResponseDto $
>$ %
AddParty& .
(. /
CreatePartyDto/ =
createPartyDto> L
)L M
;M N
public

 
Task

 
<

 
IEnumerable

 
<

  
Party

  %
>

% &
>

& '
GetAllParties

( 5
(

5 6
int

6 9

pageNumber

: D
,

D E
int

F I
pageSize

J R
,

R S
bool

T X
fetchAll

Y a
)

a b
;

b c
public 
Task 
< 
PartyResponseDto $
>$ %
GetPartyById& 2
(2 3
long3 7
PartyId8 ?
)? @
;@ A
public 
Task 
< 
PartyResponseDto $
>$ %
DeleteParty& 1
(1 2
long2 6
PartyId7 >
)> ?
;? @
public 
Task 
< 
PartyResponseDto $
>$ %
UpdateParty& 1
(1 2
UpdatePartyDto2 @
updatePartyDtoA O
,O P
longQ U
PartyIdV ]
)] ^
;^ _
public 
Task 
< 
IEnumerable 
<  
Party  %
>% &
>& '
SearchByPartyName( 9
(9 :
string: @
	partyNameA J
)J K
;K L
} 
} ®
qC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Interfaces\ILoginService.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (

Interfaces( 2
{ 
public 

	interface 
ILoginService "
{ 
public 
Task 
< 
LoginResponseDto $
>$ %
Login& +
(+ ,
LoginDto, 4
loginDto5 =
)= >
;> ?
public

 
Task

 
<

 
LoginResponseDto

 $
>

$ %'
GenerateJwtFromRefreshToken

& A
(

A B
string

B H
refreshToken

I U
)

U V
;

V W
} 
} ¨
uC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Interfaces\ICandidateService.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (

Interfaces( 2
{ 
public 

	interface 
ICandidateService &
{ 
public

 
Task

 
<

  
CandidateResponseDto

 (
>

( )
AddCandidate

* 6
(

6 7
CreateCandidateDto

7 I
createCandidateDto

J \
)

\ ]
;

] ^
public 
Task 
<  
CandidateResponseDto (
>( )
GetCandidate* 6
(6 7
long7 ;
candidateId< G
)G H
;H I
public 
Task 
<  
CandidateResponseDto (
>( )
UpdateCandidate* 9
(9 :
CandidateUpdateDto: L
candidateUpdateDtoM _
,_ `
longa e
candidateIdf q
)q r
;r s
public 
Task 
<  
CandidateResponseDto (
>( )
DeleteCandidate* 9
(9 :
long: >
candidateId? J
)J K
;K L
public 
Task 
< 
IEnumerable 
<  
	Candidate  )
>) *
>* +
GetAllCandidate, ;
(; <
int< ?

pageNumber@ J
,J K
intL O
pageSizeP X
,X Y
boolZ ^
fetchAll_ g
)g h
;h i
public 
Task 
< 
IEnumerable 
<  
	Candidate  )
>) *
>* +"
GeetTopThreeCandidates, B
(B C
)C D
;D E
public 
Task 
< 
IEnumerable 
<  
	Candidate  )
>) *
>* +!
SearchByCandidateName, A
(A B
stringB H
candidateNameI V
)V W
;W X
} 
} ã	
qC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Interfaces\IAdminService.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (

Interfaces( 2
{ 
public 

	interface 
IAdminService "
{ 
public 
Task 
< 
AdminResponseDto $
>$ %
AddAdmin& .
(. /
CreateAdminDto/ =
createAdminDto> L
)L M
;M N
public

 
Task

 
<

 
IEnumerable

 
<

  
Admin

  %
>

% &
>

& '
GetAllAdmin

( 3
(

3 4
int

4 7

pageNumber

8 B
,

B C
int

D G
pageSize

H P
,

P Q
bool

R V
fetchAll

W _
)

_ `
;

` a
public 
Task 
< 
AdminResponseDto $
>$ %
GetAdminById& 2
(2 3
long3 7
AdminId8 ?
)? @
;@ A
} 
} ¯
kC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\VoterUpdateDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
VoterUpdateDto 
{ 
[		 	
Required			 
(		 
ErrorMessage		 
=		  
$str		! :
)		: ;
]		; <
public

 
string

 
Name

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
$str

+ -
;

- .
[ 	
Required	 
( 
ErrorMessage 
=  
$str! 9
)9 :
]: ;
[ 	
VoterAge	 
] 
public 
DateOnly 
DOB 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
( 
ErrorMessage 
=  
$str! :
): ;
]; <
public 
string 
Gender 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
[ 	
EmailAddress	 
] 
[ 	
Required	 
( 
ErrorMessage 
=  
$str! ;
); <
]< =
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
} 
} î
mC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\VoterResponseDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
VoterResponseDto !
:" #
BaseEntityDto$ 1
{ 
public 
long 
VoterId 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public

 
bool

 
HasVoted

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
public 
DateOnly 
DOB 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
Gender 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 
string 
? 
Password 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
} 
} ú
kC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\UpdatePartyDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
UpdatePartyDto 
{ 
[ 	
	MinLength	 
( 
$num 
, 
ErrorMessage "
=# $
$str% T
)T U
]U V
[ 	
	MaxLength	 
( 
$num 
, 
ErrorMessage "
=# $
$str% \
)\ ]
]] ^
[		 	
Required			 
(		 
ErrorMessage		 
=		  
$str		! @
)		@ A
]		A B
public

 
string

 
	PartyName

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
=

. /
$str

0 2
;

2 3
} 
} ∂
lC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\RefreshTokenDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public		 

class		 
RefreshTokenDto		  
{

 
public 
string 
RefreshToken "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
} 
} ¯
mC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\PartyResponseDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
PartyResponseDto !
:" #
BaseEntityDto$ 1
{ 
public 
string 
	PartyName 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 
long 
PartyId 
{ 
get !
;! "
set# &
;& '
}( )
} 
} Ñ
mC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\LoginResponseDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public		 

class		 
LoginResponseDto		 !
{

 
public 
string 
JwtToken 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
public 
string 
RefreshToken "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
} 
} î
eC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\LoginDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
LoginDto 
{ 
[ 	
EmailAddress	 
] 
[ 	
Required	 
( 
ErrorMessage 
=  
$str! ;
); <
]< =
public		 
string		 
Email		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
=		* +
$str		, .
;		. /
[ 	
Required	 
( 
ErrorMessage 
=  
$str! >
)> ?
]? @
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
[ 	
Required	 
( 
ErrorMessage 
=  
$str! :
): ;
]; <
public 
string 
Role 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
} 
} Ô
kC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\CreateVoterDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
CreateVoterDto 
{ 
[		 	
Required			 
(		 
ErrorMessage		 
=		  
$str		! :
)		: ;
]		; <
public

 
string

 
Name

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
$str

+ -
;

- .
[ 	
Required	 
( 
ErrorMessage 
=  
$str! 9
)9 :
]: ;
[ 	
VoterAge	 
] 
public 
DateOnly 
DOB 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
( 
ErrorMessage 
=  
$str! <
)< =
]= >
public 
string 
? 
Gender 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
[ 	
EmailAddress	 
] 
[ 	
Required	 
( 
ErrorMessage 
=  
$str! ;
); <
]< =
public 
string 
? 
Email 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
[ 	
Required	 
( 
ErrorMessage 
=  
$str! D
)D E
]E F
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
} 
} ´
kC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\CreatePartyDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
CreatePartyDto 
{ 
[ 	
	MinLength	 
( 
$num 
, 
ErrorMessage "
=# $
$str% T
)T U
]U V
[ 	
	MaxLength	 
( 
$num 
, 
ErrorMessage "
=# $
$str% \
)\ ]
]] ^
[		 	
Required			 
(		 
ErrorMessage		 
=		  
$str		! @
)		@ A
]		A B
public

 
string

 
?

 
	PartyName

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
=

/ 0
$str

1 3
;

3 4
} 
} á
oC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\CreateCandidateDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
CreateCandidateDto #
{ 
[		 	
Required			 
(		 
ErrorMessage		 
=		  
$str		! :
)		: ;
]		; <
public

 
string

 
Name

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
$str

+ -
;

- .
[ 	
Required	 
( 
ErrorMessage 
=  
$str! 9
)9 :
]: ;
[ 	
CandidateAge	 
] 
public 
DateOnly 
DOB 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
( 
ErrorMessage 
=  
$str! <
)< =
]= >
public 
string 
Gender 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
[ 	
Required	 
( 
ErrorMessage 
=  
$str! H
)H I
]I J
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
[ 	
	MinLength	 
( 
$num 
, 
ErrorMessage "
=# $
$str% T
)T U
]U V
[ 	
	MaxLength	 
( 
$num 
, 
ErrorMessage "
=# $
$str% \
)\ ]
]] ^
[ 	
Required	 
( 
ErrorMessage 
=  
$str! @
)@ A
]A B
public 
string 
	PartyName 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
} 
} ⁄
kC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\CreateAdminDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
CreateAdminDto 
{ 
[ 	
EmailAddress	 
] 
[ 	
Required	 
( 
ErrorMessage 
=  
$str! ;
); <
]< =
public		 
string		 
?		 
Email		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
=		+ ,
$str		- /
;		/ 0
[ 	
Required	 
( 
ErrorMessage 
=  
$str! D
)D E
]E F
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
} 
} Æ
oC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\CandidateUpdateDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
CandidateUpdateDto #
{ 
[		 	
Required			 
(		 
ErrorMessage		 
=		  
$str		! :
)		: ;
]		; <
public

 
string

 
Name

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
$str

+ -
;

- .
[ 	
Required	 
( 
ErrorMessage 
=  
$str! 9
)9 :
]: ;
[ 	
CandidateAge	 
] 
public 
DateOnly 
DOB 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
( 
ErrorMessage 
=  
$str! <
)< =
]= >
public 
string 
Gender 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
[ 	
	MinLength	 
( 
$num 
, 
ErrorMessage "
=# $
$str% T
)T U
]U V
[ 	
	MaxLength	 
( 
$num 
, 
ErrorMessage "
=# $
$str% \
)\ ]
]] ^
[ 	
Required	 
( 
ErrorMessage 
=  
$str! @
)@ A
]A B
public 
string 
	PartyName 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
} 
} ê
qC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\CandidateResponseDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class  
CandidateResponseDto %
:& '
BaseEntityDto( 5
{ 
public 
long 
CandidateId 
{  !
get" %
;% &
set' *
;* +
}, -
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 
string 
Gender 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
public		 
DateOnly		 
DOB		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 
long

 

TotalVotes

 
{

  
get

! $
;

$ %
set

& )
;

) *
}

+ ,
=

- .
$num

/ 0
;

0 1
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 
string 
	PartyName 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
} 
} ô
jC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\BaseEntityDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
BaseEntityDto 
{ 
public 
DateTimeOffset 
DateCreated )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
=8 9
DateTimeOffset: H
.H I
NowI L
;L M
public 
DateTimeOffset 
? 
DateUpdated *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
} 
}		 £
mC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\DTO\AdminResponseDto.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
DTO( +
{ 
public 

class 
AdminResponseDto !
:" #
BaseEntityDto$ 1
{ 
public 
string 
Role 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
} 
} «
pC:\Users\ninad.trivedi\source\repos\VotingApi\VotingApi\VotingApplication.Application\Config\AutoMapperConfig.cs
	namespace 	
VotingApplication
 
. 
Application '
.' (
Config( .
{ 
public 

class 
AutoMapperConfig !
:" #
Profile$ +
{		 
public

 
AutoMapperConfig

 
(

  
)

  !
{ 	
	CreateMap 
< 
Voter 
, 
CreateVoterDto +
>+ ,
(, -
)- .
.. /

ReverseMap/ 9
(9 :
): ;
;; <
	CreateMap 
< 
Voter 
, 
VoterResponseDto -
>- .
(. /
)/ 0
.0 1

ReverseMap1 ;
(; <
)< =
;= >
	CreateMap 
< 
Voter 
, 
VoterUpdateDto +
>+ ,
(, -
)- .
.. /

ReverseMap/ 9
(9 :
): ;
;; <
	CreateMap 
< 
CreateVoterDto $
,$ %
VoterResponseDto& 6
>6 7
(7 8
)8 9
.9 :

ReverseMap: D
(D E
)E F
;F G
	CreateMap 
< 
VoterUpdateDto $
,$ %
VoterResponseDto& 6
>6 7
(7 8
)8 9
.9 :

ReverseMap: D
(D E
)E F
;F G
	CreateMap 
< 
	Candidate 
,  
CreateCandidateDto! 3
>3 4
(4 5
)5 6
.6 7

ReverseMap7 A
(A B
)B C
;C D
	CreateMap 
< 
	Candidate 
,   
CandidateResponseDto! 5
>5 6
(6 7
)7 8
.8 9

ReverseMap9 C
(C D
)D E
;E F
	CreateMap 
< 
	Candidate 
,  
CandidateUpdateDto! 3
>3 4
(4 5
)5 6
.6 7

ReverseMap7 A
(A B
)B C
;C D
	CreateMap 
< 
CreateCandidateDto (
,( ) 
CandidateResponseDto* >
>> ?
(? @
)@ A
.A B

ReverseMapB L
(L M
)M N
;N O
	CreateMap 
< 
CandidateUpdateDto (
,( ) 
CandidateResponseDto* >
>> ?
(? @
)@ A
.A B

ReverseMapB L
(L M
)M N
;N O
	CreateMap 
< 
Admin 
, 
CreateAdminDto +
>+ ,
(, -
)- .
.. /

ReverseMap/ 9
(9 :
): ;
;; <
	CreateMap 
< 
Admin 
, 
AdminResponseDto -
>- .
(. /
)/ 0
.0 1

ReverseMap1 ;
(; <
)< =
;= >
	CreateMap 
< 
Party 
, 
CreatePartyDto +
>+ ,
(, -
)- .
.. /

ReverseMap/ 9
(9 :
): ;
;; <
	CreateMap   
<   
Party   
,   
PartyResponseDto   -
>  - .
(  . /
)  / 0
.  0 1

ReverseMap  1 ;
(  ; <
)  < =
;  = >
	CreateMap!! 
<!! 
Party!! 
,!! 
UpdatePartyDto!! +
>!!+ ,
(!!, -
)!!- .
.!!. /

ReverseMap!!/ 9
(!!9 :
)!!: ;
;!!; <
}"" 	
}## 
}$$ 