import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

import "bootstrap";
import "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import { French } from "flatpickr/dist/l10n/fr.js";
import confirmDatePlugin from "flatpickr/dist/plugins/confirmDate/confirmDate.js";
import "flatpickr/dist/themes/airbnb.css";
import 'select2';
import 'select2/dist/css/select2.css';
import { initAttendeesForm } from '../components/attendees';
import { initDatePicker, initTimePicker, initDateTimePicker } from '../components/datepicker';





initDatePicker();
initTimePicker();
initDateTimePicker();
global.initTimePicker = initTimePicker;
initAttendeesForm();
