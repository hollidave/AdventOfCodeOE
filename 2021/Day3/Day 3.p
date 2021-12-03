 
DEFINE VARIABLE nWinner          AS DECIMAL NO-UNDO EXTENT 12. 
DEFINE VARIABLE iMost           AS integer NO-UNDO EXTENT 12. 
DEFINE VARIABLE iLeast          AS integer NO-UNDO EXTENT 12. 
DEFINE VARIABLE cAscii           AS CHAR NO-UNDO. 
DEFINE VARIABLE iAnswer           AS INTEGER NO-UNDO EXTENT 2. 
DEFINE VARIABLE iTotal           AS INTEGER NO-UNDO. 
DEFINE VARIABLE iCount           AS INTEGER NO-UNDO.  

DEF STREAM stFileLoad.

INPUT STREAM stFileLoad FROM VALUE("H:\Advent\Day3.txt").  

REPEAT:       
    IMPORT STREAM stFileLoad  cAscii. 
    
    DO iCount = 1 TO 12: 
        nWinner[iCount] = nWinner[iCount] + INTEGER(SUBSTRING(cAscii,iCount,1)).
    END.
    iTotal = iTotal + 1.
END.
INPUT STREAM stFileLoad CLOSE.   

    DO iCount = 1 to 12:  
        nWinner[iCount] = nWinner[iCount] / iTotal.
        IF nWinner[iCount] < 0.5 THEN 
		    ASSIGN iMost[iCount] = 0
                   iLeast[iCount] = 1.
        ELSE 
	        ASSIGN iMost[iCount] = 1
                   iLeast[iCount] = 0.
           
        iAnswer[1] = iAnswer[1] + (imost[iCount] * EXP(2,12 - iCount)).
        iAnswer[2] = iAnswer[2] + (iLeast[iCount] * EXP(2,12 - iCount)).
        MESSAGE iAnswer[1] SKIP iAnswer[2]
            VIEW-AS ALERT-BOX INFO BUTTONS OK.

    END.

MESSAGE iAnswer[1] SKIP iAnswer[2] SKIP iAnswer[1] * iAnswer[2]
    
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

