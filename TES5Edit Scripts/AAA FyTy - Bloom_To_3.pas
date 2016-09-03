unit UserScript;

function Process(e: IInterface): integer;
  begin

    if Signature(e) <> 'IMGS' then
      Exit;

    AddMessage('Processing: ' + FullPath(e));

    SetElementEditValues(e, 'HNAM - HDR\Eye Adapt Strength', '1');
    SetElementEditValues(e, 'CNAM - Cinematic\Saturation', '2');

  end;
end.
