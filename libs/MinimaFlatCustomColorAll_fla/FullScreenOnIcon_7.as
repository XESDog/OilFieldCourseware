package MinimaFlatCustomColorAll_fla
{
    import flash.display.*;
    import flash.events.*;

    dynamic public class FullScreenOnIcon_7 extends MovieClip
    {
        public var screenBack_mc:MovieClip;

        public function FullScreenOnIcon_7()
        {
            addFrameScript(0, frame1);
            return;
        }// end function

        function frame1()
        {
            stop();
            screenBack_mc.addEventListener(MouseEvent.MOUSE_OVER, animateScreen);
            return;
        }// end function

        public function animateScreen(event:MouseEvent) : void
        {
            gotoAndPlay(2);
            return;
        }// end function

    }
}
