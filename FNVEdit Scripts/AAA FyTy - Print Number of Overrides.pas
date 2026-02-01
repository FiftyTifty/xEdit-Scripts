unit userscript;

//If a record is in seven mods, it has six overrides.
//The 2nd last override will be the fifth mod's entry

function Process(e: IInterface): integer;
var
	eRecord: IInterface;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	eRecord := MasterOrSelf(e);
	
	AddMessage(IntToStr(OverrideCount(eRecord)));


end;

end.