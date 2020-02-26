const initDatePicker = () => {
  const datepickers = document.querySelectorAll(".datepicker");
  datepickers.forEach((datepicker) => {
    flatpickr(datepicker, {
      // plugins: [new confirmDatePlugin({})],
      locale: "fr",
      altInput: true
    })
  })
}

const initTimePicker = () => {
  const timepickers = document.querySelectorAll(".timepicker");
  timepickers.forEach((timepicker) => {
    flatpickr(timepicker, {
      // plugins: [new confirmDatePlugin({})],
      locale: "fr",
      altInput: true,
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      minTime: "07:00",
      maxTime: "21:00",
      time_24hr: true
    })
  })
}


export { initDatePicker, initTimePicker };

