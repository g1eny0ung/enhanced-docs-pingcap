document.addEventListener('DOMContentLoaded', restoreOptions)
document.getElementById('save').addEventListener('click', saveOptions)

function saveOptions() {
  var historyNum = document.getElementById('history').value

  chrome.storage.sync.set(
    {
      historyNum,
    },
    function () {
      var status = document.getElementById('status')
      status.textContent = 'Saved!'

      setTimeout(function () {
        status.textContent = ''
      }, 1500)
    }
  )
}

function restoreOptions() {
  chrome.storage.sync.get(
    {
      historyNum: 5,
    },
    function (items) {
      document.getElementById('history').value = items.historyNum
    }
  )
}
