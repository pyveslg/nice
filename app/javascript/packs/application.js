import "bootstrap";
import "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import { French } from "flatpickr/dist/l10n/fr.js";
import confirmDatePlugin from "flatpickr/dist/plugins/confirmDate/confirmDate.js";
import "flatpickr/dist/themes/airbnb.css";
import 'select2';
import 'select2/dist/css/select2.css';


const datepicker = document.querySelector(".datepicker");
if (datepicker) {
  flatpickr(datepicker, {
    // plugins: [new confirmDatePlugin({})],
    locale: "fr",
    altInput: true
  })
}

const selectable = document.querySelectorAll(".select2");
selectable.forEach((item) => {
  $(item).select2({
  });
})
