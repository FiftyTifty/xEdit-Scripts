{
  New script template, only shows processed records
  Assigning any nonzero value to Result will terminate script
}
unit userscript;

var
	PatchFile, PreRefr: IInterface;

// Called before processing
// You can remove it if script doesn't require initialization code
function Initialize: integer;
begin
  PatchFile := FileByIndex(15);
end;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'REFR' then
		exit;

	AddMessage(IntToStr(ReferencedByCount(e)));

  // processing code goes here

end;

end.