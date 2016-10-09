unit userscript;

function Initialize: integer;
begin
	
	
	
end;


function Process(e: IInterface): integer;
var
	eLinkedRefsContainer, eLinkedRef: IInterface;
	strKeyword, strRef: string;
	iCounter: integer;
	bExisted: boolean;
begin

  AddMessage('Processing: ' + FullPath(e));
	
	strKeyword := 'WorkshopItemKeyword [KYWD:00054BA6]';
	strRef := 'AAAFyTy_WorkshopWorkbenchInterior [REFR:070B83B8] (places WorkshopWorkbenchInterior "Workshop" [CONT:0012E2C4] in GRUP Cell Persistent Children of FederalRationStockpile01 "Federal Ration Stockpile" [CELL:00035FF4])';
	
	//strKeyword := 'WorkshopLinkHome [KYWD:0002058F]';
	//strRef := 'AAAFyTy_RedTouretteWorkshop_Center [REFR:0707C66A] (places XMarkerHeading [STAT:00000034] in GRUP Cell Persistent Children of [CELL:00018AA2] (in Commonwealth "Commonwealth" [WRLD:0000003C]) at -21,5)';
	
	if ElementExists(e, 'Linked References') = false then begin
		eLinkedRefsContainer := Add(e, 'Linked References', false);
		bExisted := false;
	end
	else
		bExisted := true;
		
	
	if bExisted then begin
		eLinkedRefsContainer := ElementByPath(e, 'Linked References');
		
		for iCounter := 0 to ElementCount(eLinkedRefsContainer) - 1 do begin
			if GetEditValue(ElementByPath(ElementByIndex(eLinkedRefsContainer, iCounter), 'Ref')) = strRef then
				exit;
		end;
		
	end;
	
	
	if bExisted = true then
		eLinkedRef := ElementAssign(eLinkedRefsContainer, HighInteger, nil, false)
	else
		eLinkedRef := ElementByIndex(eLinkedRefsContainer, 0);
	
	
	SetEditValue(ElementByPath(eLinkedRef, 'Keyword/Ref'), strKeyword);
	SetEditValue(ElementByPath(eLinkedRef, 'Ref'), strRef);

end;


function Finalize: integer;
begin
	
	
	
end;

end.