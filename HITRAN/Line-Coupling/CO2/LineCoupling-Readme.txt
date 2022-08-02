		      ***********************
		      *                     *
		      *  "ReadMe.txt" File  *
		      *                     *
		      ***********************
  
  _________________________________________________________________
  I                                                               I
  I        Q                  CCC         OOOOO         CCC       I
  I        Q                 CCCCC------OOOOOOOOO------CCCCC      I
  I        Q   Q              CCC         OOOOO         CCC       I
  I        Q   Q    Q                                             I
  I      Q Q   Q    Q                                             I
  I      Q Q   Q    Q     Q                                       I
  I      Q Q   Q    Q     Q      Q                                I
  I      Q Q   Q    Q     Q      Q       Q                        I
  I     QQ Q   Q    Q     Q      Q       Q        Q               I
  I_____QQ_Q___Q____Q_____Q______Q_______Q________Q__________Q____I
     
 *******************************************************************
 * This File and the associated Data & Software are the result     *
 * of a LARGE AMOUNT of WORK that we are GIVING for FREE to YOU.   *
 * Since our ONLY REWARD will now be TO KNOW that YOU ARE USING    *
 * THEM (hopefully with some success), PLEASE BE KIND ENOUGH TO    *
 * KEEP US INFORMED. For this we have no other way than to         *
 * ASK YOU TO PLEASE:                                              *
 *  -Send us an E-mail once you have transferred the Files (tell   *
 *   us who you are and what is the scientific project you need    *
 *   the Data+Software for (we may be able to help you).           *
 *  -Letting us know whatever interesting results you get using    *
 *   our Data+Software would be a nice gratification for us.       * 
 *  -We would also greatly appreciate knowing of any problem that  *
 *   you may encounter using our package. It would help us in      *
 *   correcting bugs in the Software or problems in the Model.     *
 *  -DO let us know what YOUR E-mail ADDRESS is since we can then  *
 *   add it to our mailing list related to CO2 Q-branches and      *
 *   make sure to KEEP YOU INFORMED of any CHANGES, CORRECTIONS,   *
 *   or IMPROVEMENTS in our Model+Data for Line-Mixing in CO2.     *
 *                                                                 *
 * Many THANKS in advance. Below is how you can reach us           *
 *                                                                 *
 *                     Jean-Michel HARTMANN                        *
 *          Laboratoire de Photo-Physique Moleculaire              *
 *               Unite propre du CNRS (UPR 3361)                   *
 *             Universite Paris-Sud (batiment 350)                 *
 *                 91405 Orsay Cedex, France                       *
 *           Tel: 33 169157514   Fax: 33 169157530                 *
 *        E-mail: jean-michel.hartmann@lpma.u-psud.fr              *
 *                                                                 *
 *                                                                 *
 * By J-M Hartmann. Last change 16 Fevruary 1999                   *
 *******************************************************************
 * ACKNOWLEDGEMENTS                                                *
 *                                                                 *
 *     The authors are grateful to the Centre National d'Etudes    *
 * Spatiales (CNES) for supporting part of the work that lead to   *
 * the present package under contract connected with the IASI      *
 * Satellite instrument.                                           *
 *                                                                 *
 *     Laurence Rothman, who manages the HITRAN spectroscopic data *
 * base is also acknowledged for providing the CO2 line parameters *
 *                                                                 *
 *     All experimentalist who have provided measured spectra of   *
 * CO2 in infrared Q-branches are kindly acknowledged.             *
 *                                                                 *
 *     The present Model+Data would not be without the PhD work of *
 * R. Rodrigues. Thanks to him.                                    *
 *                                                                 *
 *     K.W. Jucks, of the Harward Smithsonian Atsrophysical        *
 * Observatory, who was the first to use this package was of great *
 * help in the debugging of the whole thing.                       *
 *                                                                 *
 *     J.P. Arranz, from LPMA, is asknowledged for taking care of  *
 * the FTP anonymous                                               *
 *******************************************************************
      
     
     This File gives information on how to get and use the Data
 and Software that enable computation of the absorption by InfraRed
 CO2 Q-branches. YOU SHOULD READ IT CAREFULLY since it describes
 the CHANGES that NEED TO BE MADE in order to adapt the present
 Software+Data to your specific computer system and include
 them in your atmospheric transmission/emission computer Codes.
 Important Limitations of the model are also described here.

      Note that two PAPERs are AVAILABLE which complete some of the
 information given in the present File. The model is detailed and
 its quality is assessed (and demonstrated) by numerous comparisons
 between computed and measured laboratory as well as atmospheric
 spectra. (See at the end of this file for information on the papers
 Send an E-mail to (hartmann@lpma.u-psud.fr) to ask for them until 
 they are published. Their reading may be useful.
      
      The same E-mail address can be used for any question or
 problem related with getting or using the present Data+Software
 package. But again, PLEASE READ VERY CAREFULLY the present Notice
 (particularly chapters V to VIII) BEFORE DOING ANYTHING.
      
 The remaining of the present File is divided into 9 parts:
	  I. Purpose and Limitations of the Data+Software
	 II. How to get the Data+Software
	III. What are the Data Files
	 IV. What are the FORTRAN programs
	  V. Computer Requirements
	 VI. Adapting the Software to your computer
	VII. Testing the implementation on your computer
       VIII. Adapting your Atmospheric Absorption Code
	 IX. Some Important Suggestions for CPU
  



 ------------------------------------------------
 I. Purpose and Limitations of the Data+Software
 ------------------------------------------------
      The Data and Software enable computation of CO2 absorption by
 InfraRed Q-branches in the atmosphere. The models used and their
 Limitations are described below.
 
 THE MODELS USED are the following, which all account for Doppler
 effects:
  * The VOIGT MODEL in which Line-Mixing effects are NEGLECTED and
    absorption results from the Convolution of the Lorentz and Doppler
    line-shapes. The Data required for computations are thus limited to
    the spectroscopic characteristics (position, intensity, pressure
    broadening, ..) of the lines. Those used (see below) have been
    extracted from the 1996 Edition of the HITRAN DataBase.
  * The FIRST ORDER LINE-MIXING MODEL in which Line-Mixing effects are
    accounted through first order line-coupling coefficients. THIS
    APPROACH is computationally efficient and compatible with
    Line-by-Line approaches but it SHOULD BE USED WITH CARE. Indeed,
    it is VALID in a LIMITED PRESSURE range which depends on the
    considered Q-branch (see paper for quantitative criteria of the
    validity). The Data required are the same as those needed for
    the Voigt Model plus, for each line, the first order Line-Mixing 
    coefficient including its temperature dependence.
  * The FULL Relaxation Operator LINE-MIXING MODEL, which is the MOST
    ACCURATE and is valid whatever the total pressure. The Data
    required include the Relaxation Operator and its temperature
    dependence and as well as some spectroscopic characteristics of
    the lines and energy levels.
 
 THE LIMITATIONS are the following:
  * ONLY the ISOTOPOMERS of CO2 which have Q-lines in the 1996
    version of the HITRAN database have been treated. This reduces to
    8 isotopomers numbered from 1 to 8, which are 626, 636, 628, 627,
    638, 637, 828, and 827. This leads to a final database containing
    271 Q branches (in practice 306 since some have been splitted into
    two, see III).
    NOTE that a few Q-branches that have lines in HITRAN are not
    included. They are few and have been eliminated since either
    HITRAN-96 contains less than 10 Q-lines, or they are so
    affected by Coriolis effect that the usual polynomial expansions
    of rotational energy in terms of J(J+1) is not valid.
  * ONLY CO2 in AIR (79% N2 + 21% O2) is treated
  * The CO2 MIXING RATIO is supposed to be SMALL (contributions
    of CO2-CO2 collisions to the absorption shape are neglected)
  * The natural relative ABUNDANCE of the various isotopomers
    is assumed.
  * Since the first order Line-Mixing coefficients and Relaxation
    Operator have been determined from computations is the 176-316 K
    range, the TEMPERATURE RANGE is LIMITED to 170 < T(K) < 330
    (but results are expected to be correct in a wider range).
  * ONLY the CONTRIBUTIONS of Q-LINES of CO2 are COMPUTED (P and R
    lines of CO2 and absorption by other species or isotopomers
    should be calculated by using other Data and computer programs 
    (see Chapter VIII).
  * Local Thermodynamic Equilibrium is ASSUMED (the populations
    of the levels are given by a Boltzmann distribution governed by 
    the kinetic temperature). Note that it would be possible to
    adapt the Software in order to be able to treat cases where
    vibrational (and rotational) temperatures are different (but they
    should be known).
  * The MODEL is based on the impact approximation and thus (as, it
    is the case for the Voigt profile) SHOULD NOT BE USED to compute
    absorption TOO FAR AWAY from Q-lines. About 5 to 10 Wavenumbers
    is clearly a maximum.
  
  
  
  
 --------------------------------
 II. How to Get the Data+Software
 --------------------------------
      Starting from the place where the present "ReadMe.txt" File
 is, three Sub-Directories can be found, which are:
  * /Data_Q in which all the Data Files for computation of Q-branch
     CO2 absorption are. Their total number is 919 and they are
     described in chapter III.
  * /Soft_Q in which all the FORTRAN SubRoutines for computation of
     Q-branch CO2 absorption are. Their total number is 7 and they are
     described in chapter IV.
  * /Test_Q in which Data Files and a FORTRAN Main Program that enable
     test of the FTP transfer and of the implementation of the Data
     and Software on your Computer are given. Their number is four
     and they are described below.

 All are ASCII Files and, all together, they represent about
 16 MegaBytes.
 
    Since you were able the get to the "ReadMe.txt" File, you should
 be able to get the Data+Software by the same FTP procedure. Note that
 The number of text lines in each of the Files is given in the 
 File 'FileSize.DAT' (in /Test_Q) together with the number of Bytes
 when stored on a PC computer ; it may be wise to check, after the FTP
 transfer and using this File, that everything was transferred fine.
 
 
 
 
 --------------------------------
 III. What are the Data Files
 --------------------------------
      
 In SubDirectory /Data_Q     
 .......................
   This SubDirectory contains 610= 1 + 3*203 ASCII Files of Data
   which are described below:
 
  * 'BandInf.DAT' gives information on all the CO2 Q-branches. Each of
    the 306 Lines in the File describes a Q-branch, giving the
    quantities:  Isot,iVF,iVI,SigMin,SigMax,Stot   which are
    Isot   is the Isotope number (HITRAN numbering system)
     iVF   is the Vibrational number of the Final (upper) State of the
	   Q-branch (HITRAN numbering system)
     iVI   is the Vibrational number of the Initial (lower) State of
	   the Q-branch (HITRAN numbering system)
  SigMin   is the lowest wavenumber of the Q-branch lines (cm-1).
  SigMax   is the largest wavenumber of the Q-branch lines (cm-1).
    Stot   is the sum of the intensities of the Q-lines (at 296 K in 
	   cm/molecule).
NOTE: Q branches of asymmetric isotopomers involving vibrational angular
      momentum greater than one in the upper and lower levels are
      composed of two "sub-branches" (see paper II). Since there is no
      coupling between these two (only within), they have been separated
      in order to save space and computer time. They are designated
      by their vibrational numbers iVF and iVI (see above) to which
      800 or 900 have been added. As a result, the number of "Q branches"
      in the data base (306) is greater than that of true Q branches (271).
      Note that this is just for convenience and "transparent" for the
      user.

 For each Band, three other Files give information required for
 the spectra computations. For band iVF<--iVI of isotope Isot, their
 names are 'Sabbbccc.DAT', 'Yabbbccc.DAT', and 'Wabbbccc.DAT', where
    a (Char*1) =Isot  , b (Char*3) =iVF, c (Char*3) =iVI
 For example abbbccc=2002001 means band 2<--1 (NU2) of isotope 2 (636)
 (as a result of the splitting into sub-branches explained just above,
 the information on the 2NU2-NU2 Q branch of O(16)-C(12)-O(18) is 
 displayed in two file which with abbbccc=3804802 and 3904902)
 The Files contain the following information:
 
 * 'Sabbbccc.DAT' this File gives spectroscopic information on the
    Q lines, which are : The line position (cm-1), the transition
    dipole element (in cm/molecule**0.5), the population of the
    initial level at 296 K, the energy of the lower state (cm-1),
    the air broadened half-width at 296 K (cm-1/atm), its temperature
    dependence coefficient, and the rotational quantum number J.
    The number of text-lines in this File is (Number_of_Q_lines)
    (Note: the temperature dependence of the half-width is given by:
	HW_at_T = HW_at_296 * (296/T)**Temp_Dep_Coeff
 
 * 'Yabbbccc.DAT' this File gives the first order Line-Mixing 
    parameters (at 296 K, in atm-1) and their temperature dependence
    coefficients. These data are given successively for all Q-lines
    within the considered branch, in the same order as in the File
    'Sabbbccc.DAT'. The number of text-lines in this File is the
    same (Number_of_Q_lines). (Note: the temperature dependence of the
    First-Order Line-Mixing coefficient is given by:
	Y_at_T = Y_at_296 * (1 - Temp_Dep_Coeff*DLOG(296/T) )
 * 'Wabbbccc.DAT' this File gives the Relaxation Operator elements
    (at 296 K, in cm-1/atm) and their temperature dependence
    coefficients. These data (i.e. W0(J',J) and TDepW(J',J) are given
    successively for all couples of lines (J'<J since J'=J is the
    Half-Width and J'>J is computed from detailed balance) ; for
    each J value the J' values are given. The number of text-lines in
    the file is thus (Number_of_Q_lines)*(Number_of_Q_lines - 1) / 2.
    (Note: the temperature dependence of the Relaxation Operator  
    elements is given by:
	W(J',J)_at_T = W(J',J)_at_296 * (296/T)**Temp_Dep_Coeff(J',J)
 
 In SubDirectory /Test_Q     
 .......................
   This SubDirectory contains 2 ASCII Files of Data named 'Test.DAT'
 and 'FileSiz.DAT'.
 * 'Test.DAT' gives some information in order to carry the Test run
   described in chapter VII.
 * 'FileSiz.DAT' gives the number of text lines of all the Data
   files described above. It is used in order to carry the test
   (of correct FTP transfer) described in chapter VII.
 
 
 

 ---------------------------------
 IV. What are the FORTRAN programs
 ---------------------------------
    Important note: please note that ALL REAL and COMPLEX variables
 in the FORTRAN Software are in DOUBLE PRECISION. Also note that 
 the FORTRAN programs need adaptation to run on your computer; the
 necessary changes are described in chapter VI.

 In SubDirectory /Soft_Q     
 .......................
    The SubDirectory /Soft_Q contains 7 FORTRAN SubRoutines that
 were built in order to compute CO2 Q-branch absorption using the
 Data described above. Since a large effort was made in the writing
 of these programs to document them (commentary lines in the 
 Software explaining what variables are and what is going on), only
 a brief description is given here (please look at the programs for
 more details).
 
  * 'DetBand.f' is a SubRoutine which determines which CO2 Q-branches
     should be retained according to the chosen spectral interval. It
     reads Data in the 'BandInf.DAT' File described in chapter III.
  
  * 'ReadQ.f' is a SubRoutine which Reads the Data (in the Files
     'sABBBCCC.dat', 'yABBBCCC.dat' and 'wABBBCCC.dat' decribed in III)
     for the bands selected by SubRoutine 'Detband'.
  
  * 'ConvTP.f' is a SubRoutine which converts the Data read by
     SubRoutine 'ReadQ' to given conditions of temperature and
     total pressure.
  
  * 'EqvLines.f' is a SubRoutine which determines the spectroscopic
     parameters of "equivalent lines" in the framework of the
     Relaxation Operator Model. It uses SubRoutines for the
     diagonalization and inversion of complex Operators WHICH ARE 
     NOT PROVIDED in this package ; they MUST BE FOUND in FORTRAN
     LIBRARIES (such as NAG, IMSL, ..., see chapter VI).

  * 'CompAbs.f' is a SubRoutine which computes the absorption 
     coefficients with the three Models described in chapter I for
     given conditions of temperature and total pressure and for
     a given spectra range and wavenumber step. The Data read by
     'ReadQ' and converted by 'ConvTP' are used.
  
  * 'CPF.f' is a SubRoutine which computes the complex probability
     function which results from the convolution of the Doppler
     and Collisional line shapes.
 
  * 'PFCO2.f' is a Function which computes the total partition 
     function of CO2 for a given Isotope and Temperature.
  
   The way these SubRoutines call each other and the order in which
 they should be called is described below
      .
     .
     I
     I----> DetBand
     I
     I----> ReadQ
     I
     I----> CompABS
     I         I-------> ConvTP
     I         I            I--> PFCO2
     I         I--> CPF     I
     .                      I--> EqvLines
     .                               I--> Matrix Diagonalization
     .                               I
				     I--> Matrix Inversion
		

 In SubDirectory /Test_Q     
 .......................
    The SubDirectory /Test_Q contains Two FORTRAN Main Programs.
They enable checking that the FTP transfer was complete and that
the implementation on your computer has been properly made.
 * 'ChkSiz.f' enables checking that all Data Files have the correct
number of (text) lines. This is a verification of the completeness
of the FTP transfer. Basically this program opens all Data Files,
determines their numbers of text lines and compares them with
pre-stored values. Messages are displayed giving a diagnostic.
See chapter VII on how to run this test.
 * 'Test.f' enables test of the implementation of the Data and
 Software (see chapter VII on how to carry this test). This program
 uses the Data and SubRoutines described above. It computes absorption
 with the three models (Voigt, First-Order L-M, Full L-M) in the
 16 most intense Q-branches. Five spectral points are computed for
 two sets of conditions of Temperature, total pressure, and CO2 mixing
 ratio. The results obtained are compared with the reference values
 which are read in the File 'Test.DAT'. Diagnostic messages are
 writen on the screen and in File 'DIAGNOS.DAT' (which is created).
 A 'problem' message is generated when any of the results differ from
 the reference value by more than 0.01%.
 
 


 -------------------------
 V. Computer Requirements
 -------------------------
     For the Software to Run on your Computer, the latter should
 fulfill the following requirements.
  * Be equipped with a FORTRAN-XX Compiler (XX=77 or 90) 
    NOTE: with some F90 compilers commentary and continuation lines
    may not be understood. You may need to add and Option specifying
    the LineLength to 72 Characters ( -qfixed=72, for instance).
  * Be equipped with the NAG or IMSL Libraries unless you have your
    own routines in order to Diagonalize and Invert complex operators.
    NOTE: If you do not have any of these, contact us since we have
    FORTRAN sources (referred to as the LPMA library in the following)
    that may solve the problem. CAREFULLY Look at chapter VI for
    details on necessary adaptation of our Software according to the
    library used.
 
 Note that the present Data+Software Package was successfully tested
 by running the programs under the following configurations:
  *--------------------------*----------------------*---------------*
  *    Computer / System     *     Compiler         *      LIB      *
  *--------------------------*----------------------*---------------*
  * PC(P200 PRO) / DOS6.2    *  77 NDP              *    NAG,LPMA   *
  * PC(P200 PRO) / WIN-95    *  77 PowerStation 4.0 *   IMSL,LPMA   *
  * Sun SuperSparc / Unix    *  77 Sun 3.0          *   NAG, LPMA   *
  * Sun Sparc 5 / Unix       *  77 Sun              *      LPMA     *
  * Digital  WrkStation/VMS  *  77                  *      LPMA     *
  * IBM AIX (RS6000) / Unix  *  77 and 90 IBM       * NAG,LPMA,IMSL *
  * HP 9000/755 / HP-UX      *  77 HP-UX            *      LPMA     *
  * SG IP19 mips / IRIX      *  77 MIPS             *   LPMA, NAG   *
  * Cray Y-MP EL / Unix      *  77 and 90 CRAY      *  LPMA, IMSL   *
  *--------------------------*----------------------*---------------*

 Chapter VII describes how to test the implementation of the Software
 on your computer once the adaptations (Chapter VI) have been made




 ------------------------------------------
 VI. Adapting the Software to your computer
 ------------------------------------------

    Adapting File Access
    ......................
    The Files Stored in SubDirectory /Data_Q are accessed (Read)
 by SubRoutines 'DetBand.f' and 'ReadQ.f' as well as by the main
 program 'ChkSiz.f'. The Paths, which appear in the OPEN(...)
 FORTRAN Statements are now set to run on the computer where you
 found them (i.e., the Paths ../Data_Q/). You should change them
 according to your computer system and to where you have stored
 the Files in your SubDirectory disk system. In Order to do that
 change the string ../Data_Q/ to the proper path (for instance,
 if the Files are in usr1/yourname/Line_Mixing_Data the Open
 statements in the 'DetBand.f', 'ReadQ.f', and 'ChkSiz.f' should
 be the following, respectively:

  Open(..,File='usr1/yourname/Line_Mixing_Data/BandInf.DAT',..)

  Open(..,File='usr1/yourname/Line_Mixing_Data/S'//cBand//'.dat',..)
  Open(..,File='usr1/yourname/Line_Mixing_Data/Y'//cBand//'.dat',..)
  Open(..,File='usr1/yourname/Line_Mixing_Data/W'//cBand//'.dat',..)

  Open(..,File='usr1/yourname/Line_Mixing_Data/BandInf.DAT',..)
  Open(..,File='usr1/yourname/Line_Mixing_Data/'//FilNam,..)
 

    Adapting to your FORTRAN Library
    ................................
    The SubRoutine 'EqvLines.f' calls two Routines that Diagonalize
 and Invert Operators (Matrixes), respectively. This is done by
 calling routines that are given in commercially available FORTRAN
 LIBRARIES (NAG or IMSL) or by using our own (LPMA) SubRoutines 
 (the latter are not available on the ftp site but ask for them if
 you do not have either NAG or IMSL; note that, to our knowledge,
 the NUMERICAL RECIPES library does not provide complex matrix
 diagonalization). All three possibilities (NAG, IMSL, LPMA) have been
 foreseen in the 'EqvLines' routine which is now set to run with NAG
 but simple changes in the program enable switching to the others. This
 can be done by adding commentary characters (C in first column) in
 front of the FORTRAN Lines associated with NAG and removing the
 commentary characters in front of FORTRAN lines associated with
 the desired Library. This is clearly explained in the 'EqvLines.f'
 FORTRAN program.
 

    Adapting to CRAY Computers
    ..........................
    On CRAY Computers (and, maybe some others) the simple precision
 corresponds to double precision (Real*8) on most other computers and
 they do not support Double Complex Variables. In this case, some
 modifications should be made in the 'EqvLines.f' SubRoutine (and
 in the LPMA inversion and diagonalization routines), which are:
  - Replace 'Double Complex' by 'Complex' in the variables type
    definitions
  - Replace all Double Complex Intrinsic Functions by their Simple
    Complex equivalents (i.e. replace DCMPLX, DREAL, and DIMAG by
    CMPLX, REAL, and AIMAG, respectively).
  - If the IMSL Library is used, take off the 'D' letter of the names
    of the diagonalization and inversion routines (i.e., replace
    DEVCCG and DLINCG by EVCCG and LINCG, respectively)
 
 
  
 ------------------------------------------------
 VII. Testing the implementation on your computer
 ------------------------------------------------
   
   Testing the FTP transfer
   ........................
   As said previously, the File 'FileSiz.DAT' stored in SubDirectory
 /Test_Q gives the number of lines in each of the DATA files stored
 in SubDirectory /Data_Q. In order to check that all these files 
 contain the right number of lines proceed as described below.
 (1) First change the access paths to the files in the main program
 'ChkSiz.f' according to your own computer system (see Chapter VI).
 (2) Compile and run the 'ChkSiz.f' program. A diagnostic is displayed
 on the screen. In cases where some files are incomplete, look at
 the File 'SizChk.DAT'. You will find there the names of the
 incomplete files... that you have to FTP again.
 
   Testing the Software Adaptation
   ...............................
   The program 'Test.f' and Data File 'Test.DAT' that are given in
 SubDirectory /Test_Q enable checking that the Software adaptations 
 described in Chapter VI have been properly done and that the
 programs run correctly. Indeed, Running 'Test.f' should lead to
 the results stored in 'Test.DAT'. In order to check it, please do
 the following: 
  (1)  Adapt the Access to File='Test.DAT' in the OPEN(......)
 statement in program 'Test.f' according to your computer system
 (The Unit used is 10). Note that an other File is Opened (Unit=11)
 in order to write the messages giving a diagnostic on the test; its
 name is 'DIAGNOSC.DAT' and it is created when running the program.
  (2)  Compile and Link the Main program 'Test.f' together with the
 entire Set of SubRoutines stored in /SOFTW_Q and the FORTRAN Library
 (NAG, IMSL, LPMA, see chapter VI) that you use.
  (3)  Then Run 'Test'. This program will carry some computations and 
 compare the results with those stored in 'Test.Dat' (see chapter IV).
 "OK" or "PROBLEM" messages are displayed on the screen (Unit=*) giving
 you a diagnostic. These messages are also writen in the 'DIAGNOS.DAT'
 File at the bottom of which the result of the total test is displayed.
 Thus, after running the 'Test' program, check the 'DIAGNOS.DAT' File.
 
 
 
 
 -----------------------------------------------
 VIII. Adapting your Atmospheric Absorption Code
 -----------------------------------------------
    BEFORE YOU START including the proposed Software in your 
 computer Code that calculates atmospheric absorption/emission,
 YOU SHOULD HAVE MADE the adaptations described in chapter VI
 and checked that the programs 'ChkSiz' and 'Test' run properly
 (chapter VII).
 
 
 Elementary First checks   
 .......................
    While including our Software in you FORTRAN program, DO
 REMIND that:
 (1) All variables (real and complex) in our programs are in DOUBLE
     PRECISION and should be declared as so when used in your Code.
     (see chapter VI for the case of computers, such as CRAY, that
     do not support Double Complex variables).
 (2) Our programs read in Files, which are accessed through an Open 
     statement with a Unit number defined by the variable "iFile"
     (i.e., OPEN(Unit=iFile,File=....)). The value of iFile is set
     to iFile=3 and is used for all Files since they are opened and
     closed one after the other. YOU SHOULD CHECK That Unit=3 is not
     used at the same time by your Code. If there is a conflict,
     just change iFile=3 to any appropriate number in all Parameter
     statements of our Software (iFile is define twice, in
     SubRoutines 'DetBand' and 'ReadQ').
 (3) Our programs use a number of COMMON statements, each of which
     has a name. YOU SHOULD CHECK that identical COMMON names are
     not used in both your Code and our programs (it would certainly
     be bad luck, but if it were the case, just change the
     corresponding name either in your or our Software).
 (4) Similarly, some variables need to be transferred from our
     SubRoutines to your program (calculation choices and results,
     as explained in the following part of this chapter). This is
     done either by COMMON statement or through the arguments appearing
     in the SubRoutine when called. YOU SHOULD CHECK that identical
     variables names are not used in both your Code and our programs
     it would be bad luck, but if it is the case, just change the
     corresponding name either in your or our Software).

 
 What we assume about you Code   
 .............................
    In order to try to help you in modifying your computer Code in
 order to account for Line-Mixing effects in CO2 Q-branches using our
 Data and Software, we need to assume a few things concerning the
 architecture and principles of your Code. Those that we have assumed
(hopefully they are reasonable and realistic) are detailed below:
  - Up to now your Code was computing absorption by CO2 Q-lines 
    assuming that they have a Voigt profile
  - Somewhere near the beginning of your program, you choose 
    the wavenumber range (SigMinC, SigMaxC) and Step (DSig) in which
    you are going to carry spectra computations.
  - Somewhere near the beginning of your program, after choosing
    the wavenumber range, you read spectroscopic Data from a Database
    such as HITRAN.
  - You then treat the atmospheric path, Layer-By-Layer.
  - For each of the layers, you convert the spectroscopic Data to
    the conditions (temperature, pressure, ..) of the considered layer.
  - Then you compute the absorption coefficient in the considered
    layer for all wavenumbers of the computation
 
 How to adapt your Code
 ......................
    The modifications you need to make to adapt your Code are the
 following. NOTE that looking at the commentary lines of the
 FORTRAN SubRoutines proposed may be helpful in understanding
 the suggestions given below
 
 (1) In the program or SubRoutine where the wavenumber range in
     which calculations are to be made is chosen, add the FORTRAN line:
	    Call DetBand(SigMinR,SigMaxR,Scut)
     where SigMinR and SigmaxR are Min and Max wavenumbers (cm-1) in
     which the spectroscopic Data are selected (slightly less and more
     than the edges SigMinC and SigMaxC of the computation interval).
     Scut is a total Q-branch intensity cut-off (cm/molecule) ; only 
     Q-branches that have a total intensity at 296 K greater that Scut
     are retained so that Scut=0.d0 selects all Q-branches (see the
     IMPORTANT REMARK ABOUT Scut in chapter IX).
 
 (2) Just after calling DetBand, add the FORTRAN line
	    Call ReadQ
 
 (3) In the SubRoutine where each of the layers is treated and
     absorption coefficients are computed, add the FORTRAN line

	    Call CompAbs(Temp,Pressure,xCO2,SigMinC,SigMaxC,DSig)

     where SigMinC, SigMaxC, and DSig are the Min, Max, and step
     of the wavenumber range in which computation is to be made (cm-1).
     Temp, Pressure, and xCO2 are the temperature (K), TOTAL pressure
     (atm) and CO2 volume mixing ratio in the current layer treated.
	 The results are given in the Arrays AbsV, AbsY, and AbsW which
     are absorption coefficients within the Voigt, First-Order Line
     Mixing or Full Line-Mixing models respectively. They are in cm-1
     and should thus be multiplied by the length of the path within the
     layer (in cm). (the transmission of the layer is then given by
     TransmissionVoigt(iSig)=DEXP( -AbsV(iSig) * Length_of_path ) for
     Line-Mixing Models, respectively. There are N values associated
     with wavenumbers from SigMinC to SigMaxC by step of DSig, with
     NSig=INT((SigMaxC-SigMinC)/DSig)+1. AbsW(iSig) is thus the Voigt
     absorption coefficient for wavenumber SigMinC + (iSig-1)*DSig
     the Voigt model, for instance).
	  In order to be able to use the results, at the top of the
     routine where you wish to use the results of the computation in
     the current layer, add the FORTRAN lines:

	    Integer nSigmx
	    Double Precision AbsV,AbsY,AbsW
	    Parameter (nSigmx=20000)
	    Common/CabsV/AbsV(nSigmx)
	    Common/CabsFirst/AbsY(nSigmx)
	    Common/CabsW/AbsW(nSigmx)
 
 (4) Your computer Code very likely already computes absorption by 
     CO2 Q-lines (with a Voigt profile). In order to be able to 
     compute their absorption with our approach two ways are possible
       *  The first is simply to remove all CO2 Q-lines from your
     computation (either removing them from the file which contains
     the spectroscopic DataBase that you use, or not retaining them
     while reading the DataBase). In this case, if AbsYours(iSig) is
     the absorption coefficient that you compute (all lines besides
     CO2 Q-lines) for wavenumber index iSig, the full absorption
     coefficients within the considered layer will be given by:

	AbsTotalV(iSig)= AbsYours(iSig) + AbsV(iSig) ,
	AbsTotalY(iSig)= AbsYours(iSig) + AbsY(iSig) , and
	AbsTotalW(iSig)= AbsYours(iSig) + AbsW(iSig) ,
     
     within the Voigt, First-Order Line-Mixing, and Full Line-Mixing
     models, respectively.
       *  The second is to still compute CO2 Q-lines contribution as 
     you did before and to use our Voigt computation to remove them.
     This is to say, with the same notations as above,

	AbsTotalV(iSig)= AbsYours(iSig) ,
	AbsTotalY(iSig)= AbsYours(iSig) + ( AbsY(iSig) - AbsV(iSig) ) ,
	AbsTotalW(iSig)= AbsYours(iSig) + ( AbsW(iSig) - AbsV(iSig) )
     
     This solution, although it assumes that Your Voigt computation and
     Ours lead to the same results, may be easier to implement.
 
 VERY IMPORTANT REMARKS: 
 **********************
  *  The absorption coefficients are due to the contribution of CO2 
     Q-lines only but your code should be able to predict contributions
     of P and R lines as well as those of other absorbing molecules).
  *  The SubRoutine 'Detband' automatically selects the Q-branches that
     are accounted for, according to your choice of SigMinR, SigMaxR,
     Scut. The Max number of Q-branches that can be retained is fixed
     by the variable nBmx which determines the sizes of arrays used
     for storage. A value is assigned to the variable nBmx through the
     Parameter (nBmx=...) FORTRAN Statement. In cases were this value
     is too low for the chosen computation, the program will stop and
     a message will be writen on the screen (Unit=*). You then need
     to raise the value of nBmx in ALL the Parameter Statements where
     it appears (i.e. in Subroutines 'DetBand', 'ReadQ', 'ConvTP',
     'EqvLines', and 'CompAbs'). Note that taking the minimum
     acceptable value for nBmx saves memory.
  *  The number of spectral points that will be computed by the
     'CompAbs' SubRoutine is NSig=INT( (SigMaxC-SigMinc)/DSig ) + 1
     where SigMaxC, SigMinC, and DSig have been chosen by the user.
     The dimension of the arrays (AbsV, AbsY, and AbsW) in which
     results are stored is fixed by the variable nSigmx whose
     value is set by the Parameter (nSigMx=...) FORTRAN Statement
     in SubRoutine 'CompAbs'. If NSig exceeds Nsigmx, the program
     will stop, displaying a message on the screen. In this case
     you should raise the value of nSigmx. Note that taking the
     minimum acceptable value for nSigmx saves memory.
 
 


 --------------------------------------
 IX. Some Important Suggestions for CPU
 --------------------------------------
     Computations accounting for Line-Mixing require quite important
 CPU time since ALL Q-lines (or NONE) must be accounted for each
 wavenumber. IT IS thus IMPOSSIBLE to TRUNCATE the summation over 
 the Q-lines to the "nearest" ones. It is thus quite essential to
 adjust the software and computation choices as well as possible.
 Below are given a number of suggestions in order to do that.
  (1) The program makes a Voigt, a First-Order Line-Mixing and a
      Full Line-Mixing computations. It may not be useful to keep all
      of them (particularly the last two). You may thus remove one of
      them (its should not be too complicated since the software is
      well documented by commentary lines/ E-mail us if you need help).
      NOTE that we would suggest to keep the Full Line-Mixing model
      rather than the First-Order one since the latter results from
      an approximation which is not always valid (see PAPER). The
      Full Line-Mixing model requires more memory but involves only
      a little more CPU time.
  (2) The CPU time required to compute Q-branches absorption is almost
      proportional to the number of Q-branches retained (as is the
      memory). Choosing the Q-branches in which Line-Mixing is to
      be accounted for, depending on the computation choices (range,
      temperature, ...), is thus essential. This can be done using the
      Scut variable which is used by SubRoutine 'DetBand'. Note that
      you may even save more CPU by keeping your Voigt computation for
      some weak Q-branches and only using our Software for the few 
      (generally one or two) most important ones.
  (3) Our model uses the impact approximation and is thus not valid
      further than about 5 cm-1 away from the Q-lines (see chapter I).
      The Spectral range in which computations are made should thus not
      be too large. By the way, reducing it likely reduces the number
      of Q-branches accounted for and thus saves CPU and memory.
  (4) OUR SOFTWARE HAS NOT (at all) BEEN OPTIMIZED. In particular
      the method used to compute the complex Voigt shape (see 'CPF.f')
      can likely be significantly improved. We also have some other
      possibilities in mind but have not optimized the software in
      order to keep it clear. In case you are interested by a strong
      CPU optimization, do contact us since we have some ideas.
  
		
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   !!                                                              !!
   !!             We WISH YOU a FINE and efficient WORK            !!
   !!     Please DO NOT HESITATE to CONTACT US for assistance.     !!
   !!                                                              !!
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



---------------------------------------------------------------------
     Below is information on the papers directly connected
		 with the present work
	       (ask for reprints if you wish)

		     ------------------

   Model, Software, and DataBase for Computation of Line-Mixing
       Effects in InfraRed Q-Branches of Atmospheric CO2
		I. Symmetric Isotopomers.

 By:  R. Rodrigues, K.W. Jucks, N. Lacome, Gh. Blanquet, 
      J. Walrand, W.A. Traub, B. Khalil, R. Le Doucen,
      A. Valentin, C. Camy-Peyret, L. Bonamy, and 
      J.-M. Hartmann

 Published in: JQSRT vol. 61, pp. 153-184, 1999
 Size: 4 Tables, 24 Figures, 31 pages


 ABSTRACT:   A theoretical model based on the Energy Corrected Sudden
 approximation is used in order to account for line-mixing effects in
 infrared Q-branches of symmetric isotopomers of CO2. Its performance
 is demonstrated by comparisons with a large number of (about 130)
 CO2-N2 and CO2-O2 laboratory spectra recorded by several instrument
 setup: nine Q-branches of different vibrational symmetries lying
 between 4 and 17 microns are investigated in wide ranges of pressure
 (0.05-10 atm) and temperature (200-300 K). The model is used to generate
 a set of suitable parameters and FORTRAN software (available by ftp) for
 the calculation of the absorption within 12C16O2, 13C16O2, and 12C18O2
 infrared Q-branches under atmospheric conditions, which can be easily
 included in existing radiance/transmission computer codes. Comparisons
 are made between many (about 280) computed atmospheric spectra and values
 measured using two different balloon-borne high resolution Fourier
 transform instruments: transmission (solar occultation) as well as
 radiance (limb emission) measurements of seven Q-branches between 12 and
 17 microns for a large range of atmospheric air masses and pressure/
 temperature conditions  have been used, including the NU2 band of both
 12C16O2 and 13C16O2. The results confirm the need to account for the
 effects of line-mixing and demonstrate the capability of the model to
 represent accurately the absorption in regions which are often used for
 temperature/pressure sounding of the atmosphere by space instruments.
 Finally, quantitative criteria assessing the validity of the widely
 used Rosenkranz first-order approximation are given.
 
		     ------------------

   Model, Software, and DataBase for Computation of Line-Mixing
       Effects in InfraRed Q-Branches of Atmospheric CO2
	   II. Minor and Asymmetric isotopomers.

 By: K.W. Jucks, R. Rodrigues, R. Le Doucen, C. Claveau, W.A. Traub,
     and J.-M. Hartmann 

 Published in: should appear in JQSRT near June 1999
 Size: 2 Tables, 13 Figures, 18 pages

 ABSTRACT: The influence of line-mixing on the shape of infrared Q 
 branches of minor isotopomers of CO2 is studied for the first time. 
 Laboratory spectra of isotopically enriched CO2-N2 mixtures have been 
 measured in the 15 mm region at the temperatures of 200 and 300 K for 
 total pressures between 1 and 10 atm. Comparisons with measurements for 
 the nu2 and (nu1-nu2)I Q branches of the six isotopomers 
 (16, 17, or 18)O-12C-O(16, 17, or 18) demonstrate the quality of the 
 theoretical approach presented in the preceding paper (Part I). 
 The model is used to generate a set of numerical data (available by ftp) 
 for the prediction of absorption by 16O12C18O, 16O12C17O, 16O13C18O, 
 16O13C17O, and 17O12C18O infrared Q branches under atmospheric conditions; 
 this database completes that proposed in the preceding paper and now 
 includes 271 bands considering the eight most abundant CO2 isotopomers. 
 Its quality is tested by comparisons with atmospheric limb emission 
 measured by a balloon-borne high resolution Fourier transform instrument. 
 The nu2 Q branches of  16O12C16O, 16O13C16O, 16O12C17O, and 16O12C18O 
 recorded above Alaska have been used. This shows that line mixing has 
 significant effects, even for minor isotopomers, and is correctly 
 accounted for by the model and data proposed.
		     ------------------
