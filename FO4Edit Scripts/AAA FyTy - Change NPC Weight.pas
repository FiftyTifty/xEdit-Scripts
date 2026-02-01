unit userscript;


function Initialize: integer;
begin
  Result := 0;
end;


function Process(e: IInterface): integer;
var
	eMWGT: IInterface;
	fMuscular, fFat, fThin, fRand: float;
	bDoMuscle: boolean;
begin
	
	if Signature(e) <> 'NPC_' then
		exit;
	
	Randomize();
	
  AddMessage('Processing: ' + FullPath(e));
	
	bDoMuscle := Random(2);
	
	if (bDoMuscle = true) then begin
		
		fMuscular := 1.00;
		fFat := 0.00;
		fThin := 0.00;
		
		fRand := ((Random(10) + 1) / 100);
		
		fMuscular := fMuscular - fRand;
		fThin := fRand;
		
		fRand := ((Random(20) + 1) / 100);
		fMuscular := fMuscular - fRand;
		fFat := fRand;
		
	end
	else
	begin
		
		fMuscular := 0.00;
		fFat := 1.00;
		fThin := 0.00;
		
		fRand := ((Random(10) + 1) / 100);
		
		fFat := fFat - fRand;
		fThin := fRand;
		
		fRand := ((Random(20) + 1) / 100);
		fFat := fFat - fRand;
		fMuscular := fRand;
		
	end;
	
	eMWGT := ElementBySignature(e, 'MWGT');
	SetElementEditValues(eMWGT, 'Thin', FloatToStr(fThin));
	SetElementEditValues(eMWGT, 'Muscular', FloatToStr(fMuscular));
	SetElementEditValues(eMWGT, 'Fat', FloatToStr(fFat));
	
end;


function Finalize: integer;
begin
  Result := 0;
end;

end.