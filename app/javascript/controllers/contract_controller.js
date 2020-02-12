import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['check', "conventionSignee", "payer", "hiddable"]
  connect() {
    this.checkTargets.forEach((check) => {
      if (check.checked) {
        this.checkValidate();
      }
    });
  }

  checkConventionValidate(){
    this.conventionSigneeTarget.classList.toggle('hidden');
    this.hiddableTargets.forEach((hid) => {
      hid.classList.toggle('hidden');
    });
  }

  checkPayerValidate(){
    this.payerTarget.classList.toggle('hidden');
  }
}
