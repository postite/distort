package tests;

import utest.Async;
import js.html.CanvasElement;
import js.Browser.document as doc;
import js.html.Element;
import utest.Test;
import utest.Assert;
import PerspectiveDistort;
using Lambda;
import postite.geom.CoolPoint;
using Debug;

class LoadingTest extends Test{
   static var can:CanvasElement;
   var initwidth:Int;
   var DG:DragPoints;
   public function new(){
      super();
      can=cast doc.querySelector("#conne");
      initwidth=can.width;
   }

   function teardown(){
      //DistortTest.getAnchors().iter(el->el.remove());
      
   }

   function removeAfter(){
      DG.clear();
      
   }


  public function testme()
  {
     Assert.isTrue(1==1);
  }

  public static function loadvisuel():AnchorMemo{
     return {
      topLeft : {
         x : 8, 
         y : 8
      }, 
      topRight : {
         x : 308, 
         y : 8
      }, 
      bottomLeft : {
         x : 8, 
         y : 158
      }, 
      bottomRight : {
         x : 360, 
         y : 272
      },
      matrice:"matrix3d(0.995038613,0.057606857, 0,-0.001339701,0.066838733,1.182151167, 0,-0.000566430,0, 0, 1, 0,7.543151307,43.834834632, 0, 1)"

   }
  }

   function loadAnchors():AnchorMemo{
   var _topleft= {x:can.offsetLeft,y:can.offsetTop,r:12};
   var _topright= {x:can.offsetLeft+can.offsetWidth,y:can.offsetTop,r:12};
   var _bottomright={x:can.offsetLeft+can.offsetWidth,y:can.offsetTop+can.offsetHeight,r:12};
   var _bottomleft={x:can.offsetLeft,y:can.offsetTop+can.offsetHeight,r:12};
   
   return {
      
         topLeft:cast  _topleft,
         topRight: cast _topright,
         bottomRight: cast _bottomright,
         bottomLeft: cast _bottomleft,
         matrice:null
      
   }
  }
  public function testLoadAnchors()
   {
       
       var anchors=loadAnchors();
       DG=new DragPoints().load(anchors,can.parentElement);
       DistortTest.assertAnchors();
       removeAfter();
   }
 
   
//    public function testModifiedLoadedAnchors(){

//        var anchors=loadAnchors();
//        anchors.bottomRight={x:anchors.bottomRight.x,y:anchors.bottomRight.y+100};
      
//        DG=new DragPoints().load(anchors,can.parentElement);
//        DG.distort(can);
       
//        Assert.floatEquals(getBounds(can).width,can.width+10,1);
//        Assert.floatEquals(getBounds(can).height,can.height+10,1);
//        //removeAfter();
       
//    }
//    public function tostvisuelLoadedAnchors(){

//       var anchors=loadvisuel();
     
//       DG=new DragPoints().load(anchors,can.parentElement);
//       DG.distort(can);
      
//       Assert.floatEquals(getBounds(can).width,can.width+10,1);
//       Assert.floatEquals(getBounds(can).height,can.height+10,1);
//       removeAfter();
      
//   }

   inline function getBounds(elem){
     return  elem.getBoundingClientRect();
   }

}