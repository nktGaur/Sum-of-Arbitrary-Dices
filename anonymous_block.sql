SET SERVEROUTPUT ON
ACCEPT Side1 NUMBER PROMPT 'Enter number of sides in First Dice : ';
ACCEPT Side2 NUMBER PROMPT 'Enter number of sides in Second Dice : ';

DECLARE
side_dice1 NUMBER :=&Side1;
side_dice2 NUMBER :=&Side2;
var_aat_dice aat_dice := aat_dice();

PROCEDURE populate_nt (sides1 IN NUMBER, sides2 IN NUMBER)
IS
tot_comb NUMBER;
i NUMBER := 1; 
j NUMBER := 0;
ind NUMBER :=1;
v_sql VARCHAR2(4000);

BEGIN
tot_comb := sides1*sides2;
var_aat_dice.extend(tot_comb);
While i<= sides1 LOOP
    j:=1;
    While j<= sides2 LOOP
        var_aat_dice(ind) := i+j;
        ind:=ind+1;
        j:=j+1;
    END LOOP;
    i:=i+1;
END LOOP;
EXCEPTION WHEN OTHERS THEN 
DBMS_OUTPUT.PUT_LINE(SQLCODE||'-'||SQLERRM);
END populate_nt;

PROCEDURE calculate_nt
IS
BEGIN
DBMS_OUTPUT.PUT_LINE ('The most probable sum of two dices :');
FOR rec in (
WITH TEMP1 AS (SELECT COLUMN_VALUE ELEMENTS FROM TABLE(var_aat_dice) ORDER BY ELEMENTS),
     TEMP2 AS (SELECT ELEMENTS, COUNT(*) AS CNT FROM TEMP1 GROUP BY ELEMENTS)
     SELECT ELEMENTS FROM TEMP2 WHERE CNT = (SELECT MAX(CNT) FROM TEMP2) ORDER BY ELEMENTS)
 LOOP
    DBMS_OUTPUT.PUT_LINE(rec.elements);
 END LOOP;
 END calculate_nt;
  
BEGIN
  --create_tab;  
  populate_nt(side_dice1, side_dice2);  
  calculate_nt;
END;
/
