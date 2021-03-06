// Generated by Haxe 4.0.1
(function ($global) { "use strict";
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var Debug = function() { };
Debug.__name__ = true;
Debug.Log = function(val,msg,pos) {
	if(msg == null) {
		msg = "";
	}
	haxe_Log.trace(" " + msg,{ fileName : "src/Debug.hx", lineNumber : 4, className : "Debug", methodName : "Log", customParams : [val]});
	return val;
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
Math.__name__ = true;
var Render = function() {
	haxe_Log.trace("olé",{ fileName : "src/Render.hx", lineNumber : 10, className : "Render", methodName : "new"});
	window.document.addEventListener("DOMContenLoaded",$bind(this,this.init));
};
Render.__name__ = true;
Render.main = function() {
	new Render();
};
Render.prototype = {
	init: function() {
		this.can = window.document.querySelector("#conne");
		var display = new postite_display_canvas_CanvasDisplay();
		var rend = new TestRender();
		display.addRenderable(rend);
		rend.enabled = true;
		display.enterframe(30);
	}
};
var TestRender = function() {
	this.enabled = true;
};
TestRender.__name__ = true;
TestRender.prototype = {
	render: function(render) {
		haxe_Log.trace("render",{ fileName : "src/Render.hx", lineNumber : 39, className : "TestRender", methodName : "render"});
		render.ctx.fillStyle = "#cc3300";
		render.ctx.fillRect(0,0,100,100);
	}
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var haxe_Log = function() { };
haxe_Log.__name__ = true;
haxe_Log.formatOutput = function(v,infos) {
	var str = Std.string(v);
	if(infos == null) {
		return str;
	}
	var pstr = infos.fileName + ":" + infos.lineNumber;
	if(infos.customParams != null) {
		var _g = 0;
		var _g1 = infos.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			str += ", " + Std.string(v1);
		}
	}
	return pstr + ": " + str;
};
haxe_Log.trace = function(v,infos) {
	var str = haxe_Log.formatOutput(v,infos);
	if(typeof(console) != "undefined" && console.log != null) {
		console.log(str);
	}
};
var haxe_ds_ObjectMap = function() {
	this.h = { __keys__ : { }};
};
haxe_ds_ObjectMap.__name__ = true;
haxe_ds_ObjectMap.prototype = {
	set: function(key,value) {
		var id = key.__id__ || (key.__id__ = $global.$haxeUID++);
		this.h[id] = value;
		this.h.__keys__[id] = key;
	}
	,remove: function(key) {
		var id = key.__id__;
		if(this.h.__keys__[id] == null) {
			return false;
		}
		delete(this.h[id]);
		delete(this.h.__keys__[id]);
		return true;
	}
	,keys: function() {
		var a = [];
		for( var key in this.h.__keys__ ) {
		if(this.h.hasOwnProperty(key)) {
			a.push(this.h.__keys__[key]);
		}
		}
		return HxOverrides.iter(a);
	}
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	if(Error.captureStackTrace) {
		Error.captureStackTrace(this,js__$Boot_HaxeError);
	}
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g3 = 0;
			var _g11 = o.length;
			while(_g3 < _g11) {
				var i = _g3++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e1 ) {
			var e2 = ((e1) instanceof js__$Boot_HaxeError) ? e1.val : e1;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str1 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str1.length != 2) {
			str1 += ", \n";
		}
		str1 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str1 += "\n" + s + "}";
		return str1;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var postite_display_Display = function(render) {
	this.renderEngine = render;
	this.renderables = new haxe_ds_ObjectMap();
};
postite_display_Display.__name__ = true;
postite_display_Display.prototype = {
	clearRenderables: function() {
		var r = this.renderables.keys();
		while(r.hasNext()) {
			var r1 = r.next();
			this.renderables.remove(r1);
		}
	}
	,addRenderable: function(renderable) {
		this.renderables.set(renderable,true);
	}
	,removeRenderable: function(renderable) {
		this.renderables.remove(renderable);
	}
	,render: function() {
		this.renderEngine.clear();
		var renderable = this.renderables.keys();
		while(renderable.hasNext()) {
			var renderable1 = renderable.next();
			if(renderable1.enabled) {
				this.renderEngine.beforeEach();
				renderable1.render(this.renderEngine);
				this.renderEngine.afterEach();
			}
		}
	}
};
var postite_display_canvas_CanvasDisplay = function() {
	this.paused = false;
	this.display = new postite_display_Display(new postite_display_canvas_CanvasRender(this.createCanvas()));
};
postite_display_canvas_CanvasDisplay.__name__ = true;
postite_display_canvas_CanvasDisplay.prototype = {
	get_canvas: function() {
		if(this._can == null) {
			this.createCanvas();
		}
		return this._can;
	}
	,enterframe: function(fps) {
		var _gthis = this;
		this.fps = fps;
		var elapsed;
		var fpsInterval = 1000 / fps;
		var then = new Date();
		var now;
		var startTime = then;
		haxe_Log.trace(startTime,{ fileName : "postite/display/canvas/CanvasDisplay.hx", lineNumber : 38, className : "postite.display.canvas.CanvasDisplay", methodName : "enterframe"});
		var frame = 0;
		this.raf = ($_=window,$bind($_,$_.requestAnimationFrame));
		var animate = null;
		animate = function(timestamp) {
			if(_gthis.paused) {
				return;
			}
			_gthis.raf(animate);
			now = new Date();
			elapsed = now.getTime() - then.getTime();
			if(elapsed > fpsInterval) {
				then = new Date(now.getTime() - elapsed % fpsInterval);
				var x = frame += 1;
				_gthis.onFrame(x | 0);
				_gthis.display.render();
			}
		};
		this.onFrame = function(f) {
		};
		this.raf(animate);
	}
	,togPause: function() {
		haxe_Log.trace("paused=" + Std.string(this.paused),{ fileName : "postite/display/canvas/CanvasDisplay.hx", lineNumber : 69, className : "postite.display.canvas.CanvasDisplay", methodName : "togPause"});
		this.paused = !this.paused;
		if(!this.paused) {
			this.enterframe(this.fps);
		}
	}
	,clearRenderables: function() {
		this.display.clearRenderables();
	}
	,addRenderable: function(renderable) {
		this.display.addRenderable(renderable);
	}
	,removeRenderable: function(renderable) {
		this.display.removeRenderable(renderable);
	}
	,render: function() {
		this.display.render();
	}
	,createCanvas: function() {
		haxe_Log.trace("create canvas",{ fileName : "postite/display/canvas/CanvasDisplay.hx", lineNumber : 94, className : "postite.display.canvas.CanvasDisplay", methodName : "createCanvas"});
		this._can = window.document.createElement("canvas");
		this._can.width = window.innerWidth;
		this._can.height = window.innerHeight;
		window.document.body.appendChild(this._can);
		return this._can;
	}
	,remove: function() {
		this._can.remove();
		this._can = null;
	}
};
var postite_display_canvas_CanvasRender = function(canvas) {
	this.canvas = canvas;
	this.ctx = canvas.getContext("2d",null);
	this.ctx.save();
};
postite_display_canvas_CanvasRender.__name__ = true;
postite_display_canvas_CanvasRender.prototype = {
	clear: function() {
		this.ctx.clearRect(0,0,this.canvas.width,this.canvas.height);
	}
	,beforeEach: function() {
		this.ctx.save();
	}
	,afterEach: function() {
		this.ctx.restore();
	}
};
var $_;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = "Date";
haxe_ds_ObjectMap.count = 0;
Object.defineProperty(js__$Boot_HaxeError.prototype,"message",{ get : function() {
	return String(this.val);
}});
js_Boot.__toStr = ({ }).toString;
Render.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=distort.js.map