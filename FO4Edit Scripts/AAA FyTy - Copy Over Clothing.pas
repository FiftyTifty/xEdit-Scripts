unit userscript;

var
	ePath, ePath02, ePath03, OriginalElement, ChangedRec, LinkedRec, MyFile, ThisFile: IInterface;
	eString, eString02, eString03, SomeString, NewString: string;
	eFormID, eFormID02, eFormID04: cardinal;
	i, PrefixPos, BracketPos1, BracketPos2: integer;

function Initialize: integer;
begin
MyFile := FileByLoadOrder(02);
end;


procedure GetTheDamnFormID(SomeString: string);
begin
	BracketPos1 := Pos('[', SomeString);
	
	For i := 0 to BracketPos1 + 4 do begin
		SomeString := Delete(SomeString, 1, 1);
	end;
	
	BracketPos2 := Pos(']', SomeString);
	SomeString := Delete(SomeString, BracketPos2, 1);
	
	AddMessage(SomeString);
end;


function Process(e: IInterface): integer;
begin
	if (Signature(e) <> 'ARMO') and (Signature(e) <> 'COBJ') then
		exit;

	if Signature(e) = 'ARMO' then begin
		AddMessage('Processing: ' + FullPath(e));
		
		AddMessage(GetFileName(MyFile));
		OriginalElement := ElementByPath(e, 'Armatures\Armature\MODL - Armature');
		eString := GetEditValue(OriginalElement);
		AddMessage(eString);
		ThisFile := GetFile(e);
		
		eString := Delete(eString, Pos('AA', eString), 2);
		eString := Insert('00', eString, 0);
		eString := Delete(eString, Pos(' [', eString), 50);
		AddMessage(eString);
		
		ChangedRec := MainRecordByEditorID(GroupBySignature(MyFile, 'ARMA'), eString);
		NewString := GetEditValue(ElementByPath(ChangedRec, 'Record Header\FormID'));
		
		SetEditValue(OriginalElement, NewString);
	end;
	
	if Signature(e) = 'COBJ' then begin
		AddMessage('Processing: ' + FullPath(e));
		
		AddMessage(GetFileName(MyFile));
		OriginalElement := ElementByPath(e, 'CNAM - Created Object');
		eString := GetEditValue(OriginalElement);
		AddMessage(eString);
		ThisFile := GetFile(e);
		eString := Insert('00_', eString, 0);
		eString := Delete(eString, Pos(' "', eString), 100);
		AddMessage(eString);
		
		ChangedRec := MainRecordByEditorID(GroupBySignature(MyFile, 'ARMO'), eString);
		NewString := GetEditValue(ElementByPath(ChangedRec, 'Record Header\FormID'));
		
		SetEditValue(OriginalElement, NewString);
	end;
end;


function Finalize: integer;
begin

end;

end.