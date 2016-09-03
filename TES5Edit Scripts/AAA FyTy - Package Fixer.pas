unit userscript;

var
	FirstRef, SecondRef, ePath: IInterface;
	PlacedRef: string;

function Initialize: integer;
begin

end;

function FixPackage(eRec, eRec2: IInterface): integer;
begin
	SetIsPersistent(eRec2, true);
	ePath := ElementByPath(ElementByIndex(ElementByPath(eRec, 'Package Data\Data Input Values'), 0), 'PTDA - Target\Target Data\Type');
	SetEditValue(ePath, 'Specific Reference');
	ePath := ElementByPath(ElementByIndex(ElementByPath(eRec, 'Package Data\Data Input Values'), 0), 'PTDA - Target\Target Data\Reference');
	AddMessage(GetEditValue(ePath));
	PlacedRef := GetEditValue(ElementByPath(eRec2, 'Record Header\FormID'));
	AddMessage(PlacedRef);
	
	SetEditValue(ePath, PlacedRef);
end;

function Process(e: IInterface): integer;
begin
	if Signature(e) <> 'NPC_' then
		exit;
//  AddMessage('Processing: ' + FullPath(e));
	
	FirstRef := ReferencedByIndex(e, 0);
	
	if Signature(FirstRef) = 'PACK' then begin
		SecondRef := ReferencedByIndex(e, 1);
		FixPackage(FirstRef, SecondRef);
	end;
	
end;


function Finalize: integer;
begin

end;

end.