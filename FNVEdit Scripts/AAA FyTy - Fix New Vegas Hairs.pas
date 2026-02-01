{
  Update NiAlphaProperty flags and threshold of all meshes in a folder
}
unit NifUpdateAlphaFlags;

const
  sMeshesPath = 'R:\Games\Fallout New Vegas Mods\Bash Installers\Fixes - ENB AO Hair\meshes\Characters\hair'; // folder with meshes
  iAlphaFlags = 6893; // alpha flags to set
  iAlphaThreshold = 130; // alpha threshold to set

procedure ProcessNif(aMesh: string);
var
  i: integer;
  nif: TwbNifFile;
  b: TwbNifBlock;
  bChanged: Boolean;
begin
  nif := TwbNifFile.Create;
  try
    nif.LoadFromFile(aMesh);
    
    for i := 0 to Pred(nif.BlocksCount) do begin
      b := nif.Blocks[i];
      if b.BlockType <> 'NiAlphaProperty' then
        Continue;

      if b.NativeValues['Flags'] <> iAlphaFlags then begin
        b.NativeValues['Flags'] := iAlphaFlags;
        bChanged := True;
      end;

      if b.NativeValues['Threshold'] <> iAlphaThreshold then begin
        b.NativeValues['Threshold'] := iAlphaThreshold;
        bChanged := True;
      end;
    end;
  
    if bChanged then begin
      nif.SaveToFile(aMesh);
      AddMessage('Updated ' + aMesh);
    end;
  
  finally
    nif.Free;
  end;
end;

function Initialize: Integer;
var
  TDirectory: TDirectory; // to access member functions
  files: TStringDynArray;
  i: integer;
begin
  files := TDirectory.GetFiles(IncludeTrailingBackslash(sMeshesPath), '*.nif', soAllDirectories);

  for i := 0 to Pred(Length(files)) do
    ProcessNif(files[i]);
  
  Result := 1;
end;

end.