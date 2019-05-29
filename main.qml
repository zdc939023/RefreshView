import QtQuick 2.11
import QtQuick.Controls 2.4

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("RefreshViewSimple")

    header: ToolBar {
        Label {
            text: "RefreshViewSimple"
            anchors.centerIn: parent
        }
    }

    ListModel{
        id:listModel
    }


    function refreshData(){
        listModel.clear()
        for(var i=2;i<11;i++){
            listModel.append({"name":"title:"+i})
        }
    }

    function loadMoreData(){
        for(var i=11;i<20;i++){
            listModel.append({"name":"title:"+i})
        }
    }

    ListView{
        anchors.fill: parent
        snapMode: ListView.NoSnap
        model: listModel
        delegate: Text {
            height: 48
            width: parent.width
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: name
        }
        header: RefreshView{
            id:rv_refresh
            tips: "刷新中..."
            onRefeash: {
                timer.start()
            }
            Timer {
                id: timer
                interval:1000; running: false; repeat: false
                onTriggered:{
                    refreshData()
                    rv_refresh.hideView()
                }
            }
        }
        footer: RefreshView{
            id:rv_load
            tips: "加载更多"
            onRefeash: {
                loadMoreTimer.start()
            }
            Timer {
                id: loadMoreTimer
                property bool isRefresh: true
                interval:1000; running: false; repeat: false
                onTriggered:{
                    loadMoreData()
                    rv_load.hideView()
                }
            }
        }

        Component.onCompleted: {
            for(var i=0;i<10;i++){
                listModel.append({"name":"title:"+i})
            }
        }
    }
}
