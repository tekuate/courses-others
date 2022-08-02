      Program Test
C*********************************************************************
C "Test": to TEST the implementation of the software and files
C .............................................................
C
C   ...........................................................
C   .                Jean-Michel Hartmann                     .
C   .                                                         .
C   .   Laboratoire de Physique Moleculaire et Applications,  .
C   .            UPR 136 du CNRS associee                     .
C   .    aux Universites P. & M. Curie et Paris-Sud,          .
C   .        Universite Paris-Sud (batiment 350),             .
C   .           91405 Orsay Cedex, France.                    .
C   .                                                         .
C   .        Tel: 33 169157514   Fax: 33 169157530            .
C   .          E-mail: hartmann@lpma.u-psud.fr                .
C   ...........................................................
C
C Version limited to symmetric isotopomers of CO2 (i.e., 12C16O2,
C 13C16O2, and 12C18O2).
C
C This Main program is part of the
C  Package (Software+Data) for computation of absorption by
C       CO2 infrared Q-branches in the Atmosphere
C Reading the "ReadMe.txt" file provides information which
C helps in understanding the present software
C
C   This program makes predetermined computations in Q-branches and
C compares the results with some reference results that are stored
C in the 'Test.DAT' file (Unit=10, see below for adaptation)
C   Messages are writen in file 'DIAGNOS.DAT' on Unit=11 (also 
C check for adaptation on your computer) giving a diagnostic
C concerning the results (i.e. OK or PB). The purely Voigt
C as well as first order line-mixing and full line-mixing
C computations are checked for the 16 most instense Q-branches
C
C
C IMPORTANT, BEFORE YOU RUN THIS PROGRAM: 
C  -The other main program (ChkSiz.f) should have been ran in
C order to check that all required data files have the right
C numbers of lines (i.e., that FTP transfer was complete).
C  -This main program uses the whole set of subroutine that
C have been made to compute CO2-branch absorption (i.e., 
C "DetBand", "ReadQ", "ConvTP", "EqvLines", "CompABS", "PFCO2",
C "CPF", and some diagonalization+inverstion routines from
C commercially available FORTRAN Libraries, see "ReadMe.txt")
C  -Make the changes required in all the routines that this 
C programs needs (see the "ReadMe.txt" file on what is to be
C done and how to do it.)
C  -This program accesses a file (to read) on Unit=10, whose
C name is 'Test.DAT'. Check that the path to this file is
C correct (according to your computer system).
C  -This program accesses a file (to write) on Unit=11, whose
C name is 'DIAGNOS.DAT'. Check that the path to this file is
C correct (according to your computer system).
C
C See the "ReadMe.txt" file for more information than that
C given here.
C
C
C Accessed Files : 'Test.DAT' (Read, Unit=10)
C --------------   'DIAGNOS.DAT' (Write, Unit=11)
C
C Required Routines : 'DetBand.f', 'ReadQ.f', 'CompAbs.f',
C -----------------   'ConvTP.f', 'EqvLines.f', 'CPF.f',
C                     'PFCO2.f'
C                   + Inversion and Diagonalizatio routines
C                   that the user needs to choose (see
C                   ReadMe.txt and the comments in EqvLines.f
C
C Double Precision Version
C
C J.-M. Hartmann, last change 06 March 1997
C**********************************************************
C
C
      Implicit None
        Character*2 PbOK
        Character*1 T
      Integer nSigMx,nBmx,iSig
      Integer nBand,Isot,iVI,iVF,nLines
      Integer Iso0,iVF0,iVI0,nSig
      Integer iV,iY,iW,iVtot,iYtot,iWtot
         Double Precision Temp,Ptot,xCO2
         Double Precision SCut,SgMin,SgMax,dsig
         Double Precision Absv,AbsY,AbsW
         Double Precision Vref,Yref,Wref
         Double Precision DifMxV,DifMxY,DifMxW
         Double Precision Epsilon
C
      Parameter (nSigmx=20000)
      Parameter (nBmx=30)
C
      Dimension T(0:1)
C      
C Characteristics of the Bands
      Common/Bands/nBand,Isot(nBmx),iVI(nBmx),iVF(nBmx),nLines(nBmx)
C Results
      Common/CabsV/AbsV(nSigmx)
      Common/CabsF/AbsY(nSigmx)
      Common/CabsW/AbsW(nSigmx)
C 
      T(0)='Y'
      T(1)='N'
      Scut=0.d0
      Epsilon=1.d-4
      iVtot=0
      iYtot=0
      iWtot=0
      Write(*,*)'Processing Test....'
C Open file that will contain diagnostic 
      Open(Unit=11,File='DIAGNOS.DAT')
      Write(11,500)
500   Format(12x,'Results of the Test Program',/,
     ,       6x,'0=OK 1=PB   see bottom of File for Overall',/,
     ,       1x,65('-'),/,
     ,       1x,'Isot',2x,'Vib_Sup',2x,'Vib_Inf',2x,
     ,       'Voigt',3x,'1rst_LM',2x,'Full_LM',2x,
     ,       'Fine/NotFine',/,1x,65('-'))
C Open file that contains information for reference calc
C   Then successively read data, carry computation, compare,
C make diagnostic and display
      Open(Unit=10,File='Test.DAT',Status='Old')
11    Read(10,400,end=1000)iso0,ivf0,ivi0,sgMin,sgMax
400   Format(3(I3),2(1x,f7.1))
C note that calling DetBand is only to check that file access
C was properly set
      Call DetBand(SgMin,SgMax,Scut)
      nBand=1
      Isot(1)=Iso0
      iVI(1)=iVI0
      iVF(1)=iVF0
      Call ReadQ
      dsig=(SgMax-Sgmin)/2.001d0
      Sgmin=SgMin-DSig
      Sgmax=SgMax+DSig
      nSig=INT( (SgMax-SgMin)/DSig) + 1
Check Results for 0.5 atm, 230 K, and 100% CO2
      xCO2=1.d0
      Temp=230.d0
      Ptot=0.5d0
      Call CompAbs(Temp,Ptot,xCO2,SgMin,SgMax,DSig)
      DifMxV=-1.d10
      DifMxY=-1.d10
      DifMxW=-1.d10
      Do 123 iSig=1,nSig
      Read(10,401)Vref,Yref,Wref
      DifMxV=DMAX1(DifMxV,Dabs(1.d0-AbsV(iSig)/Vref))
      DifMxY=DMAX1(DifMxY,Dabs(1.d0-AbsY(iSig)/Yref))
      DifMxW=DMAX1(DifMxW,Dabs(1.d0-AbsW(iSig)/Wref))
123   Continue      
401   Format(3(1x,D12.5))
C
C
Check Results for 5 atm, 310 K, and 50% CO2
      xCO2=0.5d0
      Temp=310.D0
      Ptot=5.0d0
      Call CompAbs(Temp,Ptot,xCO2,SgMin,SgMax,DSig)
      Do 124 iSig=1,nSig
      Read(10,401)Vref,Yref,Wref
      DifMxV=DMAX1(DifMxV,Dabs(1.d0-AbsV(iSig)/Vref))
      DifMxY=DMAX1(DifMxY,Dabs(1.d0-AbsY(iSig)/Yref))
      DifMxW=DMAX1(DifMxW,Dabs(1.d0-AbsW(iSig)/Wref))
124   Continue      
C
C Final Diagnostics
      iV=0
      iY=0
      iW=0
      if(DifMxV.GT.Epsilon)iV=1
      if(DifMxY.GT.Epsilon)iY=1
      if(DifMxW.GT.Epsilon)iW=1
      iVtot=Max0(iVtot,iV)
      iYtot=Max0(iYtot,iY)
      iWtot=Max0(iWtot,iW)
        If( iV+iY+iW.NE.0 )Then
        PbOK='PB'
           Else
           PbOK='OK'
        End If
      Write(11,501)Isot(1),iVF(1),iVI(1),iV,iY,iW,PbOK
501   Format(3x,I1,4x,I3,6x,I3,3(8x,I1),8x,A2)
      Write(*,503)iVF(1),iVI(1),Isot(1),PbOK
503   Format(1x,'Check of Band ',I2,'<--',I2,' of isotope ',I1,
     ,' completed. Result: ',A2)
C      
      GoTo 11
1000  Continue
      Close(10)
C      
C Final Diagnostic
      Write(11,502)T(iVtot),T(iYtot),T(iWtot)
502   Format(1X,65('-'),//,'**** GLOBAL RESULTS ****',/,
     , 1x,'Did the TEST go Fine for all Bands ?',/,
     , 5x,'When the Voigt Model is used:            ',A1,/,
     , 5x,'When the First Order LM Model is used:   ',A1,/,
     , 5x,'When the Full LM Model is used:          ',A1)
      EndFile(11)
      Close(11)
      If(iVtot+iYtot+iWtot.NE.0)Then
      Write(*,403)
403   Format(//,1x,'BEWARE !, the TEST did not go fine,',
     ,          ' check file "DIAGNOS.DAT"')
         Else
         Write(*,404)
404   Format(//,1x,'GOOD !, the TEST went fine')
      End If
C      
      Stop
      End
