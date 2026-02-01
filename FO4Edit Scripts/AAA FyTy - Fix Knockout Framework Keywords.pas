unit userscript;
const
	strKeyword = 'KFWeaponCanKnockoutKeyword [KYWD:08000FA2]';


function Process(e: IInterface): integer;
var
	iCounter: integer;
	eProperty: IInterface;
begin
	
  if Signature(e) <> 'OMOD' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
  for iCounter := 0 to ElementCount(ElementByPath(e, 'DATA - Data\Properties')) - 1 do begin
	
		eProperty := ElementByIndex(ElementByPath(e, 'DATA - Data\Properties'), iCounter);
		
		if GetElementEditValues(eProperty, 'Value 1 - FormID') = strKeyword then
			SetElementEditValues(eProperty, 'Value 2 - Int', '1');
	
	end;
	
end;


function Finalize: integer;
begin
  
	
	
end;

end.