package fl.video.skin
{
    import flash.display.*;

    dynamic public class VolumeBar extends MovieClip
    {
        public var hit_mc:MovieClip;
        public var fullness_mc:MovieClip;

        public function VolumeBar()
        {
            addFrameScript(0, frame1);
            return;
        }// end function

        function frame1()
        {
            fullness_mc.fill_mc.slideReveal = true;
            return;
        }// end function

    }
}
