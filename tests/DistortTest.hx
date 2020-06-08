package tests;
import js.Browser;
import js.html.Console;
import js.html.CanvasElement;
import js.Browser.document as doc;
import js.html.Element;
import utest.Test;
import utest.Assert;
import PerspectiveDistort;
using Lambda;
using Debug;
import postite.geom.CoolPoint;

class DistortTest extends Test{
  static var can:CanvasElement;
  var DG:DragPoints;
   public function new(){
      super();
      can=cast doc.querySelector("#conne");
      createGrid();
   }

   function teardown(){
     // getAnchors().iter(el->el.remove());
     DG.clear();
   }

  public function testme()
  {
     Assert.isTrue(1==1);
  }

  public function testAnchorsPos()
  {
   DG=new DragPoints().anchors(cast can.parentNode,
      {  
         left:can.offsetLeft,
         top:can.offsetTop,
         width:can.offsetWidth,
         height:can.height
      }
   ).distort(can);
   DG.memo.handle(n->{
      Browser.alert(n);
   });
   assertAnchors();
  }


  function testmarginsetc(){
     can.style.left='${300}px';
     can.style.left='${300}px';
     DG=new DragPoints().anchors(can.parentElement,cast can.getBoundingClientRect());
     assertAnchors();
  }

  


  

  

  public static  function assertAnchors(){
   getAnchors().iter(node->{
      switch (node.id){

         case "topleft":
            Assert.equals(can.offsetLeft,node.offsetLeft);
            Assert.equals(can.offsetTop,node.offsetTop);
         case "topright":
            Assert.equals(can.offsetLeft+ can.offsetWidth,node.offsetLeft);
         case "bottomright":
            Assert.equals(can.offsetLeft+ can.offsetWidth,node.offsetLeft);
            Assert.equals(can.offsetTop+ can.offsetHeight,node.offsetTop);
         case "bottomleft":
            Assert.equals(can.offsetTop+ can.offsetHeight,node.offsetTop);
         case _:Assert.fail();

      }
      
   });
  }

  public static function createGrid(){
   var context=can.getContext2d();
   var width = can.width,
    height = can.height;
   context.moveTo(10.5, 10 - 1);
   context.lineTo(10.5, 10 + 2);
   context.moveTo(10.5 -1, 10.5);
   context.lineTo(10.5 +2, 10.5);
   context.stroke();

var h=10,
    p=10;
   for( i in 0...width){
      p *= 2;
      context.drawImage(can, p, 0);
      //i+=p;
   }
   for(i in 0 ...height) {
      h *= 2;
      context.drawImage(can, 0, h);
      //i+=h;
   }
  }

  public static function getAnchors():Array<Element>{
    var li=doc.querySelectorAll(".distort_anchor");
    return [for (a in 0...li.length) cast li[a]];
  }
}