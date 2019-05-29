## RefreshView 主要用户QtQuick里结合ListView和GridView实现数据的下拉刷新及上拉加载的实现
### 效果图如下

< div> <img src='https://github.com/zdc212133/RefreshView/blob/master/refresh_img.png'>
       <img src='https://github.com/zdc212133/RefreshView/blob/master/loadmore_img.png'> 
</div>

### 主要实现思路

1）利用ListView或GridView的header和footer属性，添加刷新或加载时的样式
2）获取ListView或GridView的滑动距离，动态显示或隐藏Header和Footer的样式

### 核心代码如下 

```
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

```
### 使用时注意在数据刷新完成后一定要调用hideView（）

### 试例如下

```
    ListView{
        anchors.fill: parent
        snapMode: ListView.NoSnap
        header: RefreshView{
            tips: "刷新中..."
            onRefeash: {
                //执行下拉刷新
                //执行完成后调用，hideView()
            }
        }
        footer: RefreshView{
            tips: "加载更多"
            onRefeash: {
                //执行上拉加载
                //执行完成后调用，hideView()
            }
        }
    }
```
