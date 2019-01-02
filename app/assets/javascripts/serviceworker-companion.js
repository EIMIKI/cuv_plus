let cookies = document.cookie.split(";");
cookies.forEach(function(value){
  var cookie = value.split("=");
  user = cookie[1];
})

if (navigator.serviceWorker && user) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      regist_push(reg);
    });
}

function regist_push(reg){
  reg.pushManager.getSubscription().then(function(subscription){
    if (!subscription){
      reg.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: window.vapidPublicKey,
      }).then(subscribeSuccess);
      return;
    }
    subscribeSuccess(subscription);
  });
}

function subscribeSuccess(subscription){
  params={
    subscription: subscription.toJSON()
  }

  $.ajax({
    type:"POST",
    url:"/devices",
    data:params
  });
}
