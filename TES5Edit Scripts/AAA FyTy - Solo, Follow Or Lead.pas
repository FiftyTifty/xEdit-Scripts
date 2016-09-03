//For each Leader, there are three Followers.
//Leader is @ index iLeader
//Each group of three followers is from		|		(iLeader * 3) - 2 	|		to	| 	iLeader * 3 	|
//This is because (iLeader * 3) gets us the third follower. We also need the first two. We get them by detracting 1 twice from iLeader.
//iFollower01 := (iLeader * 3) - 2;
//iFollower02 := (iLeader * 3) - 1;
//iFollower03 := (iLeader * 3);

//For some of the variables, I appended four letters from the function name in which they are used.
//E.g, for CreateNewTravelPackages, I used the integer iCNTP for the loop.

unit userscript;
uses mteFunctions;

var
	FollowerList, LeaderList: TStringList;
	PackageListMonTues, PackageListWedThurs, PackageListFriSatSun: TStringList;
	
	MyFile: IInterface;
	OrigFollowPackage, NewFollowPackage, LeaderRecord, LeaderPackages, FollowerPackages: IInterface;
	FollowerRecord01, FollowerRecord02, FollowerRecord03: IInterface;
	LeadersPackage01, LeadersPackage02, LeadersPackage03: IInterface;
	
	iRandom, iProcess, iAPTN, iLeaderIndexCounter, iLeaderPackages, iFollowers, iFollowerPackages: integer;
	iLeaderIndexCounterTripled, iPackageCount, iLeaderPackageCounter: integer;
	iFollower01, iFollower02, iFollower03: integer;
	
	LeaderFormID, FollowPackageFormID: string;
	LeadersPackageFormID01, LeadersPackageFormID02, LeadersPackageFormID03: string;


function Initialize: Integer;
begin
	MyFile := FileSelect('Select File That Has The NPC_ Records'); //Always have this first. I'm an idiot and had this last.
	
	PackageListMonTues := TStringList.Create;
	PackageListWedThurs := TStringList.Create;
	PackageListFriSatSun := TStringList.Create;
	
	FollowerList := TStringList.Create;
	LeaderList := TStringList.Create;
	
	iLeaderPackageCounter := 0;
	
	OrigFollowPackage := RecordByFormID(MyFile, 118833786, true);
	
	PackageListMonTues.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Travel Packages - MonTues.txt');
	PackageListWedThurs.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Travel Packages - WedThurs.txt');
	PackageListFriSatSun.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Travel Packages - FriSatSun.txt');
	
	FollowerList.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Records - Followers.txt');
	LeaderList.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Records - Leaders.txt');
end;


procedure AddPackagesToNPCs;
begin
	
	LeaderRecord := RecordByFormID(MyFile, StrToInt(LeaderList[iLeaderIndexCounter]), true);
	LeaderFormID := GetElementEditValues(LeaderRecord, 'Record Header\FormID');
	LeaderPackages := Add(LeaderRecord, 'Packages', false);
	ElementAssign(LeaderPackages, HighInteger, nil, false);
	ElementAssign(LeaderPackages, HighInteger, nil, false);
	LeaderPackages := ElementByPath(LeaderRecord, 'Packages');
	
	for iLeaderPackages := 0 to 2 do begin
		Randomize;
		iPackageCount := PackageListMonTues.Count - 1;
		iRandom := Random(iPackageCount);
		
		if iLeaderPackageCounter = 0 then
			SetEditValue(ElementByIndex(LeaderPackages, iLeaderPackages), PackageListMonTues[iRandom]);
		
		if iLeaderPackageCounter = 1 then
			SetEditValue(ElementByIndex(LeaderPackages, iLeaderPackages), PackageListWedThurs[iRandom]);
		
		if iLeaderPackageCounter = 2 then
			SetEditValue(ElementByIndex(LeaderPackages, iLeaderPackages), PackageListFriSatSun[iRandom]);
			
		PackageListMonTues.Delete(iRandom);
		PackageListWedThurs.Delete(iRandom);
		PackageListFriSatSun.Delete(iRandom);
		
		inc(iLeaderPackageCounter);
	end;
	
	iLeaderPackageCounter := 0;
	
	LeadersPackageFormID01 := GetEditValue(ElementByPath(ElementByIndex(LeaderPackages, 0), 'PKID - Package'));
	LeadersPackageFormID02 := GetEditValue(ElementByPath(ElementByIndex(LeaderPackages, 1), 'PKID - Package'));
	LeadersPackageFormID03 := GetEditValue(ElementByPath(ElementByIndex(LeaderPackages, 2), 'PKID - Package'));
	
	LeadersPackage01 := ElementByIndex(LeaderPackages, 0);
	LeadersPackage02 := ElementByIndex(LeaderPackages, 1);
	LeadersPackage03 := ElementByIndex(LeaderPackages, 2);
	
	
	PackageListMonTues.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Travel Packages - MonTues.txt');
	PackageListWedThurs.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Travel Packages - WedThurs.txt');
	PackageListFriSatSun.LoadFromFile(ProgramPath + 'Edit Scripts\FyTy\NPC Travel Packages - FriSatSun.txt');
	
	NewFollowPackage := wbCopyElementToFile(OrigFollowPackage, MyFile, true, true);
	SetElementEditValues(ElementByIndex(ElementByPath(NewFollowPackage, 'Package Data\Data Input Values'), 0), 'PTDA - Target\Target Data\Reference', LeaderFormID);
	SetElementEditValues(NewFollowPackage, 'EDID - Editor ID', 'AAAFyTyFollowLeader'+GetElementEditValues(LeaderRecord, 'EDID - Editor ID'));
	FollowPackageFormID := GetElementEditValues(NewFollowPackage, 'Record Header\FormID');
	
	if iLeaderIndexCounter = 0 then begin
		iFollower01 := 0;
		iFollower02 := 1;
		iFollower03 := 2;
	end;
	
	if iLeaderIndexCounter > 0 then begin
	iLeaderIndexCounterTripled := iLeaderIndexCounter * 3;
	iFollower01 := iLeaderIndexCounterTripled - 2;
	iFollower02 := iLeaderIndexCounterTripled - 1;
	iFollower03 := iLeaderIndexCounterTripled;
	end;
	
	FollowerRecord01 := RecordByFormID(MyFile, FollowerList[iFollower01], true);
	
	FollowerPackages := Add(FollowerRecord01, 'Packages', false);
	SetEditValue(ElementByIndex(FollowerPackages, 0), FollowPackageFormID);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage01, false);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage02, false);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage03, false);
	
	
	FollowerRecord02 := RecordByFormID(MyFile, FollowerList[iFollower02], true);
	
	FollowerPackages := Add(FollowerRecord02, 'Packages', false);
	SetEditValue(ElementByIndex(FollowerPackages, 0), FollowPackageFormID);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage01, false);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage02, false);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage03, false);
	
	
	FollowerRecord03 := RecordByFormID(MyFile, FollowerList[iFollower03], true);
	
	FollowerPackages := Add(FollowerRecord03, 'Packages', false);
	SetEditValue(ElementByIndex(FollowerPackages, 0), FollowPackageFormID);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage01, false);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage02, false);
	ElementAssign(FollowerPackages, HighInteger, LeadersPackage03, false);
	
end;


{
function Process(e: IInterface): integer;
begin
	
end;
}

function Finalize: Integer;
begin

	for iProcess := 0 to LeaderList.Count - 1 do begin
		AddPackagesToNPCs;
		inc(iLeaderIndexCounter);
	end;
	
end;

end.