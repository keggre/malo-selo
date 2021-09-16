// PARSES MAGAZINE DETAIL INTO AN ARRAY

if (false) exitWith {};

private _fnc = {

	private _detail = _this;

	private _index_op = (_detail find "(");
	private _index_sl = (_detail find "/");
	private _index_cp = (_detail find ")");
	private _index_ob = (_detail find "[");
	private _index_cb = (_detail find "]");

	private _type = _detail select [0, _index_op];
	private _current = parseNumber (_detail select [_index_op + 1, _index_sl - _index_op]);
	private _capacity = parseNumber (_detail select [_index_sl + 1, _index_cp - _index_sl]);

	[_type, [_current, _capacity]]

};

if (typeName _this == "ARRAY") then {
	private _details = _this;
	private _return = [];
	{
		private _detail = _x;
		_return append [_x call _fnc];
	} forEach _details;
	_return
} else {
	if (typename _this == "OBJECT") then {
		private _object = _this;
		private _details = magazinesDetail _object;
		private _return = [];
		{
			private _detail = _x;
			_return append [_x call _fnc];
		} forEach _details;
		_return
	} else {
		private _detail = _this;
		private _return = _detail call _fnc;
		_return
	};
};

/*[
	"3OF56 HE(10/10)[id/cr:10012819/2]",
	"53-D-462 Smoke(2/2)[id/cr:10012820/2]",
	"53-S-463 Flare(2/2)[id/cr:10012821/2]",
	"3OF69M LG(2/2)[id/cr:10012822/2]"
]*/