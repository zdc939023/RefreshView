import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id:control
    height: visible? viewHeight:0
    width: parent.width
    visible: false
    property int viewHeight:60
    property Item controlObj: parent.parent
    property bool viewDragging: controlObj.dragging
    property bool hasRefresh: true
    property string tips:"tips"
    readonly property bool isHeader: controlObj.headerItem.toString()===control.toString()

    signal refeash()

    Row{
        spacing: 8
        anchors.centerIn: parent
        BusyIndicator{
            width: 32
            height: 32
            running: visible
        }
        Label{
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
            text: tips
        }
    }

    onViewDraggingChanged: {
        if(!viewDragging){
            if(hasRefresh&&isHeader&&controlObj.contentY<-viewHeight){
                visible=true
                refeash()
            }
            if(hasRefresh&&!isHeader&&controlObj.contentY>0&&
                    controlObj.contentY>controlObj.contentHeight+viewHeight-controlObj.height){
                visible=true
                refeash()
            }
        }
    }

    function hideView(){
        visible=false
    }
}
