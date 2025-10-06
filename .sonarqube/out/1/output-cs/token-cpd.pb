�
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
} �
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
} ��
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
candidateRepository	p �
,
� � 
ApplicationContext
� � 
applicationContext
� �
)
� �
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
�� 
bool
�� 

hasChanges
�� 
=
�� 
false
�� #
;
��# $
if
�� 
(
�� 
voter
�� 
.
�� 
Name
�� 
!=
�� 
voterUpdateDto
�� ,
.
��, -
Name
��- 1
)
��1 2
{
�� 
voter
�� 
.
�� 
Name
�� 
=
�� 
voterUpdateDto
�� +
.
��+ ,
Name
��, 0
;
��0 1

hasChanges
�� 
=
�� 
true
�� !
;
��! "
}
�� 
if
�� 
(
�� 
voter
�� 
.
�� 
Email
�� 
!=
�� 
voterUpdateDto
�� -
.
��- .
Email
��. 3
)
��3 4
{
�� 
voter
�� 
.
�� 
Email
�� 
=
�� 
voterUpdateDto
�� ,
.
��, -
Email
��- 2
;
��2 3

hasChanges
�� 
=
�� 
true
�� !
;
��! "
}
�� 
if
�� 
(
�� 
voter
�� 
.
�� 
DOB
�� 
!=
�� 
voterUpdateDto
�� +
.
��+ ,
DOB
��, /
)
��/ 0
{
�� 
voter
�� 
.
�� 
DOB
�� 
=
�� 
voterUpdateDto
�� *
.
��* +
DOB
��+ .
;
��. /

hasChanges
�� 
=
�� 
true
�� !
;
��! "
}
�� 
if
�� 
(
�� 
voter
�� 
.
�� 
Gender
�� 
!=
�� 
voterUpdateDto
��  .
.
��. /
Gender
��/ 5
)
��5 6
{
�� 
voter
�� 
.
�� 
Gender
�� 
=
�� 
voterUpdateDto
�� -
.
��- .
Gender
��. 4
;
��4 5

hasChanges
�� 
=
�� 
true
�� !
;
��! "
}
�� 
if
�� 
(
�� 

hasChanges
�� 
)
�� 
{
�� 
var
�� 
	voterList
�� 
=
�� 
await
��  %
_voterRepository
��& 6
.
��6 7
GetAllAsync
��7 B
(
��B C
$num
��C D
,
��D E
$num
��F G
,
��G H
true
��I M
)
��M N
;
��N O
for
�� 
(
�� 
int
�� 
i
�� 
=
�� 
$num
�� 
;
�� 
i
��  !
<
��" #
	voterList
��$ -
.
��- .
Count
��. 3
(
��3 4
)
��4 5
;
��5 6
i
��7 8
++
��8 :
)
��: ;
{
�� 
if
�� 
(
�� 
	voterList
�� !
.
��! "
	ElementAt
��" +
(
��+ ,
i
��, -
)
��- .
.
��. /
Email
��/ 4
==
��5 7
voterUpdateDto
��8 F
.
��F G
Email
��G L
&&
��M O
!
��P Q
	voterList
��Q Z
.
��Z [
	ElementAt
��[ d
(
��d e
i
��e f
)
��f g
.
��g h
	IsDeleted
��h q
)
��q r
{
�� 
throw
�� 
new
�� !$
DuplicateNameException
��" 8
(
��8 9
$str
��9 f
)
��f g
;
��g h
}
�� 
}
�� 
voter
�� 
.
�� 
DateUpdated
�� !
=
��" #
DateTimeOffset
��$ 2
.
��2 3
Now
��3 6
;
��6 7
_voterRepository
��  
.
��  !
Update
��! '
(
��' (
voter
��( -
)
��- .
;
��. /
await
�� 
_voterRepository
�� &
.
��& '
	SaveAsync
��' 0
(
��0 1
)
��1 2
;
��2 3
return
�� 
_mapper
�� 
.
�� 
Map
�� "
<
��" #
VoterResponseDto
��# 3
>
��3 4
(
��4 5
voterUpdateDto
��5 C
)
��C D
;
��D E
}
�� 
throw
�� 
new
�� '
InvalidOperationException
�� /
(
��/ 0
$str
��0 Z
)
��Z [
;
��[ \
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
VoterResponseDto
�� *
>
��* +
VoteToCandidate
��, ;
(
��; <
long
��< @
candidateId
��A L
,
��L M
long
��N R
voterId
��S Z
)
��Z [
{
�� 	
var
�� 
voter
�� 
=
�� 
await
�� 
_voterRepository
�� .
.
��. /
GetByIdAsync
��/ ;
(
��; <
voterId
��< C
)
��C D
;
��D E
if
�� 
(
�� 
voter
�� 
==
�� 
null
�� 
)
�� 
{
�� 
throw
�� 
new
�� "
KeyNotFoundException
�� .
(
��. /
$str
��/ M
)
��M N
;
��N O
}
�� 
if
�� 
(
�� 
voter
�� 
.
�� 
	IsDeleted
�� 
)
��  
{
�� 
throw
�� 
new
�� "
KeyNotFoundException
�� .
(
��. /
$str
��/ O
)
��O P
;
��P Q
}
�� 
if
�� 
(
�� 
!
�� 
voter
�� 
.
�� 
HasVoted
�� 
)
��  
{
�� 
voter
�� 
.
�� 
HasVoted
�� 
=
��  
true
��! %
;
��% &
}
�� 
else
�� 
{
�� 
throw
�� 
new
�� '
InvalidOperationException
�� 3
(
��3 4
$str
��4 W
)
��W X
;
��X Y
}
�� 
var
�� 
	candidate
�� 
=
�� 
await
�� !"
_candidateRepository
��" 6
.
��6 7
GetByIdAsync
��7 C
(
��C D
candidateId
��D O
)
��O P
;
��P Q
if
�� 
(
�� 
	candidate
�� 
==
�� 
null
�� !
)
��! "
{
�� 
throw
�� 
new
�� "
KeyNotFoundException
�� .
(
��. /
$str
��/ Q
)
��Q R
;
��R S
}
�� 
if
�� 
(
�� 
	candidate
�� 
.
�� 
	IsDeleted
�� #
)
��# $
{
�� 
throw
�� 
new
�� "
KeyNotFoundException
�� .
(
��. /
$str
��/ Q
)
��Q R
;
��R S
}
�� 
	candidate
�� 
.
�� 

TotalVotes
��  
+=
��! #
$num
��$ %
;
��% &
await
�� 
_voterRepository
�� "
.
��" #
	SaveAsync
��# ,
(
��, -
)
��- .
;
��. /
await
�� "
_candidateRepository
�� &
.
��& '
	SaveAsync
��' 0
(
��0 1
)
��1 2
;
��2 3
return
�� 
_mapper
�� 
.
�� 
Map
�� 
<
�� 
VoterResponseDto
�� /
>
��/ 0
(
��0 1
voter
��1 6
)
��6 7
;
��7 8
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
IEnumerable
�� %
<
��% &
Voter
��& +
>
��+ ,
>
��, -
GetAllVoters
��. :
(
��: ;
int
��; >

pageNumber
��? I
,
��I J
int
��K N
pageSize
��O W
,
��W X
bool
��Y ]
fetchAll
��^ f
)
��f g
{
�� 	
return
�� 
await
�� 
_voterRepository
�� )
.
��) *
GetAllAsync
��* 5
(
��5 6

pageNumber
��6 @
,
��@ A
pageSize
��B J
,
��J K
fetchAll
��L T
)
��T U
;
��U V
}
�� 	
public
�� 
Task
�� 
<
�� 
VoterResponseDto
�� $
>
��$ %
SearchVoter
��& 1
(
��1 2
string
��2 8
	voterName
��9 B
)
��B C
{
�� 	
if
�� 
(
�� 
	voterName
�� 
==
�� 
null
�� !
)
��! "
{
�� 
throw
�� 
new
�� '
InvalidOperationException
�� 3
(
��3 4
$str
��4 T
)
��T U
;
��U V
}
�� 
throw
�� 
new
�� %
NotImplementedException
�� -
(
��- .
)
��. /
;
��/ 0
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
IEnumerable
�� %
<
��% &
Voter
��& +
>
��+ ,
>
��, -
SearchVoterByName
��. ?
(
��? @
string
��@ F
	voterName
��G P
)
��P Q
{
�� 	
if
�� 
(
�� 
	voterName
�� 
==
�� 
null
�� !
)
��! "
{
�� 
throw
�� 
new
�� '
InvalidOperationException
�� 3
(
��3 4
$str
��4 K
)
��K L
;
��L M
}
�� 
var
�� 
query
�� 
=
�� 
$"
�� 
$str
�� 1
{
��1 2
	voterName
��2 ;
}
��; <
"
��< =
;
��= >
return
�� 
await
�� !
_applicationContext
�� ,
.
��, -
Voters
��- 3
.
��3 4

FromSqlRaw
��4 >
(
��> ?
query
��? D
)
��D E
.
��E F
ToListAsync
��F Q
(
��Q R
)
��R S
;
��S T
}
�� 	
}
�� 
}�� �c
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
candidateRepository	u �
,
� � 
ApplicationContext
� �
context
� �
)
� �
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
�� 

hasChanges
�� 
=
�� 
false
�� #
;
��# $
if
�� 
(
�� 
party
�� 
.
�� 
	PartyName
�� 
!=
��  "
updatePartyDto
��# 1
.
��1 2
	PartyName
��2 ;
)
��; <
{
�� 
party
�� 
.
�� 
	PartyName
�� 
=
��  !
updatePartyDto
��" 0
.
��0 1
	PartyName
��1 :
;
��: ;
party
�� 
.
�� 
	PartyName
�� 
.
��  
ToUpper
��  '
(
��' (
)
��( )
;
��) *

hasChanges
�� 
=
�� 
true
�� !
;
��! "
}
�� 
if
�� 
(
�� 

hasChanges
�� 
)
�� 
{
�� 
party
�� 
.
�� 
DateUpdated
�� !
=
��" #
DateTimeOffset
��$ 2
.
��2 3
Now
��3 6
;
��6 7
_partyRepository
��  
.
��  !
Update
��! '
(
��' (
party
��( -
)
��- .
;
��. /
await
�� 
_partyRepository
�� &
.
��& '
	SaveAsync
��' 0
(
��0 1
)
��1 2
;
��2 3
return
�� 
_mapper
�� 
.
�� 
Map
�� "
<
��" #
PartyResponseDto
��# 3
>
��3 4
(
��4 5
party
��5 :
)
��: ;
;
��; <
}
�� 
throw
�� 
new
�� '
InvalidOperationException
�� /
(
��/ 0
$str
��0 Z
)
��Z [
;
��[ \
}
�� 	
}
�� 
}�� ��
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
IGenericRepository	r �
<
� �
RefreshToken
� �
>
� �$
refreshTokenRepository
� �
,
� � 
ApplicationContext
� �
context
� �
)
� �
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
�� 	
SHA256
�� 
sha256
�� 
=
�� 
SHA256
�� "
.
��" #
Create
��# )
(
��) *
)
��* +
;
��+ ,
byte
�� 
[
�� 
]
�� 
inputHashBytes
�� !
=
��" #
sha256
��$ *
.
��* +
ComputeHash
��+ 6
(
��6 7
Encoding
��7 ?
.
��? @
UTF8
��@ D
.
��D E
GetBytes
��E M
(
��M N
password
��N V
)
��V W
)
��W X
;
��X Y
var
�� 
encryptedPassword
�� !
=
��" #
Convert
��$ +
.
��+ ,
ToBase64String
��, :
(
��: ;
inputHashBytes
��; I
)
��I J
;
��J K
if
�� 
(
�� 
encryptedPassword
�� !
==
��" $

dbPassword
��% /
)
��/ 0
{
�� 
return
�� 
true
�� 
;
�� 
}
�� 
else
�� 
{
�� 
return
�� 
false
�� 
;
�� 
}
�� 
}
�� 	
private
�� 
async
�� 
Task
�� 
<
�� 
string
�� !
>
��! "#
_generateRefreshToken
��# 8
(
��8 9
String
��9 ?
role
��@ D
,
��D E
Voter
��F K
?
��K L
voter
��M R
,
��R S
Admin
��T Y
?
��Y Z
admin
��[ `
)
��` a
{
�� 	
var
�� 
token
�� 
=
�� 
Convert
�� 
.
��  
ToBase64String
��  .
(
��. /#
RandomNumberGenerator
��/ D
.
��D E
GetBytes
��E M
(
��M N
$num
��N P
)
��P Q
)
��Q R
;
��R S
if
�� 
(
�� 
role
�� 
==
�� 
$str
�� 
)
��  
{
�� 
var
�� 
refreshTokenList
�� $
=
��% &
await
��' ,%
_refreshTokenRepository
��- D
.
��D E
GetAllAsync
��E P
(
��P Q
$num
��Q R
,
��R S
$num
��T U
,
��U V
true
��W [
)
��[ \
;
��\ ]
var
�� 
refreshToken
��  
=
��! "
refreshTokenList
��# 3
.
��3 4
FirstOrDefault
��4 B
(
��B C
x
��C D
=>
��E G
x
��H I
.
��I J
Voter
��J O
==
��P R
voter
��S X
)
��X Y
;
��Y Z
if
�� 
(
�� 
refreshToken
��  
==
��! #
null
��$ (
)
��( )
{
�� 
var
�� 
_refreshToken
�� %
=
��& '
new
��( +
RefreshToken
��, 8
(
��8 9
)
��9 :
{
�� 
Admin
�� 
=
�� 
null
��  $
,
��$ %
AdminId
�� 
=
��  !
null
��" &
,
��& '
Token
�� 
=
�� 
token
��  %
,
��% &
TokenExp
��  
=
��! "
DateTime
��# +
.
��+ ,
Now
��, /
.
��/ 0
AddDays
��0 7
(
��7 8
$num
��8 9
)
��9 :
,
��: ;
VoterId
�� 
=
��  !
voter
��" '
?
��' (
.
��( )
VoterId
��) 0
,
��0 1
Voter
�� 
=
�� 
voter
��  %
}
�� 
;
�� 
await
�� %
_refreshTokenRepository
�� 1
.
��1 2
CreateAsync
��2 =
(
��= >
_refreshToken
��> K
)
��K L
;
��L M
await
�� %
_refreshTokenRepository
�� 1
.
��1 2
	SaveAsync
��2 ;
(
��; <
)
��< =
;
��= >
}
�� 
else
�� 
{
�� 
refreshToken
��  
.
��  !
Token
��! &
=
��' (
token
��) .
;
��. /
refreshToken
��  
.
��  !
TokenExp
��! )
=
��* +
DateTime
��, 4
.
��4 5
Now
��5 8
.
��8 9
AddDays
��9 @
(
��@ A
$num
��A B
)
��B C
;
��C D
await
�� %
_refreshTokenRepository
�� 1
.
��1 2
	SaveAsync
��2 ;
(
��; <
)
��< =
;
��= >
}
�� 
}
�� 
if
�� 
(
�� 
role
�� 
==
�� 
$str
�� 
)
��  
{
�� 
var
�� 
refreshTokenList
�� $
=
��% &
await
��' ,%
_refreshTokenRepository
��- D
.
��D E
GetAllAsync
��E P
(
��P Q
$num
��Q R
,
��R S
$num
��T U
,
��U V
true
��W [
)
��[ \
;
��\ ]
var
�� 
refreshToken
��  
=
��! "
refreshTokenList
��# 3
.
��3 4
FirstOrDefault
��4 B
(
��B C
x
��C D
=>
��E G
x
��H I
.
��I J
Admin
��J O
==
��P R
admin
��S X
)
��X Y
;
��Y Z
if
�� 
(
�� 
refreshToken
��  
==
��! #
null
��$ (
)
��( )
{
�� 
var
�� 
_refreshToken
�� %
=
��& '
new
��( +
RefreshToken
��, 8
(
��8 9
)
��9 :
{
�� 
Admin
�� 
=
�� 
admin
��  %
,
��% &
AdminId
�� 
=
��  !
admin
��" '
?
��' (
.
��( )
AdminId
��) 0
,
��0 1
Token
�� 
=
�� 
token
��  %
,
��% &
TokenExp
��  
=
��! "
DateTime
��# +
.
��+ ,
Now
��, /
.
��/ 0
AddDays
��0 7
(
��7 8
$num
��8 9
)
��9 :
,
��: ;
VoterId
�� 
=
��  !
null
��" &
,
��& '
Voter
�� 
=
�� 
null
��  $
}
�� 
;
�� 
await
�� %
_refreshTokenRepository
�� 1
.
��1 2
CreateAsync
��2 =
(
��= >
_refreshToken
��> K
)
��K L
;
��L M
await
�� %
_refreshTokenRepository
�� 1
.
��1 2
	SaveAsync
��2 ;
(
��; <
)
��< =
;
��= >
}
�� 
else
�� 
{
�� 
refreshToken
��  
.
��  !
Token
��! &
=
��' (
token
��) .
;
��. /
refreshToken
��  
.
��  !
TokenExp
��! )
=
��* +
DateTime
��, 4
.
��4 5
Now
��5 8
.
��8 9
AddDays
��9 @
(
��@ A
$num
��A B
)
��B C
;
��C D
await
�� %
_refreshTokenRepository
�� 1
.
��1 2
	SaveAsync
��2 ;
(
��; <
)
��< =
;
��= >
}
�� 
}
�� 
return
�� 
token
�� 
;
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
LoginResponseDto
�� *
>
��* +)
GenerateJwtFromRefreshToken
��, G
(
��G H
string
��H N
refreshToken
��O [
)
��[ \
{
�� 	
var
�� 
refreshTokenList
��  
=
��! "
await
��# (%
_refreshTokenRepository
��) @
.
��@ A
GetAllAsync
��A L
(
��L M
$num
��M N
,
��N O
$num
��P Q
,
��Q R
true
��S W
)
��W X
;
��X Y
var
�� 
dbrefreshToken
�� 
=
��  
_context
��! )
.
��) *
RefreshTokens
��* 7
.
��7 8
Include
��8 ?
(
��? @
x
��@ A
=>
��B D
x
��E F
.
��F G
Voter
��G L
)
��L M
.
��M N
Include
��N U
(
��U V
x
��V W
=>
��X Z
x
��[ \
.
��\ ]
Admin
��] b
)
��b c
.
��c d
FirstOrDefault
��d r
(
��r s
x
��s t
=>
��u w
x
��x y
.
��y z
Token
��z 
==��� �
refreshToken��� �
)��� �
;��� �
var
�� 
loginDto
�� 
=
�� 
new
�� 
LoginDto
�� '
(
��' (
)
��( )
;
��) *
if
�� 
(
�� 
dbrefreshToken
�� 
==
�� !
null
��" &
)
��& '
{
�� 
throw
�� 
new
�� $
NullReferenceException
�� 0
(
��0 1
$str
��1 N
)
��N O
;
��O P
}
�� 
else
�� 
{
�� 
if
�� 
(
�� 
dbrefreshToken
�� "
.
��" #
VoterId
��# *
!=
��+ -
null
��. 2
)
��2 3
{
�� 
loginDto
�� 
.
�� 
Email
�� "
=
��# $
dbrefreshToken
��% 3
.
��3 4
Voter
��4 9
.
��9 :
Email
��: ?
;
��? @
loginDto
�� 
.
�� 
Password
�� %
=
��& '
dbrefreshToken
��( 6
.
��6 7
Voter
��7 <
.
��< =
Password
��= E
;
��E F
loginDto
�� 
.
�� 
Role
�� !
=
��" #
$str
��$ +
;
��+ ,
}
�� 
if
�� 
(
�� 
dbrefreshToken
�� "
.
��" #
AdminId
��# *
!=
��+ -
null
��. 2
)
��2 3
{
�� 
loginDto
�� 
.
�� 
Email
�� "
=
��# $
dbrefreshToken
��% 3
.
��3 4
Admin
��4 9
.
��9 :
Email
��: ?
;
��? @
loginDto
�� 
.
�� 
Password
�� %
=
��& '
dbrefreshToken
��( 6
.
��6 7
Admin
��7 <
.
��< =
Password
��= E
;
��E F
loginDto
�� 
.
�� 
Role
�� !
=
��" #
$str
��$ +
;
��+ ,
}
�� 
if
�� 
(
�� 
dbrefreshToken
�� "
.
��" #
TokenExp
��# +
<
��, -
DateTime
��. 6
.
��6 7
Now
��7 :
)
��: ;
{
�� 
throw
�� 
new
�� '
InvalidOperationException
�� 7
(
��7 8
$str
��8 S
)
��S T
;
��T U
}
�� 
else
�� 
{
�� 
var
�� 
jwt
�� 
=
�� 
_generateJwtToken
�� /
(
��/ 0
loginDto
��0 8
)
��8 9
;
��9 :
return
�� 
new
�� 
LoginResponseDto
�� /
(
��/ 0
)
��0 1
{
�� 
JwtToken
��  
=
��! "
jwt
��# &
,
��& '
RefreshToken
�� $
=
��% &
refreshToken
��' 3
,
��3 4
}
�� 
;
�� 
}
�� 
}
�� 
}
�� 	
}
�� 
}�� �i
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
�� 
.
�� 
	PartyName
�� #
=
��$ % 
candidateUpdateDto
��& 8
.
��8 9
	PartyName
��9 B
;
��B C

hasChanges
�� 
=
�� 
true
�� !
;
��! "
}
�� 
if
�� 
(
�� 

hasChanges
�� 
)
�� 
{
�� 
	candidate
�� 
.
�� 
DateUpdated
�� %
=
��& '
DateTimeOffset
��( 6
.
��6 7
Now
��7 :
;
��: ;"
_candidateRepository
�� $
.
��$ %
Update
��% +
(
��+ ,
	candidate
��, 5
)
��5 6
;
��6 7
await
�� "
_candidateRepository
�� *
.
��* +
	SaveAsync
��+ 4
(
��4 5
)
��5 6
;
��6 7
return
�� 
_mapper
�� 
.
�� 
Map
�� "
<
��" #"
CandidateResponseDto
��# 7
>
��7 8
(
��8 9 
candidateUpdateDto
��9 K
)
��K L
;
��L M
}
�� 
throw
�� 
new
�� '
InvalidOperationException
�� /
(
��/ 0
$str
��0 Z
)
��Z [
;
��[ \
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
IEnumerable
�� %
<
��% &
	Candidate
��& /
>
��/ 0
>
��0 1
GetAllCandidate
��2 A
(
��A B
int
��B E

pageNumber
��F P
,
��P Q
int
��R U
pageSize
��V ^
,
��^ _
bool
��` d
fetchAll
��e m
)
��m n
{
�� 	
return
�� 
await
�� "
_candidateRepository
�� -
.
��- .
GetAllAsync
��. 9
(
��9 :

pageNumber
��: D
,
��D E
pageSize
��F N
,
��N O
fetchAll
��P X
)
��X Y
;
��Y Z
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
IEnumerable
�� %
<
��% &
	Candidate
��& /
>
��/ 0
>
��0 1$
GeetTopThreeCandidates
��2 H
(
��H I
)
��I J
{
�� 	
var
�� 
candidateList
�� 
=
�� 
await
��  %"
_candidateRepository
��& :
.
��: ;
GetAllAsync
��; F
(
��F G
$num
��G H
,
��H I
$num
��J K
,
��K L
true
��M Q
)
��Q R
;
��R S
if
�� 
(
�� 
candidateList
�� 
==
��  
null
��! %
)
��% &
{
�� 
return
�� 

Enumerable
�� !
.
��! "
Empty
��" '
<
��' (
	Candidate
��( 1
>
��1 2
(
��2 3
)
��3 4
;
��4 5
}
�� 
else
�� 
{
�� 
var
�� #
topThreeCandidateList
�� )
=
��* +
await
��, 1
_context
��2 :
.
��: ;

Candidates
��; E
.
��E F

FromSqlRaw
��F P
(
��P Q
$str
��Q m
)
��m n
.
��n o
ToListAsync
��o z
(
��z {
)
��{ |
;
��| }
return
�� #
topThreeCandidateList
�� ,
;
��, -
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
IEnumerable
�� %
<
��% &
	Candidate
��& /
>
��/ 0
>
��0 1#
SearchByCandidateName
��2 G
(
��G H
string
��H N
candidateName
��O \
)
��\ ]
{
�� 	
if
�� 
(
�� 
candidateName
�� 
==
��  
null
��! %
)
��% &
{
�� 
throw
�� 
new
�� '
InvalidOperationException
�� 3
(
��3 4
$str
��4 K
)
��K L
;
��L M
}
�� 
var
�� 
query
�� 
=
�� 
$"
�� 
$str
�� 5
{
��5 6
candidateName
��6 C
}
��C D
"
��D E
;
��E F
return
�� 
await
�� 
_context
�� !
.
��! "

Candidates
��" ,
.
��, -

FromSqlRaw
��- 7
(
��7 8
query
��8 =
)
��= >
.
��> ?
ToListAsync
��? J
(
��J K
)
��K L
;
��L M
}
�� 	
}
�� 
}�� �-
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
}CC �
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
} �
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
} �
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
} �
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
} �
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
} �	
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
}		 �
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
} �
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