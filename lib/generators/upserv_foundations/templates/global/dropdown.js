function hideDropDowns() {
  const dropdownPopUpClones = document.getElementsByClassName(
    'dropdown-items-clone'
  )

  for (const dropdownPopUpClone of dropdownPopUpClones) {
    dropdownPopUpClone.remove()
  }
}
document.addEventListener('click', () => {
  hideDropDowns()
})

document.addEventListener('wheel', () => {
  hideDropDowns()
})
window.addEventListener('resize', () => {
  hideDropDowns()
})
