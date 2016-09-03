unit userscript;
var
	Container, MyFile, TestFile, Added, e: IInterface;
	i: integer;
	FormString: string;
	RunOnce: Boolean;

	
function Initialize: integer;

begin
	MyFile := FileByIndex(02);
	AddMessage('My File is '+GetFileName(MyFile));
	TestFile := FileByIndex(03);
	AddMessage('My Test File is '+GetFileName(TestFile));
end;


procedure SetContainer;

begin
	AddMessage('Setting Container');
	//Container := RecordByFormID(MyFile, $023149C2, true);
	Container := e;
	AddMessage('Set Container. It has '+inttostr(ElementCount(Container))+' elements');
end;


procedure AddToContainer;
	
begin
	AddMessage('Adding To Container');
	FormString := GetEditValue(ElementByPath(e, 'Record Header\FormID'));
	AddMessage(FormString);
	Added := ElementAssign(ElementByPath(Container, 'Items'), LowInteger, nil, false);
	SetElementEditValues(Added, 'Item\CNTO - Item\Item', FormString);

end;


function Process(e: IInterface): integer;

begin
  AddMessage('Processing: ' + FullPath(e));
	
  if Signature(e) = 'CONT' then begin
		SetContainer;
	end
	
	else AddToContainer;

		//AddMessage(inttostr(RecordCount(TestFile)));
	
	//if Signature(e) = 'ARMO' then
		//AddToContainer;

end;

end.