      Subroutine DetBand(SgMinR,SgMaxR,Scut)
C*********************************************************************
C "DetBand": DETermine BANDs
C ..........................................................
C          .   Subroutine to Determine the CO2 Q-Branches  .
C          .   that have Lines lying between WaveNumbers   .
C          .    SgMinR and SgMaxR and a Total Q-branch     .
C          .         Intensity Greater Than Scut           .
C          .................................................
C
C Input/Output Parameters of Routine (Arguments or Common)
C ---------------------------------
C         SgMinR : Minimum WN of selection range (in Cm-1) (Input).
C         SgMaxR : Maximum WN of selection range (in Cm-1) (Input).
C           Scut : Intensity Cut-Off criteria. Only the Q branches
C                  of Total Intensity (Sum of Q-Line Intensities)
C                  Greater (at 296 K) than Scut are Retained. This
C                  (Input) quantity is in Cm/Molec (as in HITRAN).
C          nBand : Integer of the Number of Bands Retained (Output).
C          Isot  : Integer Array of the CO2 isotope associated
C                  with each Retained Band (Output).
C          iVI   : Integer Array of the vibrational number of the
C                  Lower state of each Retained Band (Output).
C          iVF   : Integer Array of the vibrational number of the
C                  Upper state of each Retained Band (Output).
C These last three quantities are numbered according to the 
C HITRAN numbering system.
C
C Accessed Files
C --------------
C Data on the Bands are Read in File 'BandInf.DAT' on Unit=iFile
C (iFile=3). The USER will probably HAVE TO CHANGE the access
C Path to this file according to his computer+directory system.
C
C Called Routines: None
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
         Integer nBmx,iFile
         Integer nBand,Isot,iVI,iVF,nLines
         Integer IsotR,iVFR,iVIR
      Double Precision SgMinR,SgMaxR,Scut
      Double Precision SgMinQ,SgMaxQ,Stot
C Unit Number for File access
      Parameter (iFile=3)
C Max Number of Bands
      Parameter (nBmx=30)
C Characteristics of the Bands
      Common/Bands/nBand,Isot(nBmx),iVI(nBmx),iVF(nBmx),nLines(nBmx)
C----------
C
C Open File Giving Information on Bands, Read, and Select
      nBand=0
      Open(Unit=iFile,File='../Data_Q/BandInf.DAT',Status='Old')
 1    Read(iFile,1000,End=100)IsotR,iVFR,iVIR,Stot
     ,                       ,SgMinQ,SgMaxQ
C
      If( (Stot.GE.Scut) .And. (SgMinR.LT.SgMaxQ)
     .                   .And. (SgMaxR.GT.SgMinQ) )Then
      nBand=nBand+1
C
         If ( nBand.LE.nBmx ) Then
         Isot(nBand)=IsotR
         iVI(nBand)=iVIR
         iVF(nBand)=iVFR
         End If
      End If
      GoTo 1
C
 100  Continue
      Close(iFile)
C Message+Stop if Number of Bands is Not too Large for Arrays          
          If ( nBand.GT.nBmx ) Then
          Write(*,1001)nBand,nBand
          Stop
          End If
C      
 1000 Format(1x,I1,1x,I3,1x,I3,1PD10.3,1x,0PF7.1,1x,0Pf7.1)
 1001 Format(1x,'************ PROBLEM !!!! ******************',
     /       /,1x,'The Number of Bands to Store ("nBand"=',I2,')',
     /       /,1x,'is TOO large for Arrays ---> Program Stop',
     /       /,1x,'Raise the value of "nBmx" to at least ',I2,
     /       /,1x,'in ALL Parameter Statements where it appears',///)
      Return
      End
