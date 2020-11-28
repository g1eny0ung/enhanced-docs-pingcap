// https://stackoverflow.com/questions/9602022/chrome-extension-retrieving-global-variable-from-webpage
setTimeout(function () {
  var globalHistory = DOCS_PINGCAP.globalHistory
  var navigate = DOCS_PINGCAP.navigate

  globalHistory.listen(function (result) {
    document.dispatchEvent(
      new CustomEvent('PASS_LOCATION_TO_EDP', {
        detail: JSON.stringify(result.location),
      })
    )
  })

  document.addEventListener('EDP_NAVIGATE', function (event) {
    navigate(event.detail)
  })
}, 1000) // Increase the delay to ensure that the main thread is fully loaded
