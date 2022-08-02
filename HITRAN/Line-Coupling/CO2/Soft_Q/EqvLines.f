      Subroutine EqvLines(iBand,nLineC)
C*********************************************************************
C "EqvLines": compute EQuiValent LINES
C ..........................................................
C         .     Subroutine to Compute the 'Intensities'    .
C         .     and 'Positions+Widths' of the Equivalent   .
C         .     Lines. A Decomposition of the OpR+iOPI     .
C         .     Operator is made under the form PDP-1      .
C         .   where P is the operator of the EigenVectors  .
C         .        and D contains the EigenValues.         .
C         ..................................................
C
C Input/Output Arguments of Routine
C ---------------------------------
C          iBand : Number of the Current band Treated (Input)
C         nLineC : Number of lines of current band (Input).
C
C Other important Input Quantities (through Common Statements)
C --------------------------------
C          PopuT : Populations of the Lower Levels of the Lines
C                  at Temperature Temp
C           Dipo : Dipole transition Moments of the Lines
C                  (Cm/Molecule**0.5)
C            OpR : Diagonal Operator Whose elements are the Line
C                  Positions (Real Part of the L+iPW operator, Cm-1)
C            OpI : Operator whose Elements are those of the relaxation 
C                  operator at the Considered Temperature and Pressure
C                  (Imaginary Part of the L+iPW operator, in Cm-1)
C
C Other important Output Quantities (through Common Statements)
C ---------------------------------
C            SSR : Real Part of the Intensities of the Equivalent Lines
C                  (Cm/Molecule)
C            SSI : Imaginary Part of the Intensities of the Equivalent
C                  Lines (Cm/Molecule)
C          AlphR : Positions of the Equivalent Lines (Cm-1)
C          AlphI : HalfWidths of the Equivalent Lines (Cm-1)
C
C Accessed Files:  NONE
C --------------
C
C Called Routines: Matrix Diagonalization and Inversion Routine
C ---------------  which are, according to the Library Used
C       "F02AKF" and "F04ADF" for the NAG Library
C       "DEVCCG" and "DLINCG" for the IMSL Library
C       "EigenC and "InvMat" for the LPMA (our own) Library
C
C TO CHANGE LIBRARY : This SubRoutine is now set to run (be linked)
C -----------------   with the NAG Library. To change, do the
C                     following:
C        - FIRST INSERT COMMENTARY CHARACTER (C) in the first column
C         of the lines situated inbetween the "1000   Continue" and 
C         "1001   Continue" lines as well as between the
C         "1100  Continue" and "1101   Continue" lines.
C        - TO SWITCH to the IMSL library, remove the commentary
C          Character in the first column of the lines situated in-
C          between the "2000   Continue" and "2001   Continue" lines
C          as well as between "2100   Continue" and "2101   Continue"
C        - TO SWITCH to LPMA (our own), remove the commentary
C          Character in the first column of the lines situated in-
C          between the "3000   Continue" and "3001   Continue" lines
C          as well as between "3100   Continue" and "3101   Continue"
C        - ALSO REMOVE AND ADD COMMENTARY characters in the places
C          indicated in the dimension statements
C                    
C*********************************************************************
C
      Implicit None
      Integer nBmx,nLmx,iFail
      Integer iBand,nLineC
      Integer iLine,iLineP
         Double Precision PopuT,Dipo,OpR,OpI
         Double Precision SSR,SSI,AlphR,AlphI
         Double Precision EigVlR,EigVlI
      Double Complex z,zOne,zZero
      Double Complex zSum,zVec,zVecM1
C Max Number of Bands and of Lines per Band
      Parameter (nBmx=30,nLmx=120)
C
C Data of the Q Lines at (Temp,Pressure) 
      Common/PopuT/PopuT(nLmx)
      Common/DipolT/Dipo(nLmx,nBmx) 
      Common/DiagnR/OpR(nLmx,nLmx)
      Common/DiagnI/OpI(nLmx,nLmx)
C Intensities and Positions+Widths of "Equivalent" Lines
      Common/FicLSR/SSR(nLmx)
      Common/FicLSI/SSI(nLmx)
      Common/FicLPR/AlphR(nLmx)
      Common/FicLPI/AlphI(nLmx)
C Local Arrays for Treatment reauired by all libraries
      Dimension zSum(nLmx),zVec(nLmx,nLmx),zVecM1(nLmx,nLmx)
      Dimension EigVlR(nLmx),EigVlI(nLmx)
C
C-----------
C IF YOU CHANGE LIBRARY, commentary characters should be removed
C and added in the Dimension statements below
C-----------
C Arrays Specific to the NAG library
      Integer Intger
      Double Complex zUnit
      Double Precision WkSpce,EigVcR,EigVcI
      Dimension zUnit(nLmx,nLmx),WkSpce(nLmx),Intger(nLmx)
      Dimension EigVcR(nLmx,nLmx),EigVcI(nLmx,nLmx)
C Arrays Specific to the IMSL library
C      Double Complex zOp,zVal
C      Dimension zOp(nLmx,nLmx),zVal(nLmx)
C Specific to the LPMA library
C      Double Complex zOp,zVal,zWrk
C      Dimension zOp(nLmx,nLmx),zVal(nLmx),zWrk(nLmx)
C
C----------
C
      zZero=DCMPLX(0.d0,0.d0)
      zOne=DCMPLX(1.d0,0.d0)
C
C Diagonalize the (OpR+iOpI) Operator
C
C From 1000-Continue to 1001-Continue for NAG Library      
C From 2000-Continue to 2001-Continue for IMSL Library      
C From 3000-Continue to 3001-Continue for LPMA (our own) Library
C
C----
C Begin diagonalization with the NAG library
 1000 Continue
      iFail=1
      Call F02AKF(OpR,nLmx,OpI,nLmx,nLineC
     ,             ,EigVlR,EigVlI
     ,             ,EigVcR,nLmx,EigVcI,nLmx
     ,             ,Intger,iFail)
           If( iFail.NE.0 )Then
           Write(*,500)'F02AKF'
           Stop
           EndIf
      do 1 iLine=1,nLineC
      do 1 iLineP=1,nLineC
      zVec(iLineP,iLine)=DCMPLX( EigVcR(iLineP,iLine)
     ,                          ,EigVcI(iLineP,iLine) )
 1    Continue
 1001 Continue
C End diagonalization with the NAG library
C----
C 
C----
C Begin diagonalization with the IMSL library
 2000 Continue
C      Do 5 iLine=1,nLineC
C      Do 5 iLineP=1,nLineC
C      zOp(iLine,iLineP)=DCMPLX(OpR(iLine,iLineP),OpI(iLine,iLineP))
C 5    Continue
C      Call DEVCCG(nLineC,zOp,nLmx,zVal,zVec,nLmx)
C      Do 6 iLine=1,nLineC
C      EigVlR(iLine)=DREAL(zVal(iLine))
C      EigVlI(iLine)=DIMAG(zVal(iLine))
C 6    Continue
 2001 Continue
C End diagonalization with the IMSL library
C----
C     
C----
C Begin diagonalization with the LPMA library
 3000 Continue
C     Do 5 iLine=1,nLineC
C     Do 5 iLineP=1,nLineC
C     zOp(iLine,iLineP)=DCMPLX(OpR(iLine,iLineP),OpI(iLine,iLineP))
C5    Continue
C     Call EigenC(nLineC,nLmx,zOp,zVal,zVec,zWrk,iFail)
C          If( iFail.NE.0 )Then
C          Write(*,500)'EigenC'
C          Stop
C          EndIf
C     Do 6 iLine=1,nLineC
C     EigVlR(iLine)=DREAL(zVal(iLine))
C     EigVlI(iLine)=DIMAG(zVal(iLine))
C6    Continue
 3001 Continue
C End diagonalization with the LPMA library
C----
C     
C     
      Do 3 iLine=1,nLineC
      z=zZero
      Do 4 iLineP=1,nLineC
      Z=Z+Dipo(iLineP,iBand)*zVec(iLineP,iLine)
 4    Continue
      zSum(iLine)=z
 3    Continue
C
C
C
C Invert the zVec Operator
C
C From 1100-Continue to 1101-Continue for NAG Library      
C From 2100-Continue to 2101-Continue for IMSL Library      
C From 3100-Continue to 3101-Continue for LPMA (our own) Library
C
C----
C Begin inversion with the NAG library
 1100 Continue
      Do 5 iLine=1,nLineC
      z=zZero
      Do 6 iLineP=1,nLineC
      zUnit(iLine,iLineP)=zZero
 6    Continue
      zUnit(iLine,iLine)=zOne
 5    Continue
      iFail=1
      Call F04ADF(zVec,nLmx,zUnit,nLmx,nLineC
     ,            ,nLineC,zVecM1,nLmx,WkSpce,iFail)
           If( iFail.NE.0 )Then
           Write(*,500)'F04ADF'
           Stop
           EndIf
 1101 Continue
C End inversion with the NAG library
C----
C Begin inversion with the IMSL library
 2100 Continue
C      Call DLINCG(nLineC,zVec,nLmx,zVecM1,nLmx)
 2101 Continue
C End inversion with the IMSL library
C----
C Begin inversion with the LPMA library
 3100 Continue
C     iFail=0
C     Call InvMat(zVec,zVecM1,nLmx,nLineC,iFail)
C          If( iFail.NE.0 )Then
C          Write(*,501)'InvMat'
C          Stop
C          EndIf
 3101 Continue
C End inversion with the LPMA library
C----
C
      Do 7 iLine=1,nLineC
      z=zZero
      Do 8 iLineP=1,nLineC
      Z=Z+PopuT(iLineP)*Dipo(iLineP,iBand)*zVecM1(iLine,iLineP)
 8    Continue
      zSum(iLine)=zSum(iLine)*z
 7    Continue
C      
      Do 9 iLine=1,nLineC
      SSR(iLine)=DREAL(zSum(iLine))
      SSI(iLine)=DIMAG(zSum(iLine))
      AlphR(iLine)=EigVlR(iLine)
      AlphI(iLine)=EigVlI(iLine)
 9    Continue
C 
 500  Format(1x,'************ PROBLEM !!!! ******************',
     /       /,1x,'The Diagonalization of Operator "OpI+iOpR"',
     /       /,1x,'By  Routine ',A6,' Called in Present',
     /       /,1x,'Program by Routine "EqvLines" Has a Problem',
     /       /,1x,'---> The program is Stopped',///)
 501  Format(1x,'************ PROBLEM !!!! ******************',
     /       /,1x,'The Inversion of Operator "zVec"',
     /       /,1x,'By  Routine ',A6,' Called in Present',
     /       /,1x,'Program by Routine "EqvLines" Has a Problem',
     /       /,1x,'---> The program is Stopped',///)
      Return
      End
