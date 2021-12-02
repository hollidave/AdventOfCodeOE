 
DEFINE VARIABLE cMovement        AS CHARACTER NO-UNDO. 
 
DEFINE VARIABLE iDirection AS INTEGER NO-UNDO EXTENT 2. 
DEFINE VARIABLE iAim AS INT64 NO-UNDO . 
DEFINE VARIABLE iMoves AS INTEGER NO-UNDO. 

DEF STREAM stFileLoad.

INPUT STREAM stFileLoad FROM VALUE("H:\Advent\Day2.txt").  

REPEAT:       
    IMPORT STREAM stFileLoad DELIMITER " " cMovement iMoves. 

    ASSIGN cMovement = TRIM(cMovement).

    CASE cMovement:
        WHEN "forward" THEN
            ASSIGN iDirection[1] = iDirection[1] + iMoves
                   iDirection[2] = iDirection[2] + (iAim * iMoves).
        WHEN "up" THEN
            ASSIGN iAim = iAim - iMoves.
        WHEN "down" THEN
            ASSIGN iAim = iAim + iMoves. 


    END CASE. 

END. 

MESSAGE iDirection[1] SKIP 
        iDirection[2] SKIP 
    iDirection[1] * iDirection[2] 
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
