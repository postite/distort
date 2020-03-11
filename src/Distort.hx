import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import js.jquery.Helper.*;
import js.jquery.JQuery;
import js.html.Image;

typedef Guide={
   x:Float,
   y:Float,
   r:Float
}
class Distort{

//
var isDown = false;
var PI2 = Math.PI * 2;
var selectedGuide = -1;
var guides:Array<Guide> = [];

var marginLeft = 50;
var marginTop = 50;

var iw:Int;
var ih:Float;
var cw:Float;
var ch:Float;

var can:JQuery;
var ctx:CanvasRenderingContext2D;
var img:Image;
var offsetX:Float;
var offsetY:Float;
var scrollX:Float;
var scrollY:Float;
public function new(canvas:JQuery){

this.can=canvas;
ctx = untyped(canvas.get()[0]).getContext("2d");
//var jcanvas = J("#canvas");
var canvasOffset = canvas.offset();
 offsetX = canvasOffset.left.Log("offsetleft");
 offsetY = canvasOffset.top;
 scrollX = canvas.scrollLeft();
 scrollY = canvas.scrollTop();

//

 img = new Image();
img.onload = start;
img.src = '
https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.eUrdpm1YuZDHtGvlrmCT4QHaHa%26pid%3DApi&f=1';
}

function start() {
   var ration = img.width/img.height;
   
   var ww=100;
   var hh=ww/ration;
    img.style.width='${ww}px';
    //img.style.height='${hh}px';
    //img.height=100;
      trace( img.width);
    iw = ww;
    ih = hh;
   //  can.width( iw + 100 );
   //  can.height(  ih + 100);
    cw = can.width();
    ch = can.height();
    ctx.strokeStyle = "blue";
    ctx.fillStyle = "blue";

    guides.push({
        x: 0,
        y: 0,
        r: 10
    });
    guides.push({
        x: 0,
        y: ih,
        r: 10
    });
    guides.push({
        x: iw,
        y: 0,
        r: 10
    });
    guides.push({
        x: iw,
        y: ih,
        r: 10
    });

    //
    can.mousedown(function (e) {
        handleMouseDown(e);
    });
   can.mousemove(function (e) {
        handleMouseMove(e);
    });
    can.mouseup(function (e) {
        handleMouseUp(e);
    });
    can.mouseout(function (e) {
        handleMouseOut(e);
    });

    drawAll();
}

function drawAll() {
    ctx.clearRect(0, 0, cw, ch);
    drawGuides();
    drawImage();
}

function drawGuides() {
    for ( guide in guides) {
        //var guide = guides[i];
        ctx.beginPath();
        ctx.arc(guide.x + marginLeft, guide.y + marginTop, guide.r, 0, PI2);
        ctx.closePath();
        ctx.fill();
    }
}

function drawImage() {

    // TODO use guides 

    
    var x1 = guides[0].x;
    var y1 = guides[0].y;
    var x2 = guides[2].x;
    var y2 = guides[2].y;
    var x3 = guides[1].x;
    var y3 = guides[1].y;
    var x4 = guides[3].x;
    var y4 = guides[3].y;


    // calc line equations slope & b (m,b)
    var m1 = Math.tan(Math.atan2((y2 - y1), (x2 - x1)));
    var b1 = y2 - m1 * x2;
    var m2 = Math.tan(Math.atan2((y4 - y3), (x4 - x3)));
    var b2 = y4 - m2 * x4;
    // draw vertical slices
    for (X in 0 ... iw) {
        var yTop = m1 * X + b1;
        var yBottom = m2 * X + b2;
        ctx.drawImage(img, X, 0, 1, ih,
        X + marginLeft, yTop + marginTop, 1, yBottom - yTop);
    }

    // outline
    ctx.save();
    ctx.translate(marginLeft, marginTop);
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.lineTo(x4, y4);
    ctx.lineTo(x3, y3);
    ctx.closePath();
    ctx.strokeStyle = "black";
    ctx.stroke();
    ctx.restore();
}



function handleMouseDown(e) {
   trace("down");
    e.preventDefault();
    trace(e.clientY,'cliney');
    var mouseX = (e.clientX - offsetX).Log("mouseX");
    var mouseY = (e.clientY - offsetY).Log("mouseY");

    // Put your mousedown stuff here
    selectedGuide = -1;
    for (i in 0...guides.length) {
        var guide = guides[i].Log();
        
        guide.x.Log('guide.x');
        guide.y.Log('guide.y');
        var dx = mouseX - (guide.x + marginLeft.Log("margin"));
        var dy = mouseY - (guide.y + marginTop.Log("top"));
        //var dy = mouseY - (guide.y + marginTop.Log("top"));
        dx.Log("dx");
        dy.Log("dy");
        if (((dx * dx) + (dy * dy)).Log("pyd") <= (guide.r * guide.r).Log('guide.r')) {
            selectedGuide = i;
            break;
        }
    }
    isDown = (selectedGuide >= 0);
    trace( selectedGuide);
}

function handleMouseUp(e) {
   trace("up");
    e.preventDefault();
    isDown = false;
}

function handleMouseOut(e) {
   trace("out");
    e.preventDefault();
    isDown = false;
}

function handleMouseMove(e) {
   trace("move");
    if (!isDown) {
        return;
    }
    e.preventDefault();
    var x = (e.clientX - offsetX) - marginLeft;
    var y = (e.clientY - offsetY) - marginTop;
    var guide = guides[selectedGuide];
    guides[selectedGuide].y = y;
    guides[selectedGuide].x = x;


    if (selectedGuide == 0 && y > guides[1].y) {
        guide.y = guides[1].y;
    }
    if (selectedGuide == 1 && y < guides[0].y) {
        guide.y = guides[0].y;
    }
    if (selectedGuide == 2 && y > guides[3].y) {
        guide.y = guides[3].y;
    }
    if (selectedGuide == 3 && y < guides[2].y) {
        guide.y = guides[2].y;
    }


    if (selectedGuide == 0 && x > guides[1].x) {
      guide.x = guides[1].x;
  }
  if (selectedGuide == 1 && x < guides[0].x) {
      guide.x = guides[0].x;
  }
  if (selectedGuide == 2 && x > guides[3].x) {
      guide.x = guides[3].x;
  }
  if (selectedGuide == 3 && x < guides[2].x) {
      guide.x = guides[2].x;
  }

    drawAll();
}

}