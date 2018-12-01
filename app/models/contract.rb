# SCHEMA CONTRACT

# t.integer "programme"
# t.integer "client_type"
# t.integer "hourly_rate"
# t.date "start_from"
# t.date "end_at"
# t.string "target"
# t.string "sessions", default: [], array: true
# t.integer "frequency"
# t.string "teacher"
# t.integer "payment_condition"
# t.datetime "sign_date"
# t.string "first_name"
# t.string "last_name"
# t.string "tel"
# t.string "email"
# t.string "address"
# t.string "zipcode"
# t.string "city"
# t.string "company"
# t.string "position"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false


class Contract < ApplicationRecord
  CLIENT_TYPE = [
    {
      id: 0,
      title: "Individual"
    },
    {
      id: 1,
      title: "Business"
    }
  ]

  TARGET = ["A1.1", "A1.2", "A2.1", "A2.2", "B1.1", "B1.2", "B2.1", "B2.2", "C1.1", "C1.2"]


  def hours_by_sessions
  end

  def number_of_sessions
  end

  def hours_by_sessions_2
  end

  def number_of_sessions_2
  end

  def number_of_classes
  end

  def number_of_weeks
  end

  def self.contracts_count(date, contract)
    contracts = Contract.all.where("sign_date = ?", date)
    contracts.empty? ? 1 : contracts.find_index(contract) + 1
  end

  def contract_number
    if code == "FBP"
      "NOV-#{code}-#{sign_date.strftime("%Y%m%d")}-0#{Contract.contracts_count(sign_date, self)}"
    else
      if client_type == 0 || client_type.nil?
        "NOV-#{Programmes::PROGRAMME[programme][:code]}-#{sign_date.strftime("%Y%m%d")}-0#{Contract.contracts_count(sign_date, self)}"
      else
        "NOV-#{Programmes::PROGRAMME[programme][:code].upcase}-#{company[0,3].upcase}#{sign_date.strftime("%Y%m%d")}-0000#{Contract.contracts_count(sign_date, self)}"
      end
    end
  end

  def set_programme_title
    if code == "FBP"
      Programmes::FBP[programme - Programmes::FBP[0][:id]][:title].upcase
    else
      Programmes::PROGRAMME[programme][:title].upcase
    end
  end

  def duration
    new_sessions = sessions.select do |session|
      session if session[0] != ""
    end
    duration = []
    new_sessions.each do |session|
      duration.push((session[0].to_i) * (session[1].to_f))
    end
    duration.inject(0){|sum, x| sum + x.to_i}
  end

  def set_price
     Fees::FEES[hourly_rate][:value]
  end

  def total_amount
    duration * set_price
  end

  def efc_total_amount
    new_session = sessions.select{|session| session if !session[0].nil?}[0]
    new_session[0].to_i * set_price
  end

  def programme_duration
    (end_at - start_from)
  end

  def first_payment_date
    if sign_date + 14 >= start_from
      payment_date = sign_date
    else
      payment_date = sign_date + 14
      if payment_date.wday == 6 || payment_date.wday == 7
        if (payment_date + 1).wday == 7
          payment_date = sign_date + 16
        else
          payment_date = sign_date + 15
        end
      end
    end
    return payment_date
  end

  def calcul_payment_date(payment_date, pourcent)
    pourcent_course = duration * pourcent
    hours_a_week = sessions_by_week * average_hours_by_session
    week_to_end_pourcent = pourcent_course.fdiv(hours_a_week).ceil
    number_of_days = week_to_end_pourcent * 7
    new_date = (payment_date + number_of_days).at_beginning_of_month.next_month
    (new_date.month == 1) ? new_date += 14 : new_date -= 14
    new_date.beginning_of_month
  end

  def efc_calcul_payment_date(start_date, number_of_weeks, pourcent)
    dates = Programmes::PROGRAMME[2][:sessions]
    dates.slice(dates.find_index(start_date), number_of_weeks * pourcent)[-1]
  end

  def sessions_by_week
    frequency[0].to_i.fdiv(frequency[1].to_i)
  end

  def average_hours_by_session
    hours = duration
    new_sessions = sessions.select do |session|
      session if session[0] != ""
    end
    total_number_sessions = []
    new_sessions.each do |session|
      total_number_sessions.push((session[0].to_i))
    end
    hours.fdiv(total_number_sessions.inject(0){|sum, x| sum + x.to_i})
  end

  def access_fbp_hash
    Programmes::FBP[programme - Programmes::FBP[0][:id]]
  end

end
