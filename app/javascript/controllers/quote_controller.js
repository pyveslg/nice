import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['check', "hiddable", "pace", "hours", "frequency", "days", "time", "timeslots", "schedules"]
  connect() {

  }

  initParticipants() {
    const value = event.currentTarget.value;
    const participantsForm = document.getElementById('attendees-form');
    participantsForm.innerHTML = "";
    for (let i = value - 1; i >= 0; i--) {
      const inner = `<div class="form-for-attendees">
    <div class="form-group string required quote_participants_first_name form-group-valid"><input class="form-control is-valid string required" type="text" value="" name="quote[participants][${i}][first_name]" id="quote_participants_${i}_first_name" placeholder="Prénom(s)"></div><div class="form-group string required quote_participants_last_name form-group-valid"><input class="form-control is-valid string required" type="text" value="" name="quote[participants][${i}][last_name]" id="quote_participants_${i}_last_name" placeholder="Nom"></div><div class="form-group string required quote_participants_position form-group-valid"><input class="form-control is-valid string required" type="text" value="" name="quote[participants][${i}][position]" id="quote_participants_${i}_position" placeholder="Fonction"></div></div>`
      participantsForm.insertAdjacentHTML('beforeend', inner);
    }
  }

  checkValidate(){
    // this.conventionSigneeTarget.classList.toggle('hidden');
    // this.hiddableTargets.forEach((hid) => {
    //   hid.classList.toggle('hidden');
    // });
  }

  addPaceOption(){
    const paceDiv = document.getElementById("programme-pace");
    const options = this.paceTargets.length;
    const option = `<div class="pace-option" data-target="quote.pace">
                      <div class="sessions-input string optional quote_sessions_number_of_sessions" data-action="change->quote#computeHoursAndSessions">
                        <input class="form-control string optional" placeholder="20" type="text" name="quote[sessions][${options}][number_of_sessions]" id="quote_sessions_${options}_number_of_sessions">
                        <p>sessions de</p>
                      </div>
                      <div class="duration-input select optional quote_sessions_hours_by_sessions" data-action="change->quote#computeHoursAndSessions">
                        <select class="form-control select optional" name="quote[sessions][${options}][hours_per_session]" id="quote_sessions_${options}_hours_per_session">
                          <option value="1">1</option>
                          <option value="1.25">1.25</option>
                          <option value="1.5" selected>1.5</option>
                          <option value="2">2</option>
                          <option value="2.5">2.5</option>
                          <option value="3">3</option>
                        </select>
                        <p>heures</p>
                      </div>
                      <div class="add-pace-option" data-action="click->quote#addPaceOption">
                        <i class="fa fa-plus-circle"></i>
                      </div>
                    </div>`;
    paceDiv.insertAdjacentHTML('afterbegin', option);
  }

  removePaceOption(){
    event.currentTarget.parentElement.remove();
    this.computeHoursAndSessions();
  }

  computeHoursAndSessions() {
    // Calcul du nombre d'heures totales de la formation
    const computeHours = (option) => {
      const inputValue = parseInt(option.querySelector('input').value, 10);
      const selectValue = parseFloat(option.querySelector('select').value);
      return [inputValue, selectValue].reduce((a, x) => a * x, 1);
    }

    // Création JSON d'une option de session (nombres de session et durée par session)
    const computeSessions = (option) => {
      const inputValue = parseInt(option.querySelector('input').value, 10);
      const selectValue = parseFloat(option.querySelector('select').value);
      const session = {};
      session["number_of_sessions"] = inputValue;
      session["hours_per_session"] = selectValue;
      return JSON.stringify(session);
    }

    // Change value of quote.hours in form + visual dynamic update
    const hoursArray = this.paceTargets.map((option) => computeHours(option));
    const hours = hoursArray.reduce((a,x) => a + x, 0);
    const hoursInput = document.getElementById('quote_hours');
    hoursInput.value = hours;
    this.hoursTarget.innerText = hours;

    // Change value of quote.sessions in form
    // const sessionsInput = document.getElementById('quote_sessions');
    // const sessionsArray = this.paceTargets.map((option) => computeSessions(option));
    // sessionsInput.value = sessionsArray;

    this.generateCalendar();
  }

  computeFrequency() {
    const classesValue = document.querySelector('#package-frequency #quote_classes').value;
    const periodValue = document.querySelector('#package-frequency #quote_period').value;
    const frequency = {};
    frequency["classes"] = classesValue;
    frequency["period"] = periodValue;
    this.frequencyTarget.value = JSON.stringify(frequency);

    this.generateCalendar();
  }

  computePreferredDays() {
    // If label is checked, take value to_i
    const checkIfChecked = (label) => {
      if (label.classList.contains('checked')){
        return parseInt(label.dataset.value, 10);
      }
    }

    event.currentTarget.classList.toggle('checked');
    const dayLabels = Array.from(document.querySelectorAll('label.day-check'));
    const values = dayLabels.map((label) => checkIfChecked(label))
                            .filter(value => value !== undefined)
                            .sort((a , x) => a - x);
    // affect array to quote.day_of_classes
    this.daysTarget.value = values;

    this.generateCalendar();
  }

  addTimeOption(){
    const timeslotDiv = document.getElementById("programme-timeslots");
    const options = this.timeTargets.length;
    const option = `<div class="timeslots-option form-group" data-target="quote.time">
                      <div class="timing-selector start">
                        <p>À</p>
                        <input class="form-control text optional timepicker" data-action="change-> quote#generateCalendar" data-target="quote.timeslots" type="text" name="quote[timeslots][]" id="quote_hour_start_at_${options}">
                      </div>
                      <div class="add-pace-option" data-action="click->quote#removeTimeOption">
                        <i class="fa fa-minus-circle"></i>
                      </div>
                    </div>`;
    timeslotDiv.insertAdjacentHTML('beforeend', option);
    timeslotDiv.lastChild.querySelectorAll('input').forEach((timepicker) => {
      flatpickr(timepicker, {
        locale: "fr",
        altInput: true,
        enableTime: true,
        noCalendar: true,
        dateFormat: "H:i",
        minTime: "07:00",
        maxTime: "21:00",
        time_24hr: true
      });
    });
  }

  removeTimeOption(){
    event.currentTarget.parentElement.remove();
    this.computeTimeSlots();
  }

  generateCalendar(){
    const computeNumberOfSessions = (option) => {
      return parseInt(option.querySelector('input').value, 10);
    }
    /// nombre de sessions dans le calendrier
    const numberOfSessions = this.paceTargets.map((option) => computeNumberOfSessions(option)).reduce((a,x) => a + x, 0);
    /// heures dispos
    const timeSlots = this.timeslotsTargets.map((time) => time.value);
    console.log(timeSlots);
    const timeSlotsHours = timeSlots.map((time) => parseInt(time.split(':')[0]));
    /// Heure de démarrage du premier cours
    const firstTime = timeSlots[0].split(':');
    /// premier jour de cours
    const firstDay = document.getElementById('quote_start_from').value.split('-');
    const firstDate = new Date(firstDay[0],firstDay[1] - 1,firstDay[2], firstTime[0], firstTime[1]);
    console.log(firstDate);
    /// Jours disponibles

    const nextCDay = (day) => {
      const days = this.daysTarget.value.split(',').map((value) => parseInt(value));
      const index = days.indexOf(day);
      if (index < days.length - 1) {
        return days[index + 1]
      } else {
        return days[0];
      }
    }

    /// Calcul le nombre de jours à incrémenter si sessions par semaine
    const periodWeekIncrement = (date) => {
      const cwDay = date.getDay();
      const nextCwDay = nextCDay(cwDay);
      if (nextCwDay === cwDay) {
        return 7;
      }
      if (nextCwDay > cwDay) {
        return (nextCwDay - cwDay);
      }
      if (nextCwDay < cwDay) {
        return 7 - cwDay + nextCwDay;
      }
      // if (period === "mois") {
      //   const currentYear = date.getYear();
      //   const currentMonth = date.getMonth();
      //   return new Date(currentYear, currentMonth, 0).getDate();
      // };
    }

    const periodDayIncrement = (date) => {
      const cwDay = date.getDay();
      const nextCwDay = nextCDay(cwDay);
      if (nextCwDay === cwDay + 1) {
        return 1;
      }
      if (nextCwDay > cwDay + 1) {
        return (nextCwDay - cwDay);
      }
      if (nextCwDay < cwDay) {
        return 7 - cwDay + nextCwDay;
      }
      // if (period === "mois") {
      //   const currentYear = date.getYear();
      //   const currentMonth = date.getMonth();
      //   return new Date(currentYear, currentMonth, 0).getDate();
      // };
    }

    /// Calcul le nombre de jours


    Date.prototype.addDays = function (days) {
      const date = new Date(this.valueOf());
      date.setDate(date.getDate() + days);
      return date;
    }

    const nextDate = (previousDate, period, timeSlotsHours, timeSlots, classes) => {
      if ( period === "semaine" ) {
        return previousDate.addDays(periodWeekIncrement(previousDate));
      }
      if ( period === "jour" ) {
        const session_hours = previousDate.getHours();
        const index = timeSlotsHours.sort((a, x) => a - x ).indexOf(session_hours);
        const rankedTimeSlots = timeSlots.sort((a, x) => parseInt(a, 10) - parseInt(x, 10));
        let followingDate = previousDate;
        if (index == timeSlotsHours.length - 1) {
          const atHour = parseInt(rankedTimeSlots[0].split(':')[0],10);
          const atMin = parseInt(rankedTimeSlots[0].split(':')[1], 10);
          const newDate = previousDate.addDays(periodDayIncrement(previousDate));
          console.log(new Date(newDate.setHours(atHour, atMin, 0)));
          followingDate = new Date(newDate.setHours(atHour, atMin, 0));
        } else {
          const atHour = parseInt(rankedTimeSlots[index + 1].split(':')[0], 10);
          const atMin = parseInt(rankedTimeSlots[index + 1].split(':')[1], 10);
          followingDate = new Date(previousDate.setHours(atHour, atMin, 0));
        }
        return followingDate;
      }
    }

    /// period
    const frequency = JSON.parse(this.frequencyTarget.value);
    const period = frequency.period;
    const classes = parseInt(frequency.classes, 10);
    // console.log(nextDate(firstDate, period, timeSlotsHours, timeSlots, classes));
    const schedulesDiv = document.getElementById('quote-schedules');
    schedulesDiv.innerHTML = "";
    schedulesDiv.insertAdjacentHTML('beforeend', `<div class="form-group schedule-option">
                                      <label for="quote_0">Session#0</label>
                                      <input data-target="quote.schedules" class="text optional datetimepicker" type="text" value="${firstDate.toISOString()}" name="quote[schedules][]" id="quote_0" >
                                    </div>`);
    const firstInput = document.getElementById('quote_0');
    flatpickr(firstInput, {
      locale: "fr",
      altInput: true,
      enableTime: true,
      altFormat: "D F j, Y, H:i",
      minTime: "07:00",
      maxTime: "21:00",
      time_24hr: true
    });
    let previousDate = firstDate;
    for ( let i = 1; i < numberOfSessions; i++ ) {
      let followingDate = nextDate(previousDate, period, timeSlotsHours, timeSlots, classes);
      let content = ` <div class="form-group schedule-option">
                        <label for="quote_${i}">Session#${i + 1}</label>
                        <input data-target="quote.schedules" class="text optional datetimepicker" type="text" value="${followingDate.toISOString()}" name="quote[schedules][]" id="quote_${i}" >
                      </div>`;
      schedulesDiv.insertAdjacentHTML('beforeend', content);
      let input = document.getElementById(`quote_${i}`)
      flatpickr(input, {
        locale: "fr",
        altInput: true,
        altFormat: "D F j, Y, H:i",
        enableTime: true,
        minTime: "07:00",
        maxTime: "21:00",
        time_24hr: true
      });
      previousDate = followingDate;
    }
    // this.computeSchedules();
  }

  toggleSchedules() {
    const schedulesDiv = document.getElementById('quote-schedules');
    schedulesDiv.classList.toggle('hidden');
  }
}
