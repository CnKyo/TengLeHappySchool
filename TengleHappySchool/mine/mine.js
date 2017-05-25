//index.js
//获取应用实例
var app = getApp()
Page({
  data: {
    userInfo: {},
    userListInfo:[
      {
        icon:'../../images/my_activity.png',
        text:'我的活动',
        url:'my_active/actives/actives'
      },
      {
        icon:'../../images/my_laundry.png',
        text:'我的洗衣',
        url: 'my_laundry/laundry/laundry'
      },
      {
        icon: '../../images/my_task.png',
        text: '我的任务',
        url: 'my_task/tasks/tasks'
      },
      {
        icon: '../../images/my_order.png',
        text: '我的订单',
        url: 'my_order/orders/orders'
      },
      {
        icon: '../../images/my_msg.png',
        text: '我的消息',
        url: 'my_msg/msg_list/msg_list'
      },
      {
        icon: '../../images/help.png',
        text: '帮助中心',
        url: 'help_center/help_center'
      },
      {
        icon: '../../images/join_us.png',
        text: '加入我们',
        url: 'join_us/join_us'
      },
      {
        icon: '../../images/contact_us.png',
        text: '联系我们',
        url: 'contact_us/contact_us'
      }
    ]
  },
  //事件处理函数
  bindViewTap: function() {
    wx.navigateTo({
      url: '../logs/logs'
    })
  },
  onLoad: function () {
    var that = this
    //调用应用实例的方法获取全局数据
    app.getUserInfo(function(userInfo){
      //更新数据
      that.setData({
        userInfo:userInfo
      })
    })
  }
})
