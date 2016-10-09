unit userscript;
var
	fileDestination: IInterface;
	iMultiplier, iAdd, iSetTo: integer;
	bCopyToFile, bAddition, bSetTo: boolean;

function Initialize: integer;
begin
	bCopyToFile := false;
	bAddition := false;
	bSetTo := true;
	fileDestination := FileByIndex(9);
	iMultiplier := 0.8;
	iAdd := 1500;
	iSetTo := 1780;
end;


function Process(e: IInterface): integer;
var
	ePowerArmourHealth, eCopiedRecord: IInterface;
	iPowerArmourHealth: integer;
begin
	
	if Signature(e) <> 'ARMO' then
		exit;
	
	if Pos('_Power_', GetEditValue(ElementBySignature(e, 'EDID'))) = 0 then
		exit;
	
	
  AddMessage('Processing: ' + FullPath(e));
	
	
	if bCopyToFile then
		eCopiedRecord := wbCopyElementToFile(e, fileDestination, false, true)
	else
		eCopiedRecord := e;
	
	
	ePowerArmourHealth := ElementByPath(eCopiedRecord, 'DATA - \Health');
	iPowerArmourHealth := StrToInt(GetEditValue(ePowerArmourHealth));
	
	if bSetTo = false then begin
		if bAddition then
			iPowerArmourHealth := iPowerArmourHealth + iAdd
		else
			iPowerArmourHealth := iPowerArmourHealth * iMultiplier;
	end;
	
	if bSetTo then
		iPowerArmourHealth := iSetTo;
	
	SetEditValue(ePowerArmourHealth, IntToStr(iPowerArmourHealth));

end;


function Finalize: integer;
begin
	
	
	
end;

end.