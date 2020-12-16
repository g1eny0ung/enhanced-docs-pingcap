chrome.runtime.onInstalled.addListener(function () {
  chrome.declarativeContent.onPageChanged.removeRules(undefined, function () {
    chrome.declarativeContent.onPageChanged.addRules([
      {
        conditions: [
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { hostPrefix: 'docs.pingcap.com', schemes: ['https'] },
          }),
        ],
        actions: [new chrome.declarativeContent.ShowPageAction()],
      },
    ])
  })
})

chrome.commands.onCommand.addListener(function (command) {
  if (command === 'lang-switch') {
    chrome.tabs.executeScript({
      file: 'lang-switch.js',
    })
  }
})
