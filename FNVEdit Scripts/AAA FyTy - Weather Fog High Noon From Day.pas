unit userscript;
const

	strFogDayPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #1 (Day)\';
	strFogHighNoonPath = 'NAM0 - Colors by Types/Times\Type #1 (Fog)\Time #4 (High Noon)\';


function Process(e: IInterface): integer;
var
	strR, strG, strB: string;
begin
	
	if Signature(e) <> 'WTHR' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	strR := GetElementEditValues(e, strFogDayPath + 'Red');
	strG := GetElementEditValues(e, strFogDayPath + 'Green');
	strB := GetElementEditValues(e, strFogDayPath + 'Blue');
	
	SetElementEditValues(e, strFogHighNoonPath + 'Red', strR);
	SetElementEditValues(e, strFogHighNoonPath + 'Green', strG);
	SetElementEditValues(e, strFogHighNoonPath + 'Blue', strB);


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.