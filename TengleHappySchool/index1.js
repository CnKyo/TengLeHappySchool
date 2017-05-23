function hello(){

    window.webkit.messageHandlers.AppModel.postMessage({body: {'id':'1','name':'firstClicked'}});
}
