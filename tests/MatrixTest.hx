package tests;



import js.Browser;
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


class MatrixTest extends Test{
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

  public function testme()
  {
     Assert.isTrue(1==1);
  }

  

 
  public function testLoadMatrix()
   {
       
        var DG=new DragPoints().load(LoadingTest.loadvisuel(),can.parentElement)
        .distort(can);
       // Assert.equals(untyped can.style.transform,LoadingTest.loadvisuel().matrice);
      // DG.memo.handle(n->{
      //    //var tt=untyped can.getContext2d().getTransform();
      //    Browser.console.log(DG.matrice);
      // });
         compareMatrix( can.style.transform,LoadingTest.loadvisuel().matrice);
      }

   

      function compareMatrix(a, b){
         var toTab=function(m:String){
            var reg:EReg=~/\(([^()]+)\)/;
            if( reg.match(m)){
            var tab= reg.matched(1).split(",");
            var tib=tab.map(n->Std.parseFloat(n));
            trace( tib);
            return tib;
            }
            return null;
         }
         var tabA= toTab(a);
         var tabB=toTab(b);

         tabA.mapi((i,n)->{
            Assert.floatEquals(n,tabB[i],0.1);
            n;
         });


         
      }
 
   
   

   

}