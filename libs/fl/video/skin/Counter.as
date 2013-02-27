package fl.video.skin
{
    import fl.video.*;
    import flash.display.*;
    import flash.text.*;

    dynamic public class Counter extends Sprite
    {
        public var totalTimes:Array;
        private var _uiMgr:UIManager;
        public var time_txt:TextField;

        public function Counter()
        {
            totalTimes = new Array();
            return;
        }// end function

        private function handleReady(event:VideoEvent) : void
        {
            var _loc_2:* = _uiMgr._vc.getVideoPlayer(event.vp).totalTime;
            if (isNaN(_loc_2))
            {
                totalTimes[event.vp] = null;
            }
            var _loc_3:String = "/";
            var _loc_4:* = _loc_2 / 60;
            var _loc_5:* = _loc_2 % 60;
            if (_loc_4 < 10)
            {
                _loc_3 = _loc_3 + "0";
            }
            _loc_3 = _loc_3 + _loc_4;
            _loc_3 = _loc_3 + ":";
            if (_loc_5 < 10)
            {
                _loc_3 = _loc_3 + "0";
            }
            _loc_3 = _loc_3 + _loc_5;
            totalTimes[event.vp] = _loc_3;
            return;
        }// end function

        public function set uiMgr(param1:UIManager) : void
        {
            if (_uiMgr != null && _uiMgr._vc != null)
            {
                _uiMgr._vc.removeEventListener(VideoEvent.PLAYHEAD_UPDATE, handlePlayheadUpdate);
                _uiMgr._vc.removeEventListener(VideoEvent.READY, handleReady);
            }
            _uiMgr = param1;
            if (_uiMgr != null && _uiMgr._vc != null)
            {
                _uiMgr._vc.addEventListener(VideoEvent.PLAYHEAD_UPDATE, handlePlayheadUpdate);
                _uiMgr._vc.addEventListener(VideoEvent.READY, handleReady);
            }
            return;
        }// end function

        public function get uiMgr() : UIManager
        {
            return _uiMgr;
        }// end function

        private function handlePlayheadUpdate(event:VideoEvent) : void
        {
            if (event.vp != _uiMgr._vc.visibleVideoPlayerIndex)
            {
                return;
            }
            var _loc_2:String = "";
            var _loc_3:* = event.playheadTime / 60;
            var _loc_4:* = event.playheadTime % 60;
            if (_loc_3 < 10)
            {
                _loc_2 = _loc_2 + "0";
            }
            _loc_2 = _loc_2 + _loc_3;
            _loc_2 = _loc_2 + ":";
            if (_loc_4 < 10)
            {
                _loc_2 = _loc_2 + "0";
            }
            _loc_2 = _loc_2 + _loc_4;
            if (totalTimes[event.vp] != null)
            {
                _loc_2 = _loc_2 + totalTimes[event.vp];
            }
            time_txt.text = _loc_2;
            return;
        }// end function

    }
}
