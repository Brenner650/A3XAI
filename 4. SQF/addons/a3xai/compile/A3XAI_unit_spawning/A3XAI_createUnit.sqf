#include "\A3XAI\globaldefines.hpp"

private ["_unit", "_unitGroup", "_spawnPos", "_unitLevel", "_type"];
_unitGroup = _this select 0;
_unitLevel = _this select 1;
_spawnPos = _this select 2;
_antistuck = if ((count _this) > 3) then {_this select 3} else {false};

_unit = _unitGroup createUnit [DEFAULT_UNIT_CLASSNAME,_spawnPos,[],0,"FORM"];
[_unit] joinSilent _unitGroup;
0 = _unit call A3XAI_addUnitEH;
0 = [_unit, _unitLevel] call A3XAI_generateLoadout;									// Assign unit loadout
0 = [_unit, _unitLevel] call A3XAI_setSkills;										// Set AI skill
_unit enableFatigue false;

// Set Unit Name
_firstNames = ["Donald","Chelsea","Jeremy","Mark","Gabe","Roger","Barack","Edward","Julian","David","Bruce","Gordon","Jamie","Ainsley","Guy","James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio","Danny","Bryan","Tony","Luis","Mike","Stanley","Leonard","Nathan","Dale","Manuel","Rodney","Curtis","Norman","Allen","Marvin","Vincent","Glenn","Jeffery","Travis","Jeff","Chad","Jacob","Lee","Melvin","Alfred","Kyle","Francis","Bradley","Jesus","Herbert","Frederick","Ray","Joel","Edwin","Don","Eddie","Ricky","Troy","Randall","Barry","Alexander","Bernard","Mario","Leroy","Francisco","Marcus","Micheal","Theodore","Clifford","Miguel","Oscar","Jay","Jim","Tom","Calvin","Alex","Jon","Ronnie","Bill","Lloyd","Tommy","Leon","Derek","Warren","Darrell","Jerome","Floyd","Leo","Alvin","Tim","Wesley","Gordon","Dean","Greg","Jorge","Dustin","Pedro","Derrick","Dan","Lewis","Zachary","Corey","Herman","Maurice","Vernon","Roberto","Clyde","Glen","Hector","Shane","Ricardo","Sam","Rick","Lester","Brent","Ramon","Charlie","Tyler","Gilbert","Gene","Marc","Reginald","Ruben","Brett","Angel","Nathaniel","Rafael","Leslie","Edgar","Milton","Raul","Ben","Chester","Cecil","Duane","Franklin","Andre","Elmer","Brad","Gabriel","Ron","Mitchell","Roland","Arnold","Harvey","Jared","Adrian","Karl","Cory","Claude","Erik","Darryl","Jamie","Neil","Jessie","Christian","Javier","Fernando","Clinton","Ted","Mathew","Tyrone","Darren","Lonnie","Lance","Cody","Julio","Kelly","Kurt","Allan","Nelson","Guy","Clayton","Hugh","Max","Dwayne","Dwight","Armando","Felix","Jimmie","Everett","Jordan","Ian","Wallace","Ken","Bob","Jaime","Casey","Alfredo","Alberto","Dave","Ivan","Johnnie","Sidney","Byron","Julian","Isaac","Morris","Clifton","Willard","Daryl","Ross","Virgil","Andy","Marshall","Salvador","Perry","Kirk","Sergio","Marion","Tracy","Seth","Kent","Terrance","Rene","Eduardo","Terrence","Enrique","Freddie","Wade","Ben"]; 
_lastNames = ["Trump","Manning","Corbyn","Zuckerberg","Newell","Federer","Obama","Snowden","Assange","Beckham","Jenner","Ramsey","Oliver","Harriot","Fieri","Smith","Jones","Brown","Johnson","Williams","Taylor","Davis","Miller","Wilson","White","Thomas","Clark","Hall","Thompson","Moore","Hill","Walker","Wright","Martin","Allen","Robinson","Wood","Adams","Jackson","Evans","Lewis","Green","Anderson","King","Baker","Roberts","Harris","John","Scott","Young","James","Lee","Parker","Turner","Cook","Campbell","Edwards","Davies","Morris","County","Ward","Stewart","Phillips","Morgan","Cooper","Mitchell","Hughes","Bell","Rogers","Watson","Carter","Harrison","Mc","Richardson","Murphy","Collins","Foster","Gray","Reed","Miss","Howard","Henry","Russell","Bennett","Fisher","Price","Cox","Shaw","Island","Bailey","Stevens","Marshall","Washington","Palmer","Hamilton","Nelson","Church","Clarke","Mills","Butler","Mason","Hunt","Kelly","George","William","May","Stone","Brooks","Ellis","Porter","Barnes","West","Simpson","Wells","Wm","Holmes","Webb","Ford","Powell","Reynolds","Cole","Sullivan","Richards","Chapman","Fox","Murray","Long","Day","Lincoln","Hart","Graham","Webster","Gibson","Alexander","Wallace","Wheeler","Perry","Kennedy","Henderson","Jenkins","Ross","Warren","Co","Spencer","Lawrence","Lane","Andrews","Knight","Rice","Gardner","Barker","Johnston","Robertson","Grant","Street","Hunter","Gordon","Hayes","Page","Arnold","Fletcher","Armstrong","Ann","Dunn","City","Mary","Patterson","Peterson","Burns","Black","Fuller","Carpenter","Perkins","Harvey","College","Myers","Elliott","Freeman","Rose","Tucker","Woods","Payne","Lloyd","Dixon","Owen","Hopkins","Pierce","Newton","Bradley","Wilkinson","Carr","Curtis","Pearson","Fellows","Crawford","French","Ball","Bishop","Nichols","Baldwin","Potter","Burton","Ryan","Berry","Hudson","Frank","Dean","Warner","Pratt","Matthews","Gilbert","House","Sherman","Booth","Brien","Coleman","Hawkins","Parsons","Douglas","Morrison","Austin","Bryan","Franklin","Dawson","Field","Newman","Griffin","Park","Francis","Walsh","Burke","Williamson","Morton","Bates","Geo","Holland","Barrett","Oliver","Hale","Howe","Sharp","Marsh","Ferguson","Atkinson","Norton","Gould","Stephens","Davidson","Simmons","Snyder","Fowler","Sanders","Harper","Clay","Bryant","Barber","Riley","Carroll","Cross","Barton","Charles","Holt","Boyd","Little","Peters","It","Cunningham","Watts","Stevenson","Reid","Mann","Saunders","Griffiths","Willis","Elizabeth","Jordan","Duncan","Hammond","Stuart","Thomson","Lynch","Owens","Connor","Hutchinson","Hicks","Walter","Stanley","Howell","Walton","Gregory","Weaver","Sutton","Paul","Welch","Miles","Goodwin","Cooke","Chas","Blake","Todd","Kelley","Leonard","Harding","Chandler","Abbott","Robert","Jane","Chambers","Joseph","Jennings","Wade","Bird","Gill","Lowe","Watkins","Stovell"];
_firstName = selectRandom _firstNames;
_lastName = selectRandom _lastNames;
_unit setName format["%1 %2",_firstName,_lastName];

// Add Exile Poptabs to Unit
_AIMoney = round (random [25, 100, 250]);
_unit setVariable ["ExileMoney",_AIMoney,true];

// PurgeCrap
_unit setVariable ["DO_NOT_CLEAN", true];

A3XAI_monitoredObjects pushBack _unit;

if (_antistuck) then {
	_unit setPosATL _spawnPos;
	_unit setVelocity [0,0,0.5];
};

if (A3XAI_debugLevel > 0) then {diag_log format["A3XAI Debug: Spawned AI %1 with unitLevel %2 for group %3.",_unit,_unitLevel,_unitGroup];};

_unit