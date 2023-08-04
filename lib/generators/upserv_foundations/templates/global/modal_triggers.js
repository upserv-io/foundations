function createElmForModal(htmlString) {
  var tempDiv = document.createElement('div')
  tempDiv.innerHTML = htmlString.trim()
  return tempDiv.firstChild
}
document.addEventListener('click', (event) => {
  const modalTrigger = event.target.closest('[data-target-modal]')

  if (modalTrigger) {
    const updateModal = modalTrigger.dataset.updateModal
    if (updateModal) {
      // if the last item in the list is ";", then an empty item will be added to the array.
      // Remove it
      const updates = modalTrigger.dataset.updateModal
        .split(';')
        .filter((element) => element !== '')
      for (let update of updates) {
        const split = update.trim().split('.')
        const selector = split[0]
        const actionOrAttribute = split[1]
        const value = split[2]
        const target = document.querySelector(selector)
        if (actionOrAttribute.toLowerCase() === 'innerhtml') {
          target.innerHTML = value
        } else if (actionOrAttribute.toLowerCase() === 'remove') {
          if (target) target.remove()
        } else if (actionOrAttribute.toLowerCase() === 'prepend') {
          let newElm = createElmForModal(value)
          target.prepend(newElm)
        } else {
          target.setAttribute(actionOrAttribute, value)
        }
      }
    }
    const triggerElm = document.getElementById(
      `${modalTrigger.dataset.targetModal}-trigger`
    )
    // there should always be a triggerElm if there is a modalTrigger but just in case...
    if (triggerElm) {
      document
        .getElementById(`${modalTrigger.dataset.targetModal}-trigger`)
        .click()
    }
  }
  // NOTE: this is old and only works if actual event target has the attribute.
  // the above is new and checks if any of the parents have the attribute so that the click
  // event doesn't have to be on the exact element that has the data-target-modal attribute
  // if (event.target.matches('[data-target-modal]')) {
  //   const modalTrigger = event.target

  //   const updateModal = modalTrigger.dataset.updateModal
  //   if (updateModal) {
  //     const updates = modalTrigger.dataset.updateModal.split(';')
  //     for (let update of updates) {
  //       const split = update.trim().split('.')
  //       const selector = split[0]
  //       const actionOrAttribute = split[1]
  //       const value = split[2]
  //       const target = document.querySelector(selector)
  //       if (actionOrAttribute.toLowerCase() === 'innerhtml') {
  //         target.innerHTML = value
  //       } else {
  //         target.setAttribute(actionOrAttribute, value)
  //       }
  //     }
  //   }
  //   const triggerElm = document.getElementById(`${modalTrigger.dataset.targetModal}-trigger`)
  //   document.getElementById(`${modalTrigger.dataset.targetModal}-trigger`).click();
  // }
})
