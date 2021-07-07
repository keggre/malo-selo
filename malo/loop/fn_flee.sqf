if (!isServer) exitWith {};
if (random [0, 50, 100] != 1) exitWith {};

{if(side _x==civilian)then{

//Remove the eventHandler to prevent spamming 
_x removeAllEventHandlers "FiredNear";

_x addEventHandler["FiredNear",{
_civ=_this select 0;

	switch(round(random 2))do{
		case 0:{_civ switchMove "ApanPercMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
		case 1:{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
		case 2:{_civ playMoveNow "ApanPpneMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
		default{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};};

//nearestObjects[ PositionOrTarget, ["List","Of","Classnames","To","Look","For"], MaxDistanceToSearchAroundTarget ];
_nH=nearestObjects[_civ,nH_List,100];


_H=selectRandom _nH;//Pick an object found in the above nearestObjects array

_HP=_H buildingPos -1;//Finds list of all available building positions in the selected building

_HP=selectRandom _HP;//Picks a building position from the list of building positions

_civ doMove _HP;//Orders the civilian to move to the building position

}];};
}forEach allUnits-switchableUnits-playableUnits;