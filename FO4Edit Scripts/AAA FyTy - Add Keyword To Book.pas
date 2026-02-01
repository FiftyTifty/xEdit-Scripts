unit userscript;
var
	strKeywordToAdd: string;


function Initialize: integer;
begin
  strKeywordToAdd := 'AAAFyTy_BurntMagazine_Keyword [KYWD:070EDF48]';
end;


function Process(e: IInterface): integer;
var
	eKWDA, eAddedKeyword: IInterface;
begin
	
	if Signature(e) <> 'BOOK' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));

	eKWDA := ElementBySignature(e, 'KWDA');
	eAddedKeyword := ElementAssign(eKWDA, HighInteger, nil, false);
	SetEditValue(eAddedKeyword, strKeywordToAdd);
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.