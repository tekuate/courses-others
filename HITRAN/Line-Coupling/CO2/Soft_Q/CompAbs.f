      Subroutine CompAbs(Temp,Ptot,xCO2
     ,                  ,SigMin,SigMax,DSig)
C*********************************************************************
C "CompAbs": COMPute ABSorptions
C .........................................................
C         .     Subroutine to Compute the absorption      .
C         .      Coefficient due to the Q-branches.       .
C         .       All Bands and Lines Retained by         . 
C         .      Subroutines "DetBand" and "ReadQ".       .
C         .      Voigt, First Order L-M, and W Models     .
C         .................................................
C
C Input/Output Parameters of Routine (Arguments or Common)
C ---------------------------------
C          nBand : Number of Current band Treated (Input)
C          Isot  : Integer Array of the CO2 isotope associated
C                  with each band (Input).
C         nLines : Integer Array of the number of lines of each
C                  band (Input).
C          Temp  : Temperature in Kelvin (Input).
C          Ptot  : Total Pressure in Atmosphere (Input).
C          xCO2  : CO2 volume mixing ratio (Input).
C        SigMin  : Minimum WaveNumber of the Computation (Cm-1, Input)
C        SigMax  : Maximum WaveNumber of the Computation (Cm-1, Input)
C          DSig  : WaveNumber Step of the Computation (Cm-1, Input)
C
C Other important Input Quantities (through Common Statements)
C --------------------------------
C            HWT : Air Broadened HalfWidths of the Lines for the
C                  Considered Temperature and Pressure (Cm-1)
C          PopuT : Populations of the Lower Levels of the Lines
C                  at Temperature Temp
C             YT : Air Broadened First Order Line Mixing Coefficients 
C                  of the Lines for the Considered Temperature and
C                  Pressure (No Unit)
C           Dipo : Dipole transition Moments of the Lines
C                  (Cm/Molecule**0.5)
C            SSR : Real Part of the Intensities of the Equivalent Lines
C                  (Cm/Molecule)
C            SSI : Imaginary Part of the Intensities of the Equivalent
C                  Lines (Cm/Molecule)
C          AlphR : Positions of the Equivalent Lines (Cm-1)
C          AlphI : HalfWidths of the Equivalent Lines (Cm-1)
C
C Other important Output Quantities (through Common Statements)
C ---------------------------------
C          AbsV : Absorption Coefficient neglecting LineMixing
C                 (assuming Voigt Line-Shapes) (Cm-1)
C          AbsY : Absorption Coefficient predicted using the First
C                 Order Line-Mixing Approximation (Cm-1)
C          AbsV : Absorption Coefficient accounting for Line-Mixing
C                 by the Relaxation Operator (Cm-1)
C See Preceding Routines for the Other Variables
C
C
C Accessed Files:  None
C --------------
C
C Called Routines: 'ConvTP' (CONVert data to current Temp and Press)
C ---------------  'CPF' (Complex Probability Function)
C
C Called By: Main Program
C ---------
C
C Double Precision Version
C
C J.-M. Hartmann, last change 23 June 1997
C --------------
C*********************************************************************
C
        Implicit None
      Integer nBmx,nLmx,nSigmx,nIsotp
      Integer nBand,Isot,iVI,iVF,nLines
      Integer nSig,iSig,iBand,iLine
        Double Precision Temp,Ptot,xCO2,SigMin,SigMax,DSig
        Double Precision Sig,Dipo,HWT,PopuT,YT
        Double Precision SSR,SSI,AlphR,AlphI
        Double Precision AbsV,AbsY,AbsW
        Double Precision aMass,Ct,CtGamD,aMolAtm,Pi
        Double Precision SigMoy,GamD,Cte,Cte1,Fact
        Double Precision SigC,SumV,SumY,SumW
        Double Precision XX,YY,WR,WI
C Max Number of Bands and of Lines per Band
      Parameter (nBmx=30,nLmx=120)
C Max Number of Spectral Points
      Parameter (nSigmx=20000)
C Number of CO2 Isotopomers nd their Masses
      Parameter (nIsotp=8)
      Dimension aMass(nIsotp)
C Characteristic of the Bands
      Common/Bands/nBand,Isot(nBmx),iVI(nBmx),iVF(nBmx),nLines(nBmx)
C Data of the "Real" Q Lines
      Common/LineSg/Sig(nLmx,nBmx) 
      Common/DipolT/Dipo(nLmx,nBmx) 
      Common/GamT/HWT(nLmx) 
      Common/PopuT/PopuT(nLmx)
      Common/YLT/YT(nLmx)
C Data of the "Equivalent" Q Lines
      Common/FicLSR/SSR(nLmx)
      Common/FicLSI/SSI(nLmx)
      Common/FicLPR/AlphR(nLmx)
      Common/FicLPI/AlphI(nLmx)
C Results (Absorption Coefficients)
      Common/CabsV/AbsV(nSigmx)
      Common/CabsF/AbsY(nSigmx)
      Common/CabsW/AbsW(nSigmx)
C Constants      
      Data Ct/1.4387686d0/
      Data CtGamD/1.1325d-08/
      Data aMolAtm/7.33889d+21/
      Data Pi/3.141592654d0/
      Data aMass/44.D-3,45.d-3,46.d-3,45.d-3
     ,          ,47.d-3,46.d-3,48.d-3,47.d-3/
C----------
C
C Check that Arrays for Results are Large Enough, Initialize
       nSig=Int((SigMax-SigMIn)/DSig)+1
       If ( nSig .GT. nSigmx) Then
       Write(*,1000)nSig,nSig
       Stop
       End If
 1000 Format(1x,'************ PROBLEM !!!! ******************',
     /       /,1x,'The Number of points to compute (',I6,')',
     /       /,1x,'is TOO large for Arrays ---> Program Stop',
     /       /,1x,'Raise the value of "nSigmx" to at least ',I6,
     /       /,1x,'in ALL Parameter Statements where it appears',///)
          Do 10 iSig=1,nSig
          AbsV(iSig)=0.d0
          AbsY(iSig)=0.d0
          AbsW(iSig)=0.d0
 10       Continue
C
C
C Do Loop over the Various Bands
C
      Do 1 iBand=1,nBand
C Convert Current Band Data to Considered Temperature and Pressure
      Call ConvTP(iBand,Isot(iBand),nLines(iBand),SigMoy,Temp,Ptot)
C
C Compute the Doppler Width at SigMoy
      GamD=CtGamD*DSQRT(Temp/aMass(Isot(iBand)))*SigMoy
      Cte=DSQRT(DLOG(2.d0))/GamD
      Cte1=(xCO2*Ptot*aMolAtm/Temp)*(Cte/DSQRT(Pi))
C
C Various WaveNumbers
C
         SigC=SigMin-DSig
         do 2 iSig=1,nSig 
         SigC=SigC+DSig
         SumV=0.d0
         SumY=0.d0
         SumW=0.d0
C
C Various Lines
C
      Do 3 iLine=1,nLines(iBand)
C Complex Probability Function for the "Real" Q-Lines
      XX=(Sig(iLine,iBand)-SigC)*cte
      YY=HWT(iLine)*cte
      Call CPF(XX,YY,WR,WI)
C Voigt Absorption Coefficient         
      SumV=SumV+PopuT(iLine)*(Dipo(iLine,iBand)**2)*WR
C First Order Line-Mixing Absorption Coefficient        
      SumY=SumY+PopuT(iLine)*(Dipo(iLine,iBand)**2)*(WR-YT(iLine)*WI)
C
C Complex Probability Function for the "Equivalent" Q-Lines
      XX=(AlphR(iLine)+SigMoy-SigC)*cte
      YY=AlphI(iLine)*cte
      Call CPF(XX,YY,WR,WI)
C Absorption Coefficient due to W
      SumW=SumW+(SSR(iLine)*WR-SSI(iLine)*WI)
 3    Continue     
         AbsV(iSig)=AbsV(iSig)+Cte1*SumV
         AbsY(iSig)=AbsY(iSig)+Cte1*SumY
         AbsW(iSig)=AbsW(iSig)+Cte1*SumW
 2       Continue     
 1    Continue     
c Last Corrections on Results
      SigC=SigMin-DSig
      do 6 iSig=1,nSig 
      SigC=SigC+DSig
      Fact=SigC*(1.d0-DEXP(-Ct*SigC/Temp))
      AbsV(iSig)=AbsV(iSig)*Fact
      AbsY(iSig)=AbsY(iSig)*Fact
      AbsW(iSig)=AbsW(iSig)*Fact
 6    Continue     
C
      Return
      End
