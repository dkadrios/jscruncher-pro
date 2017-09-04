// Version 3.10
// February-23-2005

unit Protection;

//***********
	interface
//***********

//const
//	ProductKey = 'P0001238-QAB:CM+Ico+RaTeJ6YbtKYjWLCuJ9DOTJVoFLfoyAFYnbIUVVhupwxzwexD5Yrdka+N73ZtuybhWVnn7LA3Yu3Byo5';

function DNA_ProtectionOK_API:integer;
//function DNA_ProtectionOK_SOURCE:integer;
function GetErrorMsg(err:integer):string;

//****************
	implementation
//****************

uses
	Activation_code,Reactivate,Activate,Controls,Inifiles,DNA_INT,SysUtils,
  protection_inc, darin_md5;

var
	ExePath:string;


function GetErrorMsg(err:integer):string;
var
	msg:array[0..127] of char;
begin
	DNA_Error(err,msg,sizeof(msg));
  result:=string(msg);
end;

function DNA_ProtectionOK_API:integer;
//var
 // md5:string;
begin
  if( getFileMD5(EXEPATH + 'DNA.dll') <> unShuffledMD5() ) then begin
  	result := ERR_INVALID_CDM;
    exit;
  end;

  result:=DNA_ProtectionOK( pchar( ProductKey() ) ,1 ,0 );
end;
(*
function DNA_ProtectionOK_SOURCE:integer;
var
  frm_AC:TFActivation_code;
	frm_REA:TFReactivate;
	frm_ACT:TFActivate;
  code,pass,new,email:string;
  err:integer;
  md5:string;
begin
	//***********************
	//
	//		Code that implements DNA Client authentication and
	//		the DNA_Validate API Call
	//
	//		This code would be located in your main routine executed during start up
	//    of program
	//
	//
	//
	//		Step 1: Authenticate DLL using MD5
	//
	//    	- unshuffle MD5 using your own shuffle function
	//      - calculate the MD5 of DLL on user's computer using HashFileMD5
	//      - compare MD5 Hash Codes
	//      - if no match, then setup DEMO Mode or EXIT the program
	//
	//***********************

  md5:=MD5Print(MD5File(EXEPATH+'DNA.DLL'));
  if md5<>unShuffledMD5 then begin
  	result:=ERR_INVALID_CDM;
    exit;
  end;

	//***********************
	//
	//		Step 2: Attempt to Validate
	//
	//			- if successful (err=0), then continue main program
	//      - if err <=0, then Level 3 warning, display warning to user and continue program
	//			- if err > 0, then need to determine next steps
	//
	//***********************

  err:=DNA_Validate(ProductKey);

  if err=0 then begin
  	result:=err;
    exit;
  end;

  if err<0 then begin
		//******************
		//
		//		For Level 3 protection only
		//		code here to pop up a window or message to inform user that he must
		//		connect to the Internet and validate before <date>
		//		<date> is retrieved using DNA_Error API Call
		//
		//******************

  	result:=err;
  	exit;
  end;

	//***********************
	//
	//		Step 3: Is this an Activation or Re-activation ?
	//
	//			- get the Activation Code from the user
	//			- check with server if activation code is new or not using DNA_Query
	//			- if Reactivation, get info and re-activate
	//			- warn the user if this is a duplicated password
	//			- if Activation, get info and activate
	//
	//      If any errors in Activation, or Re-activation, goto DEMO Mode or exit
	//
	//***********************

  //** code here to pop up a window asking for Activation Code

  frm_AC:=TFActivation_code.create(nil);
  try
  	if frm_AC.Showmodal=mrOk then
	  	code:=frm_AC.Activation_code.text
    else begin
	  	result:=ERR_OPERATION_FAILED;
      exit;
    end;
  finally
  	frm_AC.free;
  end;

  err:=DNA_Query(ProductKey,pchar(code));

	if err=ERR_REACTIVATION_EXPECTED then begin

  	//***************
    // Reactivation
		//***************

		//** code here to pop up a window asking for existing password and new
		//** password

  	frm_REA:=TFReactivate.create(nil);
    frm_REA.Activation_code.text:=code;

		try
			if frm_REA.Showmodal=mrOk then begin
      	pass := frm_REA.password.text;
        new	 := frm_REA.new_password.text;
      end
	    else begin
		  	result:=ERR_OPERATION_FAILED;
	      exit;
	    end;
    finally
    	frm_REA.free;
    end;
    err:=DNA_Reactivate(ProductKey,pchar(code),pchar(pass),pchar(new));
  end
  else begin

		//*************
    // Activation
		//*************

		//** code here to pop up a window asking for a password and
		//** an optional email address (for resend of lost passwords)

		frm_ACT:=TFActivate.create(nil);
    frm_ACT.Activation_code.text:=code;

    try
    	if frm_ACT.Showmodal=mrOk then begin
      	pass	:= frm_ACT.password.text;
        email	:= frm_ACT.email.Text;
      end
	    else begin
		  	result:=ERR_OPERATION_FAILED;
	      exit;
	    end;
    finally
    	frm_ACT.free;
    end;
    err:=DNA_Activate(ProductKey,pchar(code),pchar(pass),pchar(email));
  end;

  result:=err;
end;*)

initialization
	ExePath:=ExtractFilePath(ParamStr(0));
end.


