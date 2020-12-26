document.addEventListener('DOMContentLoaded', restoreOptions)
document.getElementById('save').addEventListener('click', saveOptions)

function saveOptions() {
  var historyNum = document.getElementById('history').value

  browser.storage.sync
    .set({
      historyNum,
    })
    .then(function () {
      var status = document.getElementById('status')
      status.textContent = 'Saved!'

      setTimeout(function () {
        status.textContent = ''
      }, 1500)
    })
}

function restoreOptions() {
  browser.storage.sync
    .get({
      historyNum: 5,
    })
    .then(function (items) {
      document.getElementById('history').value = items.historyNum
    })
}
