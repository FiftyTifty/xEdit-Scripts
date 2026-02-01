unit userscript;
uses 'AAA FyTy - Aux Functions';

const
	strPathMin = 'ACBS - Configuration\Calc min';
	strPathMax = 'ACBS - Configuration\Calc max';
	strPathLevel = 'ACBS - Configuration\Level';


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eFlags: IInterface;
	iCalcMin: integer;
begin
	
	if Signature(e) <> 'CREA' then
		exit;
	
	if GetElementEditValues(e, strPathMax) = '' then exit;
	
	eFlags := ElementByPath(e, 'ACBS\Flags');
	
  AddMessage('Processing: ' + FullPath(e));
	
	iCalcMin := StrToInt(GetElementEditValues(e, strPathMax));
	
	SetFlag(eFlags, 'PC Level Mult', false);
		
	SetElementEditValues(e, strPathLevel, IntToStr(iCalcMin));

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.