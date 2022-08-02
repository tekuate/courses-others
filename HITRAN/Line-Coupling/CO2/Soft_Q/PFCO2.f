      Function PFCO2(Iso,Temp)
C*********************************************************************
C "PFCO2": Partition Function of CO2
C .........................................................
C          .    Function to Compute the Total Partition   .
C          .    Function of the CO2 Isotope number "Iso"  .
C          .    (the Numbering System is that of HITRAN)  .
C          .    at Temperature 70 < "Temp"(in K) < 400    .
C          ................................................
C            Iso : Isotope Number (HITRAN96 convention)
C           Temp : Temperature in Kelvin. It SHOULD BE in
C                  the 70 K to 400 K Range
C           PFCO2 : Rovibrational Partition Function
c
C A Polynomial Representation is used. This Function has been
C Extracted from the "bd_qt.for" Fortran Program which is
C Supplied with the HITRAN-96 Data Base.
C
C Accessed Files:  None
C --------------
C
C Called Routines: None                               
C ---------------                                 
C
C Called By: 'ConvTP' (CONVert to Temp and Press)
C ---------
C
C Double Precision Version
C
C J.-M. Hartmann, last change 24 June 1997
C*********************************************************************
C
      Implicit None
      Integer nIso,Iso,J
      Double Precision Temp,PFCO2,Qcoef
C
      Parameter (nIso=8)
C      
C Polynomial Coefficients for the Various Isotopomers
      Dimension Qcoef(nIso,4)
C Iso=1, i.e. O(16)-C(12)-O(16)
      DATA (Qcoef(1,J),J=1,4)/-.13617D+01, .94899D+00,
     +               -.69259D-03, .25974D-05/
C Iso=2, i.e. O(16)-C(13)-O(16)
      DATA (Qcoef(2,J),J=1,4)/-.20631D+01, .18873D+01,
     +               -.13669D-02, .54032D-05/
C Iso=3, i.e. O(16)-C(12)-O(18)
      DATA (Qcoef(3,J),J=1,4)/-.29175D+01, .20114D+01,
     +               -.14786D-02, .55941D-05/
C Iso=4, i.e. O(16)-C(12)-O(17)
      DATA (Qcoef(4,J),J=1,4)/-.16558D+02, .11733D+02,
     +               -.85844D-02, .32379D-04/
C Iso=5, i.e. O(16)-C(13)-O(18)
      DATA (Qcoef(5,J),J=1,4)/-.44685D+01, .40330D+01,
     +               -.29590D-02, .11770D-04/
C Iso=6, i.e. O(16)-C(13)-O(17)
      DATA (Qcoef(6,J),J=1,4)/-.26263D+02, .23350D+02,
     +               -.17032D-01, .67532D-04/
C Iso=7, i.e. O(18)-C(12)-O(18)
      DATA (Qcoef(7,J),J=1,4)/-.14811D+01, .10667D+01,
     +               -.78758D-03, .30133D-05/
C Iso=8, i.e. O(17)-C(12)-O(18)
      DATA (Qcoef(8,J),J=1,4)/-.17600D+02, .12445D+02,
     +               -.91837D-02, .34915D-04/
C--------
C
        If( (Temp.LT.70d0) .OR. (Temp.GT.500.d0) )Then
        Write(*,1000)Temp
 1000   Format(1x,'The Temperature ',d10.3,' Kelvin',/,1x,
     /        'is OUT of the RANGE for The Partition Ftn',/,1x,   
     /        'Which is 70 to 400 K --> Stop Program')
        Stop
        EndIf
C      
        PFCO2 = Qcoef(Iso,1)
     +       + Qcoef(Iso,2)*Temp
     +       + Qcoef(Iso,3)*Temp*Temp
     +       + Qcoef(Iso,4)*Temp*Temp*Temp
C      
        Return
        End
c...   CO2  --   626
c...   CO2  --   636
c...   CO2  --   628
c...   CO2  --   627
c...   CO2  --   638
c...   CO2  --   637
c...   CO2  --   828
c...   CO2  --   728
