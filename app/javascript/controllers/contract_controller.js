import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['check', "conventionSignee", "hiddable"]
  connect() {
    this.checkTargets.forEach((check) => {
      if (check.checked) {
        this.checkValidate();
      }
    });
  }

  checkValidate(){
    this.conventionSigneeTarget.classList.toggle('hidden');
    this.hiddableTargets.forEach((hid) => {
      hid.classList.toggle('hidden');
    });
  }
}
