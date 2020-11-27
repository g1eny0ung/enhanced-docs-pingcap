setTimeout(function () {
  DOCS_PINGCAP.globalHistory.listen(function (result) {
    document.dispatchEvent(
      new CustomEvent('PASS_LOCATION_TO_EDP', {
        detail: JSON.stringify(result.location),
      })
    )
  })
}, 1000)
