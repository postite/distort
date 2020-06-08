package tests;
import utest.ui.Report;
import utest.Runner;
class Test{
   static public function main():Void
   {

      js.Browser.document.addEventListener("DOMContentLoaded",_->
      {
      var runnner = new Runner();
      runnner.addCase(new DistortTest());
      runnner.addCase(new LoadingTest());
      runnner.addCase(new MatrixTest());
      Report.create(runnner);
      runnner.run();
      });
   }
}