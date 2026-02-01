unit userscript;
uses mtefunctions;
uses 'AAA FyTy - Aux Functions';

var
	fileMyFile: IInterface;

function Initialize: integer;
begin
  //fileMyFile := FileByName('FyTy - Tweaks.esp');
end;

function IsNonShadowOmni(e: IInterface): boolean;
var
	eFlags: IInterface;
	bShadowSpot, bShadowHemi, bShadowOmni, bNonShadowSpot,
	bNonShadowBox: boolean;
begin
	eFlags := ElementByPath(e, 'DATA - \Flags');
	
	if GetElementEditValues(eFlags, 'Shadow Spotlight') = '1' then
		bShadowSpot := true;
	
	if GetElementEditValues(eFlags, 'Shadow Hemisphere') = '1' then
		bShadowHemi := true;
	
	if GetElementEditValues(eFlags, 'Shadow OmniDirectional') = '1' then
		bShadowOmni := true;
	
	if GetElementEditValues(eFlags, 'NonShadow Spotlight') = '1' then
		bNonShadowSpot := true;
	
	if GetElementEditValues(eFlags, 'NonShadow Box') = '1' then
		bNonShadowBox := true;
	
	if (bShadowSpot = false) and (bShadowHemi = false) and (bShadowOmni = false) and (bNonShadowSpot = false) and (bNonShadowBox = false) then
		Result := true
	else
		Result := false;
	
end;

function IsNonShadowSpot(e: IInterface): boolean;
var
	eFlags: IInterface;
begin
	
	eFlags := ElementByPath(e, 'DATA - \Flags');
	
	if GetElementEditValues(eFlags, 'NonShadow Spotlight') = '1' then
		Result := true
	else
		Result := false;
	
end;

procedure MakeOmniShadow(e: IInterface);
var
	eCopied, eFlags: IInterface;
begin
	//eCopied := wbCopyElementToFile(e, fileMyFile, false, true);
	eFlags := ElementByPath(e, 'DATA - \Flags');
	SetFlag(eFlags, 'Shadow OmniDirectional', true);
end;

procedure MakeSpotShadow(e: IInterface);
var
	eCopied, eFlags: IInterface;
begin
	//eCopied := wbCopyElementToFile(e, fileMyFile, false, true);
	eFlags := ElementByPath(e, 'DATA - \Flags');
	SetFlag(eFlags, 'Shadow Spotlight', true);
	SetFlag(eFlags, 'NonShadow Spotlight', false);
end;

function Process(e: IInterface): integer;
var
	eOverride, eOverrideData: IInterface;
begin
	
	if Signature(e) <> 'LIGH' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	if IsNonShadowOmni(e) then
		MakeOmniShadow(e);
	
	if IsNonShadowSpot(e) then
		MakeSpotShadow(e);
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.