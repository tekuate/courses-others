      Subroutine ReadQ
C*********************************************************************
C "ReadQ": READ Q lines data
C ..........................................................
C          .     Subroutine to Read the Spectroscopic,     .
C          .    First order Line-Mixing Coefficients,      .
C          .     and Relaxation Matrix Data at Reference   .
C          .         Temperature from Files                .
C          . (for the Bands Selected by routine "DetBand"  .
C          .................................................
C
C Input/Output Parameters of Routine (Arguments or Common)
C ---------------------------------
C          nBand : Integer of the Number of Bands to read (Input).
C          Isot  : Integer Array of the CO2 isotope associated
C                  with each band (Input).
C          iVI   : Integer Array of the vibrational number of the
C                  lower state of each band (Input).
C          iVF   : Integer Array of the vibrational number of the
C                  lower state of each band (Input).
C         nLines : Integer Array of the number of lines of each
C                  band (Output).
C
C Other important Output Quantities (through Common Statements)
C ---------------------------------
C            Sig : WaveNumbers of the Lines (Cm-1) 
C           Dipo : Dipole transition Moments of the Lines
C                  (cm/Molecule**0.5)
C              E : Energies of the Lower levels of the lines (Cm-1)
C           HWT0 : Air-broadened Half-Widths (at 296 K) of the 
C                  Lines (Cm-1/Atm)
C            BHW : Temperature Dependence Coefficients of HWT0
C         PopuT0 : Populations of the Lower Levels of the Lines
C                  at 296 K.
C            YT0 : Air-broadened First Order Line-Mixing Coefficients 
C                  (at 296 K) of the Lines (Atm-1)
C             BY : Temperature Dependence Coefficients of YT0
C            WT0 : Air-broadened Relaxation Operator Elements 
C                  (at 296 K) of all Couples of Lines (Cm-1/Atm)
C             BW : Temperature Dependence Coefficients of WT0
C
C
C Accessed Files
C --------------
C For each of the "nBand" bands, the Q-branch Data are Read 
C in Three different File, each of them on Unit=iFile (=3)
C They are : 'Sizzzyyy.DAT', 'Yizzzyyy.DAT', and 'Wizzzyyy.DAT' with
C the Conventions : 'S.....DAT': Spectroscopic Data, 
C                   'Y.....DAT': First Order Line-Mixing Data, 
C                   'W.....DAT': Relaxation Operator Data.
C The characters i, zzz, and yyy define, respectively, the Isotope,
C and the Upper and Lower Vibrational states (with the numbering
C convention used in the HITRAN-96 Data base).
C      The USER will probably HAVE TO CHANGE the access Paths to 
C these files according to his computer+directory system.
C
C Called Routines: 'PFCO2' (CO2 partition function)
C ---------------
C
C Called By: Main Program
C ---------
C
C Double Precision Version
C
C J.-M. Hartmann, last change 06 March 1997
C*********************************************************************
C
      Implicit None
      Integer nBmx,iFile,nLmx
      Integer nBand,Isot,iVI,iVF,nLines
      Integer iBand,I0,I1,I2,nLineR,J,iLine,iLineP
        Character*1 cIsot
        Character*3 cVibI,cVibF
        Character*7 cBand
      Double Precision Sig,Dipo,E,HWT0,BHW,PopuT0
      Double Precision YT0,BY,WT0,BW
C Unit Number for File access
      Parameter (iFile=3)
C Max Number of Bands and of Lines per Band
      Parameter (nBmx=30,nLmx=120)
C      
C Characteristic of the Bands
      Common/Bands/nBand,Isot(nBmx),iVI(nBmx),iVF(nBmx),nLines(nBmx)
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
C------------
C
C Check that Number of Bands is Not TOO Large
      If ( nBand .GT. nBmx ) Then
      Write(*,1000)nBand,nBand
      Stop
      End If
 1000 Format(1x,'************ PROBLEM !!!! ******************',
     /       /,1x,'The Number of Bands to Read ("nBand"=',I2,')',
     /       /,1x,'is TOO large for Arrays ---> Program Stop',
     /       /,1x,'Raise the value of "nBmx" to at least ',I2,
     /       /,1x,'in ALL Parameter Statements where it appears',///)
C
C
C Do Loop in Order to Read Data for All Bands
C
        Do 1 iBand=1,nBand
C Determine File Name from Isotope and Vibrational Numbers
        cIsot=CHAR(Isot(iBand)+48)
        i2=iVI(iBand)/100
        i1=(iVI(iBand)-100*i2)/10
        i0=iVI(iBand)-100*i2-i1*10
        cVibI=CHAR(i2+48)//CHAR(i1+48)//CHAR(i0+48)
        i2=iVF(iBand)/100
        i1=(iVF(iBand)-100*i2)/10
        i0=iVF(iBand)-100*i2-i1*10
        cVibF=CHAR(i2+48)//CHAR(i1+48)//CHAR(i0+48)
        cBand=cIsot//cVibF//cVibI
C
C Open File of spectroscopic Data and Read
C        
        nLineR=1
      Open(Unit=iFile,File='../Data_Q/S'//cBand//'.DAT',Status='Old')
  2     Read(iFile,1001,End=100)Sig(nLineR,iBand),Dipo(nLineR,iBand)
     ,                     ,  PopuT0(nLineR,iBand),E(nLineR,iBand)
     ,                     ,  HWT0(nLineR,iBand),BHW(nLineR,iBand),J
        nLineR=nLineR+1
C Check that dimensions are fine. Stop if not
      If ( nLineR .GT. nLmx ) Then
      Write(*,2000)                 
      Stop
      End If
 2000 Format(//,1x,'************ PROBLEM !!!! ******************',
     /       /,1x,'Arrays in for Line data storage are too small',
     /       /,1x,'raise the value of nLmx in ALL Parameter ',
     ,   'Statements')
C
        GoTo 2
 100    Continue
      Close(iFile)
1001  Format(1X,F12.6,1X,1PD10.3,1X,D10.3,1X,0PF10.4,1x,0PF5.4,1X,
     ,      0PF3.2,1x,I3)
        nLines(iBand)=nLineR-1
C
C Open File of First Line-Mixing Data and Read
C        
      Open(Unit=iFile,File='../Data_Q/Y'//cBand//'.DAT',Status='Old')
        Do 3 iLine=1,nLines(iBand)
        Read(iFile,1002)YT0(iLine,iBand),BY(iLine,iBand)
  3     Continue
      Close(iFile)
1002   Format(1X,1PD10.3,1x,D10.3)
C        
C Open File of Relaxation Matrix Data and Read
C        
      Open(Unit=iFile,File='../Data_Q/W'//cBand//'.DAT',Status='Old')
        Do 4 iLine=2,nLines(iBand)
        Do 5 iLineP=1,iLine-1
        Read(iFile,1003)WT0(iLineP,iLine,iBand),BW(iLineP,iLine,iBand)
 1003   Format(1X,1PD10.3,1x,D10.3)
  5     Continue
  4     Continue
      Close(iFile)
C
C End of Do Loop on Bands
  1     Continue
        Return
        End
