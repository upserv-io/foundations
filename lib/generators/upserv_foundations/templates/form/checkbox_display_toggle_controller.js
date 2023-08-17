// DO NOT EDIT THIS FILE. This file is autogenerated by Upserv Foundations.
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    // Get the checkbox and show / hide elements
    const checkbox = this.element
    const hideElements = document.getElementsByClassName(
      checkbox.dataset.hideClass
    )
    const showElements = document.getElementsByClassName(
      checkbox.dataset.showClass
    )

    // Add an event listener to the checkbox for the 'change' event
    checkbox.addEventListener('change', function () {
      for (let i = 0; i < hideElements.length; i++) {
        var hideElement = hideElements[i]
        hideElement.style.display = checkbox.checked
          ? 'none'
          : hideElement.dataset.display
      }
      for (let i = 0; i < showElements.length; i++) {
        let showElement = showElements[i]
        showElement.style.display = checkbox.checked
          ? showElement.dataset.display
          : 'none'
      }
    })
  }
}