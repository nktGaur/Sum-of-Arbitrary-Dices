SET SERVEROUTPUT ON
ACCEPT Dice1 NUMBER PROMPT 'Enter number of sides in First Dice : ';
ACCEPT Dice2 NUMBER PROMPT 'Enter number of sides in Second Dice : ';

WITH dice1 AS (SELECT level "A" FROM DUAL CONNECT BY LEVEL <= &Dice1),
     dice2 AS (SELECT level "B" FROM DUAL CONNECT BY LEVEL <= &Dice2),
     sum_cnt AS (SELECT C, COUNT(*) "CNT" FROM (SELECT A+B "C" from  dice1 CROSS JOIN dice2) GROUP BY C)
SELECT C FROM sum_cnt WHERE CNT = (SELECT MAX(CNT) FROM sum_cnt) ORDER BY C;
/
