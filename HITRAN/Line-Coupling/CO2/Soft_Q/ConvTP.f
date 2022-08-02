      Subroutine ConvTP(iBand,IsotC,nLineC,SigMoy,Temp,Ptot)
C*********************************************************************
C "ConvTP": CONVert to Temperature and Pressure
C ..........................................................
C         .    Subroutine to Convert the Data Read         .
C         .     by SubRoutines "DetBand" and "ReadQ"       .
C         .     for the current band of number 'iBand'     .
C         .   to the conditions of temperature 'Temp' (K)  .         
C         .        and Total Pressure 'Ptot' (atm)         .
C         .     for all retained Lines of current Band     .
C         ..................................................
C
C Input/Output Parameters of Routine (Arguments or Common)
C ---------------------------------
C          iBand : Number of the Current band Treated (Input)
C          IsotC : CO2 Isotope associated with current band (Input).
C         nLineC : Number of lines of current band (Input).
C          Temp  : Temperature in Kelvin (Input).
C          Ptot  : Total Pressure in Atmosphere (Input).
C        SigMoy  : The Population-Averaged value of the Positions
C                  of the Lines in the current band (Output).
C
C Other important Input Quantities (through Common Statements)
C --------------------------------
C      See in Subroutine "ReadQ"
C
C Other important Output Quantities (through Common Statements)
C ---------------------------------------
C            HWT : Air Broadened HalfWidths of the Lines for the
C                  Considered Temperature and Pressure (Cm-1)
C          PopuT : Populations of the Lower Levels of the Lines
C                  at Temperature Temp
C             YT : Air Broadened First Order Line Mixing Coefficients 
C                  of the Lines for the Considered Temperature and
C                  Pressure (No Unit)
C            OpR : Diagonal Operator Whose Elements are the Line
C                  Positions (Real Part of the L+iPW operator, Cm-1)
C            OpI : Operator whose Elements are those of the relaxation 
C                  operator at the Considered Temperature and Pressure
C                  (Imaginary Part of the L+iPW operator, in Cm-1)
C
C Accessed Files:  None
C --------------
C
C Called Routines: "PFCO2" (Partition Function of CO2)
C ---------------  "EqvLines" (Equivalent Q lines)
C
C Called By: 'CompAbs' (COMPute ABSorpton)
C ---------
C
C Double Precision Version
C
C J.-M. Hartmann, last change 06 March 1997
C*********************************************************************
C
      Implicit None
      Integer nBmx,nLmx
      Integer iBand,IsotC,nLineC
      Integer iLine,iLineP
         Double Precision SigMoy,Temp,Ptot
         Double Precision Sig,Dipo,E,HWT0,BHW,PopuT0
         Double Precision YT0,BY,WT0,BW
         Double Precision HWT,PopuT,YT,OpR,OpI
         Double Precision T0,Ct,RatioT,RatioPart,PFCO2
         Double Precision SumWgt,SumY,Wgt
C Max Number of Bands and of Lines per Band
      Parameter (nBmx=30,nLmx=120)
C
C Data of the Q Lines at Ref Temperature/Pressure
      Common/LineSg/Sig(nLmx,nBmx) 
      Common/DipolT/Dipo(nLmx,nBmx) 
      Common/Energy/E(nLmx,nBmx) 
      Common/GamT0/HWT0(nLmx,nBmx) 
      Common/DTGAM/BHW(nLmx,nBmx) 
      Common/PopTrf/PopuT0(nLmx,nBmx)
      Common/YLT0/YT0(nLmx,nBmx)
      Common/dTYL/BY(nLmx,nBmx)
      Common/RelxT0/WT0(nLmx,nLmx,nBmx)
      Common/dTRelx/BW(nLmx,nLmx,nBmx)
C Data of the Q Lines at (Temp,Pressure) for the Current Band
      Common/GamT/HWT(nLmx) 
      Common/PopuT/PopuT(nLmx)
      Common/YLT/YT(nLmx)
      Common/DiagnR/OpR(nLmx,nLmx)
      Common/DiagnI/OpI(nLmx,nLmx)
C----------
C
      Data T0,Ct/296.d0,1.4387686d0/
C
        If( (Temp.LT.170d0) .OR. (Temp.GT.330.d0) )Then
        Write(*,1000)Temp
 1000   Format(1x,'The Temperature ',d10.3,' Kelvin',/,1x,
     /        'is OUT of the RANGE for The Prsent Program',/,1x,   
     /        'Which is 170 to 330 K, ---> Stop Program')
        Stop
        End If
C
      RatioT=T0/Temp
      RatioPart=PFCO2(IsotC,T0)/PFCO2(IsotC,Temp)
C 
C Treat all Lines for Population, Width, and L-M Coeff        
      SigMoy=0.d0
      SumWgt=0.d0
      SumY=0.d0
        Do 3 iLine=1,nLineC
        PopuT(iLine)=PopuT0(iLine,iBand)*RatioPart
     *              * dExp(-Ct*E(iLine,iBand)*(1.d0/Temp-1.d0/T0))
        HWT(iLine)=(Ptot*HWT0(iLine,iBand))
     *                 *(RatioT**BHW(iLine,iBand))
        YT(iLine)=(Ptot*YT0(iLine,iBand))
     *             *  (1.d0-BY(iLine,iBand)*DLOG(RatioT))
        Wgt=PopuT(iLine)*(Dipo(iLine,iBand)**2)
        SumY=SumY+(YT(iLine)*Wgt)
        SigMoy=SigMoy+(Sig(iLine,iBand)*Wgt)
        SumWgt=SumWgt+Wgt
 3      Continue
      SigMoy=SigMoy/SumWgt
      SumY=SumY/SumWgt
C Correct Y for possible slight Error on Sum R*ule
                Do 31 iLine=1,nLineC
                YT(iLine)=YT(iLine)-SumY
 31             Continue
C Treat all Couples of Lines for Relaxation Matrix 
        Do 4 iLine=2,nLineC
        Do 4 iLineP=1,iLine-1
        OpI(iLineP,iLine)=(Ptot*WT0(iLineP,iLine,iBand))
     *                  *  (RatioT**BW(iLineP,iLine,iBand))
        OpI(iLine,iLineP)=OpI(iLineP,iLine)
     *                  *  (PopuT(iLine)/PopuT(iLinep))
          OpR(iLineP,iLine)=0.d0
          OpR(iLine,iLineP)=0.d0
 4      Continue
        Do 5 iLine=1,nLineC
        OpI(iLine,iLine)=HWT(iLine)
          OpR(iLine,iLine)=Sig(iLine,iBand)-SigMoy
 5      Continue
C Compute the "intensities" and "Widths" of Equivalent lines
        Call EqvLines(iBand,nLineC)
C
        Return
        End
