import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    // set display to flex
    this.element.style.visibility = 'visible'
    // Set the width of the children on load
    this.setChildrenWidth()
    // add event listner window resize event to set children width
    window.addEventListener('resize', this.setChildrenWidth.bind(this))
  }

  setChildrenWidth() {
    // Select the cardWrapper element
    const cardWrapper = this.element
    // get the minPx data attribute and convert to integer
    const minPx = parseInt(cardWrapper.dataset.minPx)
    const children = cardWrapper.children

    // Get the computed width of the cardWrapper element
    const cardWrapperWidth = cardWrapper.getBoundingClientRect().width

    // Calculate how many 400px children can fit inside the cardWrapper without wrapping
    const maxChildren = Math.floor(cardWrapperWidth / minPx)

    // if maxChildren is greater than or equal to number of children
    // set denominator to number of children
    const denominator =
      maxChildren >= children.length ? children.length : maxChildren

    // Calculate the width each child should have to fit without breaking minPx
    const childWidthPercentage = 100 / denominator

    // Set the width of all direct children
    for (let child of children) {
      child.style.width = `${childWidthPercentage}%`
    }
  }
}
