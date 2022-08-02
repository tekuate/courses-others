      Program ChkSiz
C*************************************************************
C ChkSiz: CHecK SIZe of Files
C ------  --  - ---
C
C This program checks that the FTP transfer of the Data
C Files used for the modeling of Line-Mixing effects in
C CO2 Q-branches went fine. In order to do this, it opens    
C successively all files to determine their number of
C (text) lines and checks (using pre-stored values) that
C they are right. A message (diagnostic) is displayed
C on the screen; in case of a problem look at the SizChk.DAT
C file to know which files should be FTP again.
C
C IMPORTANT: The user will have to change the paths for
C ---------  file access according to his computer and
C            disk systems. This is to say access to the
C            File 'FileSiz.DAT' that was originally in
C            SubDirectory /Test_Q and is read on Unit 3.
C            The access to all the files originally stored
C            in /Data_Q, which are read on Unit 4 should
C            also be adapted.
C
C ACCESSED Files
C --------------
C   Unit=3 the File 'FileSiz.DAT' which contains the Names
C          and Numbers of Lines of the Files to be checked
C          (Read File, Input).
C
C   Unit=2 the File 'SizChk.DAT' which contains the result
C          of the checking. The User should look in this
C          file in case of problem. He will find there the
C          names of the data files which do not have the
C          right number of lines. (Write File, Output).
C
C   Unit=4 the curent file whose number of lines is to be
C          determined. (read File, Input)
C
C J-M Hartmann,  last change 05/03/97
C*************************************************************
         Implicit None
      Character*12 FilNam
      Character*2 Check,CheckT
         Integer nLineR,nLine
C
      Write(*,*)'Processing Line Number Check ....'
      CheckT='OK'
C
C Open information file (3) and final diagnostic file (2)
      Open(Unit=3,File='FileSiz.DAT',Status='Old')
      Open(Unit=2,File='SizChk.DAT')
        Read(3,*)
        Read(3,*)
        Read(3,*)
      Write(2,100)
100   Format(36('-'),/,1X,'File_Name',7X,'Number_of-Lines',
     ,/,36('-'))
C
C Read Name and number of lines of current file to be checked
 1    Read(3,102,End=1000)FilNam,nLineR
102   Format(1X,A12,7X,I6)
C
C Open Current file and read to determine number of lines
      Check='OK'
      Open(Unit=4,File='../Data_Q/'//FilNam,Status='Old')
      nLine=0
 2    Read(4,*,End=500)
      nLine=nLine+1
      goto 2
 500  Continue
      close(4)
C
C Check that number of lines is right and write result into
C diagnostic file
      If( nLine.NE.nLineR )Then
      Check='PB'
      CheckT='PB'
      End If
      write(2,103)FilNam,Check
103   Format(1X,A12,9X,A2)
      GoTo 1
C
1000  Continue
      Close(3)
C Display overall diagnostic message
      Write(2,*)' '
      Write(*,*)' '
      If ( CheckT.EQ.'OK' )Then
      Write(*,*)'GOOD ! all File have the right Number of Lines'
      Write(2,*)'GOOD ! all File have the right Number of Lines'
         Else
      Write(*,*)'PROBLEM ! Some Files Do not have the right'
      Write(*,*)'Number of Lines Check In File SizChk.DAT'
      Write(2,*)'PROBLEM ! Some Files Do not have the right'
      Write(2,*)'Number of Lines --> Check Above'
      End If
      Endfile(2)
      Close(2)
C
      Stop
      end

