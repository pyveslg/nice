const initAttendeesForm = () => {
  const attNumberInput = document.getElementById('contract_attendee_number');
  if (attNumberInput) {
    attNumberInput.addEventListener('change', (e) => {
      const value = e.currentTarget.value;
      const attendeeForm = document.getElementById('attendees-form');
      attendeeForm.innerHTML = "";
      for (let i = value - 1; i >= 0; i--) {
        const inner = `<div class="form-for-attendees">
      <div class="form-group string required contract_attendees_first_name form-group-valid"><input class="form-control is-valid string required" type="text" value="" name="contract[attendees][${i}][first_name]" id="contract_attendees_${i}_first_name" placeholder="Prénom(s)"></div><div class="form-group string required contract_attendees_last_name form-group-valid"><input class="form-control is-valid string required" type="text" value="" name="contract[attendees][${i}][last_name]" id="contract_attendees_${i}_last_name" placeholder="Nom"></div><div class="form-group string required contract_attendees_position form-group-valid"><input class="form-control is-valid string required" type="text" value="" name="contract[attendees][${i}][position]" id="contract_attendees_${i}_position" placeholder="Fonction"></div></div>`
        attendeeForm.insertAdjacentHTML('beforeend', inner);
      }
    })
  }
}

export { initAttendeesForm };
