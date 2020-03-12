import js.html.AnchorElement;
import haxe.EnumTools;
import js.html.Element;
import js.Browser.document as doc;
import js.Browser.window as win;

using tink.CoreApi;
using Std;

typedef Point = {
	x:Float,
	y:Float
}

enum DragAnchor {
	TopLeft(p:DragPoint);
	TopRight(p:DragPoint);
	BottomLeft(p:DragPoint);
	BottomRight(p:DragPoint);
}

@:native("PerspectiveTransform")
extern class PerspectiveDistort {
	var topLeft:Point;
	var topRight:Point;
	var bottomLeft:Point;
	var bottomRight:Point;

	public function new(element:js.html.Element, width:Float, height:Float, ?useBackFacing:Bool);

	public function update():Void;
	public function checkError():Int;
}

typedef Bounds = {
	left:Float,
	top:Float,
	width:Float,
	height:Float
}

typedef AnchorMemo={
   topLeft:Point,
		topRight:Point,
		bottomLeft:Point,
		bottomRight:Point
}

class DragPoints {
   public var signal:tink.core.Signal<DragAnchor>;
   public var memo:tink.core.Signal<AnchorMemo>;
   
   public var anchorsMemo:AnchorMemo = cast {};
   
	var st:SignalTrigger<DragAnchor>;
	var sta:SignalTrigger<AnchorMemo>;
	var marginLeft = 0;
	var marginTop = 0;
	var defaultR = 15;
	var PI2 = Math.PI * 2;
	var guides:Array<DragAnchor>;
	var parent:Element;
	var bounds:Bounds;
	

	public function new() {

      st = new SignalTrigger();
      signal = st.asSignal();

      sta = new SignalTrigger();
		memo = sta.asSignal();
      
      
   }

	public function anchors(parent:Element, bounds:Bounds):DragPoints {
		this.parent = parent;
		
      generateGuides(bounds);
      initAnchorsMemo(bounds);
		drawGuides();
		return this;
   }
   
   public function load(anchors:AnchorMemo,parent:Element, bounds:Bounds){
      this.parent = parent;
      anchorsMemo=anchors;
      guides=[];
      guides.push(TopLeft({x: anchors.topLeft.x, y: anchors.topLeft.y, r: defaultR}));
		guides.push(TopRight({x: anchors.topRight.x, y: anchors.topRight.y, r: defaultR}));
		guides.push(BottomRight({x: anchors.bottomRight.x, y: anchors.bottomRight.y, r: defaultR}));
		guides.push(BottomLeft({x: anchors.bottomLeft.x, y: anchors.bottomLeft.y, r: defaultR}));
      drawGuides();
   //    bounds={
   // left:anchors.topLeft.x,
	// top:anchors.topLeft.y,
	// width:anchors.topRight.x- anchors.topLeft.x,
	// height:anchors.bottomRight.y- anchors.topRight.y
   //    };//todo
   this.bounds = bounds;
   }

	public function show(oui:Bool):DragPoints {
		if (oui)
			showguides();
		else
			hideguides();
		return this;
	}

	public function distort(elem:Element):DragPoints {
		if (this.bounds == null)
			this.anchors(cast elem.parentNode, boundsof(elem));

		var transform = new PerspectiveDistort(elem, bounds.width, bounds.height);

      this.signal.handle(p -> this.modify(transform, p));
     haxe.Timer.delay( function()this.modify(transform,TopLeft(cast {x:100,y:100})),1000);
		return this;
	}

	private function boundsof(elem:Element) {
		trace(elem);
		return cast {
			left: 0,
			top: 0,
			width: elem.style.width.parseInt(),
			height: elem.style.height.parseInt()
		};
	}

	public function modify(transform:PerspectiveDistort, anchor:DragAnchor):DragAnchor {
		{
         trace( "modify" +anchor);
        
			switch anchor {
				case TopLeft(p):
					transform.topLeft.x = p.x;
               transform.topLeft.y = p.y;
               anchorsMemo.topLeft=p;
				case TopRight(p):
					transform.topRight.x = p.x;
               transform.topRight.y = p.y;
               anchorsMemo.topRight=p;
				case BottomLeft(p):
					transform.bottomLeft.x = p.x;
               transform.bottomLeft.y = p.y;
               anchorsMemo.bottomLeft=p;
				case BottomRight(p):
					transform.bottomRight.x = p.x;
               transform.bottomRight.y = p.y;
               anchorsMemo.bottomRight=p;
            case null:
               transform.bottomRight.x = anchorsMemo.bottomRight.x;
               transform.bottomRight.y = anchorsMemo.bottomRight.y;
         }
         

			if (transform.checkError() == 0) {
				transform.update(); // update the perspective transform
				// elem.style.display = "block"; // show the element
			} else {
				transform.checkError();
				// elem.style.display = "none"; // hide the element
			}

			return anchor;
		}
	}

	function generateGuides(b:Bounds) {
		guides = [];
		guides.push(TopLeft({x: b.left, y: b.top, r: defaultR}));
		guides.push(TopRight({x: b.left + b.width, y: b.top, r: defaultR}));
		guides.push(BottomRight({x: b.left + b.width, y: b.top + b.height, r: defaultR}));
		guides.push(BottomLeft({x: b.left, y: b.top + b.height, r: defaultR}));
	}

	function initAnchorsMemo(b:Bounds) {
		anchorsMemo={
			topLeft: {x: b.left, y: b.top},
			topRight: {x: b.left + b.width, y: b.top},
			bottomLeft: {x: b.left, y: b.top + b.height},
			bottomRight: {x: b.left + b.width, y: b.top + b.height}
		}
	}
	function hideguides() {
		for (a in guidesElements)
			a.style.display = "none";
	}

	function showguides() {
		for (a in guidesElements)
			a.style.display = "block";
	}

	var guidesElements:Array<Element>;

	function drawGuides() {
		guidesElements = [];
		trace("draguides");
		for (guide in guides) {
			var point = switch (guide) {
				case TopLeft(point): point;
				case BottomLeft(point): point;
				case TopRight(point): point;
				case BottomRight(point): point;
			}

			var can = js.Browser.document.createCanvasElement();
			can.style.position = 'absolute';
			can.style.left = '${point.x}px';
			can.style.top = '${point.y}px';
			var ctx = can.getContext2d();
			ctx.fillStyle = "#cc3300";
			ctx.beginPath();
			ctx.arc(point.r, point.r, point.r, 0, PI2);
			ctx.closePath();
			ctx.fill();

			can.addEventListener("mousedown", onMouseDown.bind(_, guide));
			// can.addEventListener("mouseup",onMouseUp.bind(_,can));
			// can.addEventListener("mouseout",onMouseUp.bind(_,can));
			guidesElements.push(can);
			doc.body.appendChild(can);
		}
	}

	var moving = null;

	function onMouseDown(e, anchor) {
		var can = e.currentTarget;
		moving = onMove.bind(_, can, anchor);
		win.addEventListener("mousemove", moving);
		win.addEventListener("mouseup", onMouseUp.bind(_, can));
	}

	function onMouseUp(e, can:Element) {
		trace("mouse up");
      win.removeEventListener("mousemove", moving);
      sta.trigger(anchorsMemo);
	}

	function onMove(e, can:Element, anchor:DragAnchor) {
		// trace( can);
		// var can=e.currentTarget;
		// trace( 'move'+e.clientY);
		var name = EnumValueTools.getName(anchor);
		var anch = Type.createEnum(DragAnchor, name, [{x: e.clientX, y: e.clientY}]);
		st.trigger(anch);
		can.style.top = '${e.clientY}px';
		can.style.left = '${e.clientX}px';
	}
}

@:publicFields
@:structInit
class DragPoint {
	var x:Float;
	var y:Float;
	var r:Float;

	public function new(x, y, r) {
		this.x = x;
		this.y = y;
		this.r = r;
	}
}
