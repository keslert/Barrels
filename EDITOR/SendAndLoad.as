﻿package {

	import flash.events.*
	import flash.net.*;
	
	public class SendAndLoad {
	
		public function SendAndLoad() {}
		public function sendData(url:String, _vars:URLVariables):void {
			var request:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			request.data = _vars;
			request.method = URLRequestMethod.POST;
			loader.addEventListener(Event.COMPLETE, handleComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}
		private function handleComplete(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			trace("Par: " + loader.data.par);
			trace("Message: " + loader.data.msg);
		}
		private function onIOError(event:IOErrorEvent):void {
			trace("Error loading URL.");
		}
	}
}
