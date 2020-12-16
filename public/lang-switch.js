;(function () {
  let pathname = document.location.pathname

  if (pathname.startsWith('/zh')) {
    pathname = pathname.slice(3)
  } else {
    pathname = `/zh${pathname}`
  }

  document.dispatchEvent(
    new CustomEvent('PASS_LOCATION_TO_EDP', {
      detail: JSON.stringify({ pathname }),
    })
  )
  document.dispatchEvent(
    new CustomEvent('EDP_NAVIGATE', {
      detail: pathname,
    })
  )
})()
