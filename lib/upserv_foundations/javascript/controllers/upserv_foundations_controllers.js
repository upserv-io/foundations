import { Controller } from '@hotwired/stimulus'

export class DropdownController extends Controller {
  static targets = ['popup', 'button']
  show() {
    this.popupTarget.style.display = 'block'
  }

  hide(event) {
    if (
      event &&
      (this.popupTarget.contains(event.target) ||
        this.buttonTarget.contains(event.target))
    ) {
      return
    }

    this.popupTarget.style.display = 'none'
  }
}
