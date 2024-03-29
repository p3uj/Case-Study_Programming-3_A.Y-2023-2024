       IDENTIFICATION DIVISION.
       PROGRAM-ID. NUMBER1. 
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OUTFILE ASSIGN TO "NUM1.DAT".
       DATA DIVISION.
       FILE SECTION.
       FD  OUTFILE
           LABEL RECORDS ARE STANDARD 
           DATA RECORD IS COURSE-REC.
       01 COURSE-REC PIC X(80).

       WORKING-STORAGE SECTION.
       01  I PIC 9 VALUE ZERO.
       01  J PIC 9 VALUE ZERO.
       01  YEAR-LEVEL.
           02 YR-LEVEL OCCURS 4 TIMES PIC X(9).
       01  CCIS.
           02 YEAR OCCURS 4 TIMES.
               03 NO-STUD OCCURS 2 TIMES PIC 99.
       01  HDG-0.
           02 FILLER PIC X(13) VALUE SPACES.
           02 FILLER PIC X(24) VALUE "COLLEGE OF COMPUTER AND ".
           02 FILLER PIC X(19) VALUE "INFORMATION SCIENCE".
       01  HDG-1.
           02 FILLER PIC X(25) VALUE SPACES.
           02 FILLER PIC X(18) VALUE "STUDENT POPULATION".
       01  HDG-2.
           02 FILLER PIC X(5) VALUE SPACES.
           02 FILLER PIC X(4) VALUE "YEAR".
           02 FILLER PIC X(8) VALUE SPACES.
           02 FILLER PIC X(4) VALUE "BSIT".
           02 FILLER PIC X(9) VALUE SPACES.
           02 FILLER PIC X(4) VALUE "BSCS".
           02 FILLER PIC X(7) VALUE SPACES.
           02 FILLER PIC X(12) VALUE "TOTAL NUMBER".
       01  HDG-3.
           02 FILLER PIC X(41) VALUE SPACES.
           02 FILLER PIC X(12) VALUE "OF STUDENTS".
       01  HDG-4.
           02 FILLER PIC X(5) VALUE SPACES.
           02 YEAR-LEVEL-OUT PIC X(9).
           02 ITCS-OUT OCCURS 2 TIMES.
               03 FILLER PIC X(6) VALUE SPACES.
               03 ITCSOUT PIC ZZ.
               03 FILLER PIC X(6) VALUE SPACES.
           02 TOT-STUD-OUT PIC Z999.
       01 HDG-5.
           02 FILLER PIC X(5) VALUE SPACES.
           02 FILLER PIC X(5) VALUE "TOTAL".
           02 FILLER PIC X(6) VALUE SPACES.
           02 TOT-BSIT-OUT PIC Z999.
           02 FILLER PIC X(8) VALUE SPACES.
           02 TOT-BSCS-OUT PIC Z999.
           02 FILLER PIC X(15) VALUE SPACES.
           02 TOT-ALL-OUT PIC Z999.
       01 TOT-BSIT PIC 9999.
       01 TOT-BSCS PIC 9999.
       01 TOT-STUD PIC 9999.
       01 TOT-ALL PIC 9999.
       01 L PIC 9 VALUE ZERO.
       01 KORS PIC X(4) VALUE SPACES.
       01 YEARLEVEL PIC X(10) VALUE SPACES.
      
       SCREEN SECTION.
       01  SCRN.
           02 BLANK SCREEN.

       PROCEDURE DIVISION.
           OPEN OUTPUT OUTFILE. 
           PERFORM HDG-RTN.
           PERFORM PROCESS-RTN.
           PERFORM FIN-RTN.
       HDG-RTN.
           WRITE COURSE-REC FROM HDG-0 BEFORE 1 LINE.
           WRITE COURSE-REC FROM HDG-1 BEFORE 1 LINE.
           WRITE COURSE-REC FROM HDG-2 AFTER 2 LINES.
           WRITE COURSE-REC FROM HDG-3 AFTER 1 LINE.
           MOVE SPACES TO COURSE-REC.
           WRITE COURSE-REC AFTER 2 LINES.

       PROCESS-RTN.
           DISPLAY SCRN.
           DISPLAY "ENTER NUMBER OF STUDENTS FOR BSCS AND BSIT:" 
           LINE 5 COLUMN 5.
           MOVE 6 TO L. 
           PERFORM YR-RTN VARYING I FROM 1 BY 1 UNTIL I > 4.
           WRITE COURSE-REC FROM HDG-5 AFTER 1 LINE.

       YR-RTN.
           DISPLAY "ENTER STUDENT YEAR LEVEL:"
               LINE 4 COLUMN 5.
           DISPLAY "ENTER NUMBER OF STUDENTS FOR BSCS AND BSIT:"
               LINE 5 COLUMN 5.
           ACCEPT YEAR-LEVEL LINE 4 COLUMN 45.
           MOVE YEAR-LEVEL TO YEAR-LEVEL-OUT.
           PERFORM IN-RTN VARYING J FROM 1 BY 1 UNTIL J > 2.

       IN-RTN.
           DISPLAY "ENTER NUMBER OF STUDENTS FOR: " LINE L COLUMN 5. 
           IF J = 1 
               MOVE "BSIT" TO KORS. 
           IF J = 2 
               MOVE "BSCS" TO KORS. 
           DISPLAY KORS LINE L COLUMN 35. 
           DISPLAY YEAR-LEVEL-OUT LINE L COLUMN 39.
           DISPLAY ":" LINE L COLUMN 48.
           ACCEPT NO-STUD (I, J) LINE L COLUMN 55.
           MOVE NO-STUD (I, J) TO ITCSOUT (J).
           COMPUTE TOT-STUD = TOT-STUD + NO-STUD (I, J).
           MOVE TOT-STUD TO TOT-STUD-OUT.
           IF J = 1
               PERFORM IT-RTN.
           IF J = 2
               PERFORM OUT-RTN.
           ADD 1 TO L.

       IT-RTN.
           COMPUTE TOT-BSIT = TOT-BSIT + NO-STUD (I, J).
           IF I = 4
               MOVE TOT-BSIT TO TOT-BSIT-OUT.

       BSCS-RTN.
           COMPUTE TOT-BSCS = TOT-BSCS + NO-STUD (I, J).
           IF I = 4
               MOVE TOT-BSCS TO TOT-BSCS-OUT.

       ALLSTUD-RTN.
           COMPUTE TOT-ALL = TOT-BSIT + TOT-BSCS.
           MOVE TOT-ALL TO TOT-ALL-OUT.

       OUT-RTN.
           PERFORM BSCS-RTN.
           PERFORM ALLSTUD-RTN.
           WRITE COURSE-REC FROM HDG-4.
           MOVE 5 TO L.
           MOVE 0 TO YEAR-LEVEL.
           MOVE 0 TO NO-STUD (I, J).
           MOVE 0 TO TOT-STUD.
           DISPLAY SCRN.

       FIN-RTN.
           CLOSE OUTFILE.
           STOP RUN.