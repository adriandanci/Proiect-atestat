SET TALK OFF
CLOSE ALL
CLEAR
* deschidere tabela ..
USE servicii 
* definire ferestre
DEFINE WINDOW principal FROM 1,1 TO 25, 100 TITLE "Principal"
* definire meniu principal
DEFINE MENU meniu
DEFINE PAD cerinta1 OF meniu PROMPT "Cerinta1" MESSAGE "1.	Adaugati �nca 10% la valoarea serviciilor unei agentii date."
DEFINE PAD cerinta2 OF meniu PROMPT "Cerinta2" MESSAGE "2.	Fiind dat numele unui client determinati valoarea totala a serviciilor solicitate"
DEFINE PAD cerinta3 OF meniu PROMPT "Cerinta3" MESSAGE "3.	Afisati �nregistrarile grupate pe agentii �n ordine cronologica."
DEFINE PAD cerinta4 OF meniu PROMPT "Cerinta4" MESSAGE "4.	Fiind dat numele unui client determinati serviciile solicitate anul acesta."
DEFINE PAD cerinta5 OF meniu PROMPT "Cerinta5" MESSAGE "5.	Afisati serviciile solicitate astazi �n ordine descrescatoare a valorilor."
DEFINE PAD cerinta6 OF meniu PROMPT "Cerinta6" MESSAGE "6.	Care este denumirea serviciului cu cea mai mare valoare?"
DEFINE PAD cerinta7 OF meniu PROMPT "Cerinta7" MESSAGE "7.	Fiind data o anumita agentie, determinati valoarea medie a serviciilor oferite."
DEFINE PAD cerinta8 OF meniu PROMPT "Cerinta8" MESSAGE "8.	Afisati �nregistrarile grupate pe clienti, iar pentru acelasi client �n ordine descrescatoare a valorii serviciilor."
DEFINE PAD cerinta9 OF meniu PROMPT "Cerinta9" MESSAGE "9.	Fiind data denumirea unui anumit serviciu, determinati de c�te ori a fost solicitat serviciul respectiv."
DEFINE PAD iesire OF meniu PROMPT "Iesire" MESSAGE "Iesire din program"
*definire actiuni meniu
*la selectarea butonului cerinta1 se lanseaza in executie procedura pcerinta1
ON SELECTION PAD cerinta1 OF meniu DO pcerinta1
*la selectarea butonului cerinta2 se lanseaza in executie procedura pcerinta2
ON SELECTION PAD cerinta2 OF meniu DO pcerinta2
*la selectarea butonului cerinta3 se lanseaza in executie procedura pcerinta3
ON SELECTION PAD cerinta3 OF meniu DO pcerinta3
ON SELECTION PAD cerinta4 OF meniu DO pcerinta4
ON SELECTION PAD cerinta5 OF meniu DO pcerinta5
ON SELECTION PAD cerinta6 OF meniu DO pcerinta6
ON SELECTION PAD cerinta7 OF meniu DO pcerinta7
ON SELECTION PAD cerinta8 OF meniu DO pcerinta8
ON SELECTION PAD cerinta9 OF meniu DO pcerinta9
*iesirea din program inseamna dezactivarea meniului
ON SELECTION PAD iesire OF meniu DEACT MENU meniu

*programul principal
ACTIVATE WINDOW principal
ACTIVATE MENU meniu
DEACTIVATE WINDOW principal
RETURN

*proceduri
PROCEDURE pcerinta1
*aici se scrie codul pentru rezolvarea cerintei 1 
CLOSE ALL
SET TALK OFF 
SET DATE DMY
CLEAR
USE servicii
ag=SPACE(20)
@5,2 say "Agentia: " get ag
READ 
replace valoare WITH valoare*110/100 FOR ag=agentie
list

RETURN

PROCEDURE pcerinta2
*aici se scrie codul pentru rezolvarea cerintei 2
CLOSE ALL
SET TALK OFF 
SET DATE DMY
CLEAR
USE servicii
nu=SPACE(15)
@5,2 say "Clientul: " get nu
READ
CALCULATE SUM(valoare) FOR client=nu TO x
@6,2 say x

RETURN

PROCEDURE pcerinta3
*aici se scrie codul pentru rezolvarea cerintei 3
CLOSE ALL
SET TALK OFF 
SET DATE DMY
CLEAR
USE servicii
SORT TO listac3 ON agentie,datasol
USE listac3
? ' '
? ' '
? ' '
GO TOP 
ag=agentie
?ag
DO WHILE !EOF()
IF ag!=agentie
ag=agentie
?ag
ENDIF
? ' ',client,datasol
SKIP
ENDDO

RETURN

PROCEDURE pcerinta4
*aici se scrie codul pentru rezolvarea cerintei 3
CLOSE ALL
SET TALK OFF 
CLEAR
USE servicii
nu=SPACE(15)
@5,2 say "Clientul: " get nu
READ
LIST denumire,datasol for client=nu AND YEAR(datasol)=YEAR(DATE())

RETURN

PROCEDURE pcerinta5
*aici se scrie codul pentru rezolvarea cerintei 5
CLOSE ALL
SET TALK OFF
CLEAR
USE servicii
SORT TO listac5 ON valoare /d
USE listac5
LIST client,denumire,valoare,datasol for datasol=DATE()

RETURN

PROCEDURE pcerinta6
*aici se scrie codul pentru rezolvarea cerintei 3
CLOSE ALL
SET TALK OFF
CLEAR
USE servicii
CALCULATE MAX(valoare) TO mx
LIST denumire,valoare for valoare=mx 

RETURN

PROCEDURE pcerinta7
*aici se scrie codul pentru rezolvarea cerintei 3
CLOSE ALL
SET TALK OFF
CLEAR
USE servicii
ag=SPACE(20)
@5,2 say "Agentia: " get ag
READ
CALCULATE CNT(1) FOR agentie=ag TO k
CALCULATE SUM(valoare) FOR agentie=ag TO s
@6,2 say s/k

RETURN

PROCEDURE pcerinta8
*aici se scrie codul pentru rezolvarea cerintei 3
CLOSE ALL
SET TALK OFF
CLEAR
USE servicii
SORT TO listac8 ON client,valoare /d
USE listac8
? ' '
? ' '
? ' '
GO TOP 
cl=client
?cl
DO WHILE !EOF()
IF cl!=client
cl=client
?cl
ENDIF
? ' ',agentie,denumire,valoare
SKIP
ENDDO

RETURN

PROCEDURE pcerinta9
*aici se scrie codul pentru rezolvarea cerintei 3
CLOSE ALL
SET TALK OFF 
SET DATE DMY
CLEAR
USE servicii
se=SPACE(30)
@5,2 say "Serviciul: " get se
READ 
CALCULATE CNT(1) FOR denumire=se TO k2
@6,2 say k2

RETURN

