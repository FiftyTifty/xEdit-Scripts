unit userscript;
uses 'AAA FyTy - Aux Functions';
const
	strLevel = '8';
	strLevelPath = 'ACBS\Level';
	strCalcMaxPath = 'ACBS\Calc max';
	strCalcMinPath = 'ACBS\Calc min';


function Process(e: IInterface): integer;
begin

	if Signature(e) <> 'CREA' then
		exit;

  //AddMessage('Processing: ' + FullPath(e));
	
	SetElementEditValues(e, strLevelPath, strLevel);
	SetElementEditValues(e, strCalcMinPath, strLevel);
	SetElementEditValues(e, strCalcMaxPath, strLevel);
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.
