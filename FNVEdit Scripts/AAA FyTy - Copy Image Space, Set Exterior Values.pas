unit userscript;
const
	iFileDestIndex = ($0E + 1);//Add +1 to displayed file load order because xEdit's UI doesn't add +1 for the .exe
var
	fileDest: IInterface;

function Initialize: integer;
begin

	fileDest := FileByIndex(iFileDestIndex);
  
end;

function Process(e: IInterface): integer;
var
	eCurrent: IInterface;
begin

	if Signature(e) <> 'IMGS' then
		exit;
	
  AddMessage('Processing: ' + FullPath(e));
	
	eCurrent := wbCopyElementToFile(e, fileDest, false, true);
	
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Eye Adapt Speed', '1.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Emissive Mult', '1.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Target LUM', '20.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Upper LUM Clamp', '1.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Bright Scale', '6.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Bright Clamp', '0.050000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\LUM Ramp No Tex', '1.150000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\LUM Ramp Min', '0.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\LUM Ramp Max', '0.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Sunlight Dimmer', '1.650000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Grass Dimmer', '1.500000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Tree Dimmer', '1.2500000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\HDR\Skin Dimmer', '1.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\Bloom\Blur Radius', '0.030000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\Bloom\Alpha Mult Interior', '0.800000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\Bloom\Alpha Mult Exterior', '0.200000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\Cinematic\Saturation', '1.400000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\Cinematic\Contrast\Avg Lum Value', '1.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\Cinematic\Contrast\Value', '1.000000');
	//SetElementEditValues(eCurrent, 'DNAM - DNAM\Cinematic\Cinematic - Brightness - Value', '1.000000');

end;


function Finalize: integer;
begin
	
end;

end.