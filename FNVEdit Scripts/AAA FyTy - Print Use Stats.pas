unit userscript;
const strPath = 'ACBS - Configuration\Template Flags\Use Stats';


function Process(e: IInterface): integer;
var
	eFlags: IInterface;
	strFlag: string;
begin
	
	eFlags := ElementByPath(e, strPath);
	strFlag := GetEditValue(eFlags);
	AddMessage(strFlag);

end;

end.