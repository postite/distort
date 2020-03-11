
import js.Browser.document as doc;
import js.jquery.Helper.*;
import PerspectiveDistort.DragPoints;
using Std;
class Main {
	
	function new(){
		
		J(doc).ready(init);
	}

	function init(){
		
		//J("#can").attr('name').Log();
		
		//new Distort(J("#can"));
		var elem=doc.querySelector("#imag");
		
		elem.style.width='${400}px';
		elem.style.height='${400}px';
		 new DragPoints().distort(elem);
		/*
		var transform=new PerspectiveDistort(
			elem,
			elem.style.width.parseInt(),
			elem.style.height.parseInt()
			);
	
		var parent=cast elem.parentNode;
		var dragPoints= new DragPoints(
			parent,
			{
			left:0,
			top:0,
			width:elem.style.width.parseInt(),
			height:elem.style.height.parseInt()
			}
			);
		dragPoints.signal.handle(p->dragPoints.modify(transform,p));
		*/
	}
		

	static function main() {
		new Main();
	}
}
