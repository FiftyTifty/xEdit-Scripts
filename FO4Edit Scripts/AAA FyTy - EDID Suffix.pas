unit userscript;
var
	iSuffix: integer;
	strSuffix: string;

function Initialize: integer;
begin
	
	iSuffix := 000;
	
end;


function Process(e: IInterface): integer;
var
	strEDID: string;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	inc(iSuffix);
	
	strEDID := GetEditValue(ElementBySignature(e, 'EDID'));
	strSuffix := '_' + Format('%0.3d',[iSuffix]);
	
	strEDID := strEDID + strSuffix;
	
	SetEditValue(ElementBySignature(e, 'EDID'), strEDID);

end;


function Finalize: integer;
begin
	
	
	
end;

end.