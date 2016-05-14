package
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;

    public class DataLoader
    {
        
        public function load ():void
        {
            var dataLoader:URLLoader = new URLLoader();
            dataLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
            dataLoader.addEventListener(Event.COMPLETE, dataLoadHandler);
            dataLoader.addEventListener(IOErrorEvent.IO_ERROR, dataIOErrorHandler);
            
            try
            {
                dataLoader.load(new URLRequest("http://www.domain.com/my_script.php?id=1234"));
            }
            catch (err:SecurityError)
            {
                trace("security error: " + err.message);
            }
        }
        
        private function dataLoadHandler (event:Event):void
        {
            trace("data: " + dataLoader.data);
        }
        
        private function dataIOErrorHandler (event:IOErrorEvent):void
        {
            trace("error: " + event.text);
        }
    }
}