package MinimaFlatCustomColorAll_fla
{
    import fl.video.skin.*;
    import flash.display.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var bufferingBarFill_mc:MovieClip;
        public var playpause_mc:PlayButtonNormal;
        public var volumeBarHandle_mc:VolumeBarHandle;
        public var bufferingBar_mc:BufferingBar;
        public var fullScreenToggle_mc:FullScreenButtonOnNormal;
        public var border_mc:UnderChromeFill;
        public var seekBarHandle_mc:SeekBarHandle;
        public var forwardBackFrame_mc:ForwardBackBorder;
        public var shadow_mc:UnderChromeShadow;
        public var volumeMute_mc:MuteButtonOnNormal;
        public var seekBar_mc:SeekBar;
        public var captionToggle_mc:CaptionButtonOnNormal;
        public var seekBarHit_mc:SeekBarHit;
        public var video_mc:VideoPlaceholder;
        public var seekBarProgress_mc:SeekBarProgress;
        public var back_mc:BackButtonNormal;
        public var outline_mc:UnderChromeOutline;
        public var counter_mc:Counter;
        public var volumeBar_mc:VolumeBar;

        public function MainTimeline()
        {
            addFrameScript(0, frame1);
            return;
        }// end function

        function frame1()
        {
            this.pauseButtonDisabledState = "fl.video.skin.PauseButtonDisabled";
            this.pauseButtonDownState = "fl.video.skin.PauseButtonDown";
            this.pauseButtonNormalState = "fl.video.skin.PauseButtonNormal";
            this.pauseButtonOverState = "fl.video.skin.PauseButtonOver";
            this.playButtonDisabledState = "fl.video.skin.PlayButtonDisabled";
            this.playButtonDownState = "fl.video.skin.PlayButtonDown";
            this.playButtonNormalState = "fl.video.skin.PlayButtonNormal";
            this.playButtonOverState = "fl.video.skin.PlayButtonOver";
            this.stopButtonDisabledState = "fl.video.skin.StopButtonDisabled";
            this.stopButtonDownState = "fl.video.skin.StopButtonDown";
            this.stopButtonNormalState = "fl.video.skin.StopButtonNormal";
            this.stopButtonOverState = "fl.video.skin.StopButtonOver";
            this.backButtonDisabledState = "fl.video.skin.BackButtonDisabled";
            this.backButtonDownState = "fl.video.skin.BackButtonDown";
            this.backButtonNormalState = "fl.video.skin.BackButtonNormal";
            this.backButtonOverState = "fl.video.skin.BackButtonOver";
            this.forwardButtonDisabledState = "fl.video.skin.ForwardButtonDisabled";
            this.forwardButtonDownState = "fl.video.skin.ForwardButtonDown";
            this.forwardButtonNormalState = "fl.video.skin.ForwardButtonNormal";
            this.forwardButtonOverState = "fl.video.skin.ForwardButtonOver";
            this.muteButtonOffDisabledState = "fl.video.skin.MuteButtonOffDisabled";
            this.muteButtonOffDownState = "fl.video.skin.MuteButtonOffDown";
            this.muteButtonOffNormalState = "fl.video.skin.MuteButtonOffNormal";
            this.muteButtonOffOverState = "fl.video.skin.MuteButtonOffOver";
            this.muteButtonOnDisabledState = "fl.video.skin.MuteButtonOnDisabled";
            this.muteButtonOnDownState = "fl.video.skin.MuteButtonOnDown";
            this.muteButtonOnNormalState = "fl.video.skin.MuteButtonOnNormal";
            this.muteButtonOnOverState = "fl.video.skin.MuteButtonOnOver";
            this.captionButtonOffDisabledState = "fl.video.skin.CaptionButtonOffDisabled";
            this.captionButtonOffDownState = "fl.video.skin.CaptionButtonOffDown";
            this.captionButtonOffNormalState = "fl.video.skin.CaptionButtonOffNormal";
            this.captionButtonOffOverState = "fl.video.skin.CaptionButtonOffOver";
            this.captionButtonOnDisabledState = "fl.video.skin.CaptionButtonOnDisabled";
            this.captionButtonOnDownState = "fl.video.skin.CaptionButtonOnDown";
            this.captionButtonOnNormalState = "fl.video.skin.CaptionButtonOnNormal";
            this.captionButtonOnOverState = "fl.video.skin.CaptionButtonOnOver";
            this.fullScreenButtonOffDisabledState = "fl.video.skin.FullScreenButtonOffDisabled";
            this.fullScreenButtonOffDownState = "fl.video.skin.FullScreenButtonOffDown";
            this.fullScreenButtonOffNormalState = "fl.video.skin.FullScreenButtonOffNormal";
            this.fullScreenButtonOffOverState = "fl.video.skin.FullScreenButtonOffOver";
            this.fullScreenButtonOnDisabledState = "fl.video.skin.FullScreenButtonOnDisabled";
            this.fullScreenButtonOnDownState = "fl.video.skin.FullScreenButtonOnDown";
            this.fullScreenButtonOnNormalState = "fl.video.skin.FullScreenButtonOnNormal";
            this.fullScreenButtonOnOverState = "fl.video.skin.FullScreenButtonOnOver";
            this.bufferingBar = "fl.video.skin.BufferingBar";
            this.bufferingBarFill = "fl.video.skin.BufferingBarFill";
            this.seekBar = "fl.video.skin.SeekBar";
            this.seekBarHandle = "fl.video.skin.SeekBarHandle";
            this.seekBarHit = "fl.video.skin.SeekBarHit";
            this.seekBarProgress = "fl.video.skin.SeekBarProgress";
            this.volumeBar = "fl.video.skin.VolumeBar";
            this.volumeBarHandle = "fl.video.skin.VolumeBarHandle";
            this.minWidth = 320;
            this.minHeight = 0;
            this.border_mc.colorMe = true;
            this.border_mc.anchorLeft = true;
            this.border_mc.anchorRight = true;
            this.outline_mc.anchorLeft = true;
            this.outline_mc.anchorRight = true;
            this.shadow_mc.anchorLeft = true;
            this.shadow_mc.anchorRight = true;
            this.counter_mc.anchorRight = true;
            this.volumeBar_mc.anchorRight = true;
            this.volumeMute_mc.anchorRight = true;
            this.fullScreenToggle_mc.anchorRight = true;
            this.captionToggle_mc.anchorRight = true;
            this.seekBar_mc.anchorLeft = true;
            this.seekBar_mc.anchorRight = true;
            this.seekBarHit_mc.anchorLeft = true;
            this.seekBarHit_mc.anchorRight = true;
            this.bufferingBar_mc.anchorLeft = true;
            this.bufferingBar_mc.anchorRight = true;
            return;
        }// end function

    }
}
