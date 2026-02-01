unit userscript;
var
	strKeyword: string;


function Initialize: integer;
begin
  strKeyword := 'AAAFyTy_Keyword_WorkshopColoredLights "Coloured Lights" [KYWD:020010F5]';
end;


function Process(e: IInterface): integer;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, 'FNAM\Keyword', strKeyword);

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.