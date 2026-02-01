unit userscript;
var
	strDataType, strIndex, strValue: string;


function Initialize: integer;
begin
  strDataType := 'Value/Color';
	strIndex := '1168 SkinTints - Skin tone';
	strValue := '1.0000';
end;


function Process(e: IInterface): integer;
var
	strR, strG, strB, strTemplateColorIndex: string;
begin

  AddMessage('Processing: ' + FullPath(e));


end;


function Finalize: integer;
begin
  Result := 0;
end;

end.