unit userscript;
uses 'AAA FyTy - Aux Functions';
var
	bCopyRecord: boolean;
	strStatsFlag, strFlagPath, strTemplateFlagPath, strLevel,
	strAutoCalcFlag, strPCMultFlag: string;
	eFile: IInterface;


function Initialize: integer;
begin
	bCopyRecord := false;
  strStatsFlag := 'Use Stats';
	strAutoCalcFlag := 'Auto-calc stats';
	strPCMultFlag := 'PC Level Mult';

	strTemplateFlagPath := 'ACBS - Configuration\Template Flags';
	strFlagPath := 'ACBS - Configuration\Flags';
	eFile := FileByIndex(10);
	strLevel := '25';
end;


function Process(e: IInterface): integer;
var
	bNotUsingTemplate: boolean;
	eFlags, eLevel: IInterface;
begin

	if Signature(e) <> 'CREA' then
		exit;

  //AddMessage('Processing: ' + FullPath(e));
	
	eFlags := ElementByPath(e, strTemplateFlagPath);
	
	if (GetElementEditValues(eFlags, strStatsFlag) <> '') then
		exit;
		
	if bCopyRecord = true then
		e := wbCopyElementToFile(e, eFile, false, true);
	
	eFlags := ElementByPath(e, strFlagPath);
	
	SetFlag(eFlags, strPCMultFlag, true);
	SetFlag(eFlags, strAutoCalcFlag, true);
	
	SetElementEditValues(e, 'ACBS - Configuration\Level Mult', '1');
	SetElementEditValues(e, 'ACBS - Configuration\Calc min', '25');
	SetElementEditValues(e, 'ACBS - Configuration\Calc max', '25');
	
	
	
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.