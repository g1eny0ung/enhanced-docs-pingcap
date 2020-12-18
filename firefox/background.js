browser.commands.onCommand.addListener(function (command) {
  if (command === 'lang-switch') {
    browser.tabs.executeScript({
      file: 'lang-switch.js',
    })
  }
})
