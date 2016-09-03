unit userscript;

//We start with the Initialize; function.
//Call SetUpFileVars; to choose which master .esm we're working with.
//Call SetUpOurVars, to choose the right dialog list after picking the master file, as well as count the entries in the list.


//We then call StartTheMainProcess;, where we will now sort through each entry in the list. We do so by putting everything in a master loop.
//We shove the loop counter (how many times the loop as run) into another variable, to keep things individualized and readable.

//	Call GetDataFromFileName to get the FormID, from the filename in the list @ the current loop pass number.
//			This procedure calls FixFormIDString; at the end of it, correcting the load order of the filename's FormID.

//The main loop then calls GetTheDialogRecord;, to get the record from our final FormID, and chucks the raw response text into sDialogFromRecord.

//Now we call FixUnneededFullStop;
//	This repeatedly calls GetFullStop;, which checks if the last character is a fullstop.
//If the last character is a fullstop, according to the nested procedure, FixUnneededFullStop; will then repeatedly delete the last char
//and call GetFullStop;, until the last char isn't a fullstop.

//Then, we call RemoveSubstrings;, to remove meta comments from the dialog text. These are denoted by [], (), and {}

//After that, we use the procedure CallSanitizeStringCharacters;, which calls SanitizeStringCharacters; in a loop, removing invalid filename chars.

//Then we use FixEmptyDupeText to add an incremental number to every empty filename.

//Finally, we add the result to the TStringList, which we save to a file.



var
	
	iNumDialogFiles, iFileNameLength, iFormID: integer;
	
	iResponsePos1, iResponsePos2, iResponseNum: integer;
	
	iLengthOfText: integer;
	
	iBracketPosOpen, iBracketPosClose: integer;
	
	iMainLoopCounter, iIndexInList: integer;
	
	iFullstopPos: integer;
	
	iStringLength: integer;
	
	iNumBracketChars, iStringCounter, iBlankDupePrefix, iDeadRepeatLoop: integer;
	
	
	
	sTextFileToLoad, sTextFileToSaveTo, sFileName, sFormID, sRenamePairToAdd: string;
	
	sDialogFromRecord: string;
	
	sLastCharOfText: string;
	
	sOldStringBeforeDeletedChars: string;
	
	sSubstringToRemoveFromDialog: string;
	
	
	
	fileFNVesm, fileDeadMesm, fileHHesm, fileOWBesm, fileLResm: IInterface;
	
	eDialogRecord, eResponse, eResponseText: IInterface;
	
	
	tListOfFiles, tFinalList: TStringList;
	
	bDebug, bdoFNV, bdoDeadM, bdoHH, bdoOWB, bdoLR: boolean;
	
	bGenericBool, bBreakFullstopCheck, bBracketPosCheck, bBracketLoopEscape: boolean;
	
	
	

procedure SetUpFileVars; // Preliminary stuff, get our file vars all geared up
begin

	bDebug := true;

	fileFNVesm := FileByIndex(0);
	AddMessage(GetFileName(fileFNVesm)); // Fallout New Vegas
	
	fileDeadMesm := FileByIndex(2); // We skipped '1' as that refers to FalloutNV.exe
	AddMessage(GetFileName(fileDeadMesm)); // Dead Money
	
	fileHHesm := FileByIndex(3);
	AddMessage(GetFileName(fileHHesm)); // Honest Hearts
	
	fileOWBesm := FileByIndex(4);
	AddMessage(GetFileName(fileOWBesm)); // Old World Blues
	
	fileLResm := FileByIndex(5);
	AddMessage(GetFileName(fileLResm)); // Lonesome Road
	
	bdoFNV := true;
	bdoDeadM := false;
	bdoHH := false;
	bdoOWB := false;
	bdoLR := false;
	
	AddMessage('.esm File variables are ready!');
	
end;

procedure SetUpOurVars; // More preliminary stuff. Make sure to set the paths correctly!
begin

	if bdoFNV = true then begin
	
		tListOfFiles := TStringList.Create;
		sTextFileToLoad := 'Z:\0fnvRen\fnv\ListOfFiles.txt';
		tListOfFiles.LoadFromFile(sTextFileToLoad);
	
		tFinalList := TStringList.Create;
		sTextFileToSaveTo := 'Z:\0fnvRen\fnv\DialogRenamePairs.txt';
	
	end;

	if bdoDeadM = true then begin
	
		tListOfFiles := TStringList.Create;
		sTextFileToLoad := 'Z:\0fnvRen\deadmon\ListOfFiles.txt';
		tListOfFiles.LoadFromFile(sTextFileToLoad);
	
		tFinalList := TStringList.Create;
		sTextFileToSaveTo := 'Z:\0fnvRen\deadmon\DialogRenamePairs.txt';
	
	end;
	
	if bdoHH = true then begin
		
		tListOfFiles := TStringList.Create;
		sTextFileToLoad := 'Z:\0fnvRen\honhear\ListOfFiles.txt';
		tListOfFiles.LoadFromFile(sTextFileToLoad);
	
		tFinalList := TStringList.Create;
		sTextFileToSaveTo := 'Z:\0fnvRen\honhear\DialogRenamePairs.txt';
	
	end;
	
	if bdoOWB = true then begin
	
		tListOfFiles := TStringList.Create;
		sTextFileToLoad := 'Z:\0fnvRen\oldblue\ListOfFiles.txt';
		tListOfFiles.LoadFromFile(sTextFileToLoad);
	
		tFinalList := TStringList.Create;
		sTextFileToSaveTo := 'Z:\0fnvRen\oldblue\DialogRenamePairs.txt';
	
	end;
	
	if bdoLR = true then begin
	
		tListOfFiles := TStringList.Create;
		sTextFileToLoad := 'Z:\0fnvRen\loneroad\ListOfFiles.txt';
		tListOfFiles.LoadFromFile(sTextFileToLoad);
	
		tFinalList := TStringList.Create;
		sTextFileToSaveTo := 'Z:\0fnvRen\loneroad\DialogRenamePairs.txt';
	
	end;
	
	
	iNumDialogFiles := tListOfFiles.Count;
	
	AddMessage('Lists are ready!');
	
end;


procedure FixFormIDString;
begin
	
	if bdoDeadM = true then begin
		Delete(sFormID, 1, 1);
		Insert('1', sFormID, 2);
	end;
			
	if bdoHH = true then begin
		Delete(sFormID, 1, 1);
		Insert('2', sFormID, 2);
	end;
		
	if bdoOWB = true then begin
		Delete(sFormID, 1, 1);
		Insert('3', sFormID, 2);
	end;
		
	if bdoLR = true then begin
		Delete(sFormID, 1, 1);
		Insert('4', sFormID, 2);
	end;
	
	if bDebug = true then
		AddMessage('Text FormID is '+sFormID+' 2nd pass');
	
end;


procedure GetTheDialogRecord; // Another procedure to loop, follows the above 'un
begin

	if bdoFNV = true then
		eDialogRecord := RecordByFormID(fileFNVesm, iFormID, true);
	
	if bdoDeadM = true then
		eDialogRecord := RecordByFormID(fileDeadMesm, iFormID, true);
		
	if bdoHH = true then
		eDialogRecord := RecordByFormID(fileHHesm, iFormID, true);
		
	if bdoOWB = true then
		eDialogRecord := RecordByFormID(fileOWBesm, iFormID, true);
	
	if bdoLR = true then
		eDialogRecord := RecordByFormID(fileLResm, iFormID, true);
		
	
	if bDebug = true then
		AddMessage('The FormID of the dialogue record is: '+IntToHex(FormID(eDialogRecord), 8));
	
	eResponse := ElementByIndex(ElementByPath(eDialogRecord, 'Responses'), iResponseNum - 1);
	
	if bDebug = true then
		AddMessage('Got the response');
		
	eResponseText := ElementByPath(eResponse, 'NAM1 - Response Text');
		
	sDialogFromRecord := GetEditValue(eResponseText);
	
	if bDebug = true then
		AddMessage('Dialog to write is: '+sDialogFromRecord);
		
end;


procedure GetFullStop;
begin
	iLengthOfText := Length(sDialogFromRecord);
	
	if iLengthOfText = 0 then
		exit;
	
	sLastCharOfText := sDialogFromRecord[iLengthOfText];
	iFullstopPos := pos('.', sLastCharOfText);
	bGenericBool := iFullStopPos <> 0
end;

procedure FixUnneededFullStop;
begin
	
	if bDebug = true then
		AddMessage('Calling GetFullStop;');
	
	GetFullStop;
	
	if bGenericBool = true then
		repeat
			
			if bDebug = true then
				AddMessage('Deleting Fullstop');
			
			if iLengthOfText = 0 then
				exit;
			
			Delete(sDialogFromRecord, iLengthOfText, 1);
			GetFullStop;
			
		until iFullStopPos = 0;
		
	if bDebug = true then;
		AddMessage('Fixed Fullstop')

end;


procedure GetDataFromFilename; // One of the procedures to be looped
begin

	sFileName := tListOfFiles[iIndexInList]; // Text viewers start at line 1, Pascal starts at line 0
	iFileNameLength := Length(sFileName);
	
	iResponsePos1 := iFileNameLength - 4;
	iResponsePos2 := iFileNameLength - 5;
	
	if sFileName[iResponsePos2] = '_' then begin // Check if response is only 1 digit, if it is, the char will be _
		
		if bDebug = true then
			AddMessage('Filename is: '+sFileName);
	
		if bDebug = true then
			AddMessage('Response is one digit!');
	
		iResponseNum := StrToInt(sFileName[iResponsePos1]);
		
		if bDebug = true then
			AddMessage('Response Number is: '+sFileName[iFileNameLength - 4]);
		
		sFormID := copy(sFileName, iFileNameLength - 13, 8);
		
		if bDebug = true then
			AddMessage('Text FormID is '+sFormID);
		
		FixFormIDString; // Check the master file booleans, modify the FormID string appropriately.
		
		iFormID := StrToInt('$'+sFormID);
		
		if bDebug = true then
			AddMessage('FormID to integer is '+IntToStr(iFormID));
			
	end;
	
	if sFileName[iResponsePos2] <> '_' then begin // If the response is 2 digits, the char won't be _
		
		if bDebug = true then
			AddMessage('Filename is: '+sFileName);
		
		if bDebug = true then
			AddMessage('Response is two digits!');
	
		iResponseNum := StrToInt(copy(sFileName, iResponsePos2, 2));
		
		if bDebug = true then
			AddMessage('Response Number is: '+sFileName[iFileNameLength - 5]);
		
		sFormID := copy(sFileName, iFileNameLength - 14, 8);
		
		if bDebug = true then
			AddMessage('Text FormID is '+sFormID);
			
		FixFormIDString;
		
		if bDebug = true then
			AddMessage('Text FormID is '+sFormID+' 2nd pass');
		
		iFormID := StrToInt('$'+sFormID);
		
		if bDebug = true then
			AddMessage('FormID to integer is '+IntToStr(iFormID));
			
	end;
	
end;


procedure RemoveSubstrings(pstringOpenCharToCheck, pstringClosedCharToCheck: string;);
begin
	//Do a bunch of passes to make sure we remove the unwanted text. If it isn't present, the string won't be changed
	
	iBracketPosOpen := Pos(pstringOpenCharToCheck, sDialogFromRecord);
	iBracketPosClose := Pos(pstringClosedCharToCheck, sDialogFromRecord);
  bBracketPosCheck := false;
	bBracketLoopEscape := false;
	
	if bDebug = true then begin
		AddMessage('Open bracket is @ index '+inttostr(iBracketPosOpen));
		AddMessage('Closed bracket is @ index '+inttostr(iBracketPosClose));
	end;
	
	if iBracketPosOpen = 0 then
		if iBracketPosClose = 0 then
			bBracketLoopEscape := true;
	
	if iBracketPosOpen > 0 then
		if iBracketPosClose > 0 then
			bBracketPosCheck := true;
	
	
	if bBracketPosCheck = true then
		repeat
		
		iBracketPosOpen := Pos(pstringOpenCharToCheck, sDialogFromRecord);
		iBracketPosClose := Pos(pstringClosedCharToCheck, sDialogFromRecord);
		
		if bDebug = true then
			AddMessage('Open bracket is at index: '+IntToStr(iBracketPosOpen));
			
		if bDebug = true then
			AddMessage('Open bracket is at index: '+IntToStr(iBracketPosClose));
		
		iNumBracketChars := (iBracketPosClose - iBracketPosOpen) + 1;
		
		sSubstringToRemoveFromDialog := copy(sDialogFromRecord, iBracketPosOpen, iNumBracketChars);
		sDialogFromRecord := StringReplace(sDialogFromRecord, sSubstringToRemoveFromDialog, '', 00);
		AddMessage('Substring removed! Dialog is: ');
		AddMessage(sDialogFromRecord);
		
		iBracketPosOpen := Pos(pstringOpenCharToCheck, sDialogFromRecord);
		iBracketPosClose := Pos(pstringClosedCharToCheck, sDialogFromRecord);
		
		if bDebug = true then
			AddMessage('Open bracket is at index: '+IntToStr(iBracketPosOpen));
			
		if bDebug = true then
			AddMessage('Open bracket is at index: '+IntToStr(iBracketPosClose));
		
		{if bDebug = true then
			sleep(2000);}
		
		if iBracketPosOpen = 0 then
			if iBracketPosClose = 0 then
				bBracketLoopEscape := true;
		
		until bBracketLoopEscape = true;
	
	
	if bDebug = true then begin
		AddMessage('Final dialog is: '+sDialogFromRecord);
		//sleep(2000);
	end;
	
	Inc(iDeadRepeatLoop);
end;


procedure FixEmptyDupeText;
begin
	if sDialogFromRecord = '.ogg' then begin
		sDialogFromRecord := IntToStr(iBlankDupePrefix)+'.ogg';
		iBlankDupePrefix := iBlankDupePrefix + 1;
		AddMessage('Fixed dupe text!');
	end;
end;


procedure SanitizeStringCharacters; // Check every character in the dialog, see if they're fucky. if they are, change 'em and start from the previous char.
begin
		
		if sDialogFromRecord[iStringCounter] = 'á' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('a', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'Á' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('A', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'é' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('e', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'É' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('E', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'í' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('i', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'Í' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('I', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'ó' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('o', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'Ó' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('O', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'ú' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('u', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = 'Ú' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('U', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = '*' then begin 
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('#', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = '{' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('(', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = '}' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert(')', sDialogFromRecord, iStringCounter);
			exit;
		end;
		
		if sDialogFromRecord[iStringCounter] = '<' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('(', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = '>' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert(')', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = '\' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('(', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = '/' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert(')', sDialogFromRecord, iStringCounter);
			exit;
		end;
		
		if sDialogFromRecord[iStringCounter] = '|' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('_', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = ':' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert(';', sDialogFromRecord, iStringCounter);
			exit;
		end;
		
		if sDialogFromRecord[iStringCounter] = '?' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert(',', sDialogFromRecord, iStringCounter);
			exit;
		end;
			
		if sDialogFromRecord[iStringCounter] = '"' then begin
			Delete(sDialogFromRecord, iStringCounter, 1);
			Insert('''', sDialogFromRecord, iStringCounter);
			exit;
		end;
	
end;


procedure CallSanitizeStringCharacters;
begin

	iStringLength := Length(sDialogFromRecord);
	sOldStringBeforeDeletedChars := sDialogFromRecord;

	for iStringCounter := 1 to iStringLength do begin
		SanitizeStringCharacters;
	end;
	
	if bDebug = true then begin
		AddMessage('Old string is: '+sOldStringBeforeDeletedChars);
		AddMessage('New string is: '+sDialogFromRecord);
	end;
	
end;


procedure AddRenamePairToNewList;
begin

	sRenamePairToAdd := sFileName+'|'+sDialogFromRecord;
	tFinalList.Add(sRenamePairToAdd);
	
	if bDebug = true then
		AddMessage('Added rename pair to the final list!');

end;


procedure StartTheMainProcess;
begin

	for iMainLoopCounter := 0 to iNumDialogFiles - 1 do begin
	
		iIndexInList := iMainLoopCounter;
		iDeadRepeatLoop := 0;
		
		GetDataFromFileName;
		GetTheDialogRecord;
		FixUnneededFullStop;
		
		if bDebug = true then
			AddMessage('Removing Substrings');
		//We'll remove all () [] {} text
		//But not <>, as that is used for when the dialogue is for an emote, such as breathing or a dog's bark
		repeat
			RemoveSubstrings('(', ')');
			if iDeadRepeatLoop > 10 then
				exit;
		until bBracketLoopEscape = true;
		
		if bDebug = true then
			AddMessage('Removing Substrings again!');
		
		repeat
			RemoveSubstrings('[', ']');
			if iDeadRepeatLoop > 10 then
				exit;
		until bBracketLoopEscape = true;
		
		iDeadRepeatLoop := 0;
		
		if bDebug = true then
			AddMessage('Removing Substrings For the last time!');
			
		repeat
			RemoveSubstrings('{', '}');
			if iDeadRepeatLoop > 10 then
				exit;
		until bBracketLoopEscape = true;
		
		repeat
			RemoveSubstrings('{', ')');
			if iDeadRepeatLoop > 10 then
				exit;
		until bBracketLoopEscape = true;
		
		iDeadRepeatLoop := 0;
		
		if bDebug = true then
			AddMessage('Dem substrings deader dan dead, fer true!');
		
		CallSanitizeStringCharacters;
		FixUnneededFullStop;
		FixEmptyDupeText;
		
		sDialogFromRecord := sDialogFromRecord+'.ogg';
		
		AddRenamePairToNewList;
	
	end;
	
end;




function Initialize: integer;
begin
  SetUpFileVars;
	SetUpOurVars;
	
	StartTheMainProcess;
end;


function Finalize: integer;
begin
  tListOfFiles.free;
	tFinalList.free;
end;

end.