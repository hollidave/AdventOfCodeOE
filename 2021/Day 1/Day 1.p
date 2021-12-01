DEFINE VARIABLE iPrevTotal    AS INTEGER NO-UNDO.
DEFINE VARIABLE iCurrentTotal AS INTEGER NO-UNDO.
DEFINE VARIABLE iCurrent  AS INTEGER NO-UNDO.

DEFINE VARIABLE iValue        AS INTEGER NO-UNDO EXTENT 4.
DEFINE VARIABLE iPosition        AS INTEGER NO-UNDO.

DEFINE VARIABLE iCount AS INTEGER NO-UNDO.
 
DEFINE VARIABLE iAnswer AS INTEGER NO-UNDO.
DEFINE TEMP-TABLE ttTotal NO-UNDO
    FIELD iCount AS INTEGER 
    FIELD iValue AS INTEGER
INDEX idxCount iCount.

DEFIN BUFFER bttTotal FOR ttTotal.

DEF STREAM stFileLoad.

INPUT STREAM stFileLoad FROM VALUE("H:\Advent\Day1.csv").  

REPEAT:       
    IMPORT STREAM stFileLoad DELIMITER "," iCurrent.
                    
     

    iCount = iCount + 1.  
 
    CREATE ttTotal.
    ASSIGN ttTotal.iCount = iCount.
           ttTotal.iValue = iCurrent. 


END.
INPUT STREAM stFileLoad CLOSE.  

FOR EACH ttTotal:
    IF ttTotal.iCount < 4 THEN
        NEXT.

    ASSIGN iCurrentTotal = 0
           iPrevTotal = 0.

    DO iPosition = ttTotal.iCount TO ttTotal.iCount - 2 BY -1:
        FIND bttTotal WHERE bttTotal.iCount = iPosition.
        ASSIGN iCurrentTotal = iCurrentTotal + bttTotal.iValue.
    END. 
    DO iPosition = ttTotal.iCount - 1 TO ttTotal.iCount - 3 BY -1:
        FIND bttTotal WHERE bttTotal.iCount = iPosition.
        ASSIGN iPrevTotal = iPrevTotal + bttTotal.iValue. 
    END.
    IF iCurrentTotal > iPrevTotal THEN
        iAnswer = iAnswer + 1.

    //DISPLAY iCurrentTotal iPrevTotal.
END.

MESSAGE iAnswer
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
