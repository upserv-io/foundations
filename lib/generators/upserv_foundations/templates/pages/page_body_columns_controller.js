import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    // Call the function initially and whenever the window is resized
    this.adjustPageBodyColumnsHeight()
    window.addEventListener('resize', this.adjustPageBodyColumnsHeight)

    // Call the function initially and when the columns change size (ie get hidden)
    this.adjustPageBodyColumnsPaddingAndMargin()
    const body = document.getElementById('page-body-columns')
    const pageBodyColumns = body.querySelectorAll('.page-body-column')
    const resizeCallback = () => {
      this.adjustPageBodyColumnsPaddingAndMargin()
    }
    const observers = []
    pageBodyColumns.forEach((pageBodyColumn) => {
      const observer = new ResizeObserver(resizeCallback)
      observer.observe(pageBodyColumn)
      observers.push(observer)
    })
  }

  adjustPageBodyColumnsHeight() {
    const container = document.getElementById('page-container')
    const header = document.getElementById('page-header')
    const body = document.getElementById('page-body-columns')

    const containerHeight = container.clientHeight
    const headerHeight = header?.clientHeight || 0
    // Get the computed styles of the container to include padding
    const containerStyles = window.getComputedStyle(container)
    const paddingTop = parseFloat(containerStyles.paddingTop)
    const paddingBottom = parseFloat(containerStyles.paddingBottom)

    const bodyHeight =
      containerHeight - headerHeight - paddingTop - paddingBottom

    body.style.height = bodyHeight + 'px'
  }

  adjustPageBodyColumnsPaddingAndMargin() {
    const body = document.getElementById('page-body-columns')
    const pageBodyColumns = body.querySelectorAll('.page-body-column')
    let lastVisibleChild = null
    // find last visible child and remove last visible column class from all (later we
    // add it backt to last visible child - this makes sure only last visible column actually
    // has the last visible column class
    for (let i = pageBodyColumns.length - 1; i >= 0; i--) {
      const pageBodyColumn = pageBodyColumns[i]
      const computedStyle = window.getComputedStyle(pageBodyColumn)
      if (lastVisibleChild === null && computedStyle.display !== 'none') {
        lastVisibleChild = pageBodyColumn
      }
      pageBodyColumn.classList.remove('last-visible-column')
    }
    lastVisibleChild.classList.add('last-visible-column')
  }
}
