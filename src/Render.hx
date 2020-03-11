import PerspectiveDistort.DragPoints;
import js.html.CanvasRenderingContext2D;
import postite.display.canvas.CanvasRender;
import js.html.CanvasElement;
import postite.display.canvas.CanvasDisplay;
import js.Browser.document as doc;

class Render{
   var can:CanvasElement;

  public function new(){
     trace( "olé");
     doc.addEventListener("DOMContentLoaded",init);
     
  }
  function init(){

   //can=cast doc.querySelector("#conne");
   var display=new CanvasDisplay({width:200,height:200});
   var rend= new TestRender();
   
   display.addRenderable(rend);

   rend.enabled=true;
   display.enterframe(2);
   var can=display.canvas;
      new DragPoints().anchors(cast can.parentNode,
         {  
            left:can.offsetLeft,
            top:can.offsetTop,
            width:can.offsetWidth,
            height:can.height
         }
      ).distort(can);
   
   
  }
  static public function main():Void
  {
     new Render();
  }
}

class TestRender implements postite.display.canvas.CanvasDisplay.IRenderCan{
   public var enabled:Bool=true;
   var boidz=[for (a in 0... 30){x:Math.random()*100,y:Math.random()*100}];
   public function new(){

   }

   public function update(){
      trace( "update");
      boidz=boidz.map(p->
         {x:p.x+1,
         y:p.y+1

      });
   }

   public function render(render:CanvasRender){
      update();
      trace( "render");
      for ( a in boidz)
         pointing(a,render.ctx);

   }

   function pointing(b,ctx:CanvasRenderingContext2D){
      
      ctx.beginPath();
      ctx.fillStyle = "#00AAFF";
      ctx.arc(b.x, b.y, 3, 0, 2 * Math.PI, false);
      ctx.fill();
   }

}