{
  New script template, only shows processed records
  Assigning any nonzero value to Result will terminate script
}
unit userscript;

var
	Output1, Output2Part, Output2Complete, Output, Prefix, Outfit, Glove, Boots, NoseRing, Neck, Belt, Back, Accessory, EditValueEDID: string;
	UpperBody: IInterface;
// called for every record selected in xEdit
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'RACE' then
      Exit;

  // comment this out if you don't want those messages
//  AddMessage('Processing: ' + FullPath(e));


	Outfit := 'Outfit';
	Glove := 'Glove';
	Boots := 'Boots';
	NoseRing := 'Shoulder';
	Neck := 'Neck';
	Belt := 'Belt';
	Back := 'Back';
	Accessory := 'Accessory';
	Prefix := 'fco';
  EditValueEDID := GetEditValue(ElementByPath(e, 'EDID'));
	
	//Output2Part := Delete(EditValueEDID, 1, 3);
	//Output2Complete := Insert('TMNV', Output2Part, 1);
	//SetEditValue((ElementByPath(e, 'EDID')), Output2Complete);
	//AddMessage(Output2Complete);
	
	Output := Insert(Prefix, EditValueEDID, 1); // Outfit will be inserted AS the 4th character; after the 3rd.
	SetEditValue(ElementByPath(e, 'EDID'), Output);
	
{  
  if GetEditValue(ElementByPath(e, 'BMDT\Biped Flags')) = '001' then begin // Upper Body
		Output := Insert(Outfit, EditValueEDID, 4); // Outfit will be inserted AS the 4th character; after the 3rd.
		SetEditValue(ElementByPath(e, 'EDID'), Output);
	end;
	
 if GetEditValue(ElementByPath(e, 'BMDT\Biped Flags')) = '000000000000000001' then begin // Body Addon 1
		Output := Insert(Glove, EditValueEDID, 4); // Outfit will be inserted AS the 4th character; after the 3rd.
		SetEditValue(ElementByPath(e, 'EDID'), Output);
	end;
	
	if GetEditValue(ElementByPath(e, 'BMDT\Biped Flags')) = '0000000000000000001' then begin // Body Addon 2
		Output := Insert(Boots, EditValueEDID, 4); // Outfit will be inserted AS the 4th character; after the 3rd.
		SetEditValue(ElementByPath(e, 'EDID'), Output);
	end;
	
	if GetEditValue(ElementByPath(e, 'BMDT\Biped Flags')) = '0000000000001' then begin // Nose Ring
		Output := Insert(NoseRing, EditValueEDID, 4); // Outfit will be inserted AS the 4th character; after the 3rd.
		SetEditValue(ElementByPath(e, 'EDID'), Output);
	end;
	
	if GetEditValue(ElementByPath(e, 'BMDT\Biped Flags')) = '000000001' then begin // Necklace
		Output := Insert(Neck, EditValueEDID, 4); // Outfit will be inserted AS the 4th character; after the 3rd.
		SetEditValue(ElementByPath(e, 'EDID'), Output);
	end;

	if GetEditValue(ElementByPath(e, 'BMDT\Biped Flags')) = '00000000000000000001' then begin // Body Addon 3
		Output := Insert(Belt, EditValueEDID, 4); // Outfit will be inserted AS the 4th character; after the 3rd.
		SetEditValue(ElementByPath(e, 'EDID'), Output);
	end;
	
	if GetEditValue(ElementByPath(e, 'BMDT\Biped Flags')) = '00000001' then begin // Backpack
		Output := Insert(Back, EditValueEDID, 4); // Outfit will be inserted AS the 4th character; after the 3rd.
		SetEditValue(ElementByPath(e, 'EDID'), Output);
	end;

 if GetEditValue(ElementByPath(e, 'BMDT\Biped Flags')) = '0000000000000001' then begin // Choker
		Output := Insert(Accessory, EditValueEDID, 4); // Outfit will be inserted AS the 4th character; after the 3rd.
		SetEditValue(ElementByPath(e, 'EDID'), Output);
	end;
}
	
  // processing code goes here

end;

end.
