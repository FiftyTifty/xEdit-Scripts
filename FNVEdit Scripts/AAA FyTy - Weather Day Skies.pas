unit userscript;
const
	strSkyLowerDayPath = 'NAM0\Type #7 (Sky-Lower)\Time #1 (Day)\';
	strSkyLowerDayNoonPath = 'NAM0\Type #7 (Sky-Lower)\Time #4 (High Noon)\';
	strSkyUpperDayPath = 'NAM0\Type #0 (Sky-Upper)\Time #1 (Day)\';
	strSkyUpperDayNoonPath = 'NAM0\Type #0 (Sky-Upper)\Time #4 (High Noon)\';
	
	iSkyUpperDayR = 126;
	iSkyUpperDayG = 184;
	iSkyUpperDayB = 248;
	
	iSkyLowerDayR = 168;
	iSkyLowerDayG = 210;
	iSkyLowerDayB = 250;
	
	iSkyUpperNoonR = 126;
	iSkyUpperNoonG = 184;
	iSkyUpperNoonB = 248;
	
	iSkyLowerNoonR = 168;
	iSkyLowerNoonG = 210;
	iSkyLowerNoonB = 250;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	if Signature(e) <> 'WTHR' then
		exit;
	
	SetElementEditValues(e, strSkyLowerDayPath + 'Red', iSkyLowerDayR);
	SetElementEditValues(e, strSkyLowerDayPath + 'Green', iSkyLowerDayG);
	SetElementEditValues(e, strSkyLowerDayPath + 'Blue', iSkyLowerDayB);
	
	SetElementEditValues(e, strSkyLowerDayNoonPath + 'Red', iSkyLowerNoonR);
	SetElementEditValues(e, strSkyLowerDayNoonPath + 'Green', iSkyLowerNoonG);
	SetElementEditValues(e, strSkyLowerDayNoonPath + 'Blue', iSkyLowerNoonB);
	
	SetElementEditValues(e, strSkyUpperDayPath + 'Red', iSkyUpperDayR);
	SetElementEditValues(e, strSkyUpperDayPath + 'Green', iSkyUpperDayG);
	SetElementEditValues(e, strSkyUpperDayPath + 'Blue', iSkyUpperDayB);
	
	SetElementEditValues(e, strSkyUpperDayNoonPath + 'Red', iSkyUpperNoonR);
	SetElementEditValues(e, strSkyUpperDayNoonPath + 'Green', iSkyUpperNoonG);
	SetElementEditValues(e, strSkyUpperDayNoonPath + 'Blue', iSkyUpperNoonB);
	

end;


function Finalize: integer;
begin
  Result := 0;
end;

end.