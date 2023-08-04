function checkAndSetTimezoneCookie() {
  var currentTimezone = Intl.DateTimeFormat().resolvedOptions().timeZone
  var expirationDate = new Date()
  expirationDate.setFullYear(expirationDate.getFullYear() + 1)

  document.cookie =
    'timezone=' +
    encodeURIComponent(currentTimezone) +
    '; expires=' +
    expirationDate.toUTCString() +
    '; path=/'
}
checkAndSetTimezoneCookie()
