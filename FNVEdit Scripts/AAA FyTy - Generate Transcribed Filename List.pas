unit userscript;

// There is no process function, as we only loop through the text file containing the dialog filenames.
// The initialize function calls a few procedures in a loop.

var
	sFileName, sFormID, sDialogFromRecord, sRenamePairToAdd, sTextFileToLoad, sTextFileToSaveTo: string;
	sOldStringBeforeDeletedChars: string;
	
	tListOfFiles, tFinalList: TStringList; // copied
	
	iFormID, iNumDialogFiles, iFileNameLength, iFormIDPos, iIndexInList, iResponseNum, iMainLoopCounter: integer;
	// _				Copied
	iResponsePos1, iResponsePos2, iStringCounter, iStringLength, iBlankDupePrefix: integer; // 1 = 1 digit, 2 = 2 digits
	iBracketPosOpen, iBracketPosClose, iNumBracketChars, iFullstopPos: integer;
	
	eDialogRecord, eResponse, eResponseText: IInterface;
	fileFNVesm, fileDeadMesm, fileHHesm, fileOWBesm, fileLResm, fileGRAesm: IInterface; //copied
	
	bDebug, bdoFNV, bdoDeadM, bdoHH, bdoOWB, bdoLR, bdoGRA: boolean; //copied
	bBracketPosCheck, bBreakFullstopCheck, bGenericBool: boolean;
	
	
procedure SetUpFileVars; // Preliminary stuff, get our file vars all geared up
begin

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
	
	fileGRAesm := FileByIndex(6);
	AddMessage(GetFileName(fileGRAesm)); // Gun Runner's Arsenal
	
	bdoFNV := true;
	bdoDeadM := false;
	bdoHH := false;
	bdoOWB := false;
	bdoLR := false;
	bdoGRA := false;
	
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
	
	if bdoGRA = true then begin
	
		tListOfFiles := TStringList.Create;
		sTextFileToLoad := 'Z:\AAA\AAANewVegas Data Dump\sound\voice\gunrunnersarsenal.esm\ListOfFiles.txt';
		tListOfFiles.LoadFromFile(sTextFileToLoad);
	
		tFinalList := TStringList.Create;
		sTextFileToSaveTo := 'Z:\AAA\AAANewVegas Data Dump\sound\voice\gunrunnersarsenal.esm\DialogRenamePairs.txt';
	
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
		AddMessage(IntToHex(FormID(eDialogRecord), 8));
	
	eResponse := ElementByIndex(ElementByPath(eDialogRecord, 'Responses'), iResponseNum - 1);
	eResponseText := ElementByPath(eResponse, 'NAM1 - Response Text');
	sDialogFromRecord := GetEditValue(eResponseText);
	
	if bDebug = true then
		AddMessage('Dialog to write is: '+sDialogFromRecord);
end;


procedure FixStringCharacters; // Check every character in the dialog, see if they're fucky. if they are, change 'em and start from the previous char.
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

procedure RemoveSubstrings(pstringOpenCharToCheck, pstringClosedCharToCheck: string;);
begin
	//Do a bunch of passes to make sure we remove the unwanted text. If it isn't present, the string won't be changed
	
	iBracketPosOpen := Pos(pstringOpenCharToCheck, sDialogFromRecord);
	iBracketPosClose := Pos(pstringClosedCharToCheck, sDialogFromRecord);
	
	
	repeat
	
	if bDebug = true then begin
		AddMessage(sDialogFromRecord);
		AddMessage('Open Bracket is @ '+inttostr(iBracketPosOpen));
		AddMessage('Closed Bracket is @ '+inttostr(iBracketPosClose));
		sleep(1500);
	end;
	
	if iBracketPosOpen = 1 then
		if iBracketPosClose = (Pos('.ogg', sDialogFromRecord) - 1) then
			exit;
	
	bBracketPosCheck := iBracketPosClose > iBracketPosOpen;
	
	if bBracketPosCheck = true then
		iNumBracketChars := (iBracketPosClose - iBracketPosOpen) + 1;
	
	
	if iNumBracketChars > 0 then
		if iBracketPosOpen <> 0 then
			if iBracketPosClose <> 0 then
				bGenericBool := (iBracketPosClose - iBracketPosOpen) > 1;
	
	if bDebug = true then
		AddMessage('Character @ open bracket pos is: '+sDialogFromRecord[iBracketPosOpen]);
	
	if bGenericBool = true then			
		Delete(sDialogFromRecord, iBracketPosOpen, iNumBracketChars);
	
	
	iBracketPosOpen := Pos(pstringOpenCharToCheck, sDialogFromRecord); // Update info after modifying the string
	iBracketPosClose := Pos(pstringClosedCharToCheck, sDialogFromRecord); // ditto
	
	if iBracketPosOpen = 0 then
		if iBracketPosClose > 0 then
			Delete (sDialogFromRecord, iBracketPosClose, 1); // If we have a stray closed bracket, get rid of it
	
	if iBracketPosClose = 1 then
		Delete (sDialogFromRecord, 0, 1);
	
	if bdebug = true then
		AddMessage('Deleted stray '+pstringClosedCharToCheck+'new string is: '+sDialogFromRecord);
	
	until iBracketPosClose = 0;
	
	
	if sDialogFromRecord = '.ogg' then begin
		sDialogFromRecord := IntToStr(iBlankDupePrefix)+'.ogg';
		iBlankDupePrefix := iBlankDupePrefix + 1;
	end;
	
	
	if bDebug = true then
		AddMessage('Final dialog is: '+sDialogFromRecord);
end;


procedure CallFixStringCharacters;
begin

	iStringLength := Length(sDialogFromRecord);
	sOldStringBeforeDeletedChars := sDialogFromRecord;

	for iStringCounter := 1 to iStringLength do begin
		FixStringCharacters;
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

end;




function Initialize: integer;
begin
	
	bDebug := true;
	
	SetUpFileVars;
	SetUpOurVars;
	iBlankDupePrefix := 0001;
	
	
	for iMainLoopCounter := 0 to iNumDialogFiles - 1 do begin
	
		iIndexInList := iMainLoopCounter;
		
		GetDataFromFileName;
		GetTheDialogRecord;
		
		iFullstopPos := pos('.', sDialogFromRecord);
		
		if iFullstopPos = Length(sDialogFromRecord) then
			repeat
				
				Delete(sDialogFromRecord, iFullstopPos, 1);
				
				
				bGenericBool := Length(sDialogFromRecord) > 0;
				
				if bGenericBool = true then
					iFullstopPos := pos('.', sDialogFromRecord);
				
				if iFullstopPos = 0 then
					if Length(sDialogFromRecord) = 0 then
						bBreakFullstopCheck := true;
				
				
				bGenericBool := iFullstopPos < Length(sDialogFromRecord);
				
				if bGenericBool = true then
					bBreakFullstopCheck := true;
				
				if bDebug = true then begin
					//Sleep(2000);
					AddMessage('Removed unneeded fullstop');
					AddMessage('iFullstopPos is '+inttostr(iFullstopPos));
					AddMessage('Length of string is '+inttostr(Length(sDialogFromRecord)));
					AddMessage('String is '+sDialogFromRecord);
				end;
				
		until bBreakFullstopCheck = true;
		
		sDialogFromRecord := sDialogFromRecord+'.ogg';
		
		//We'll remove all () [] {} text
		//But not <>, as that is used for when the dialogue is for an emote, such as breathing or a dog's bark
		RemoveSubstrings('(', ')');
		RemoveSubstrings('[', ']');
		RemoveSubstrings('{', '}');
		
		CallFixStringCharacters;
		
		AddRenamePairToNewList;
	
	end;
	
	tFinalList.SaveToFile(sTextFileToSaveTo);
end;




function Finalize: integer;
begin

  tListOfFiles.free;
	tFinalList.free;
	
end;

end.