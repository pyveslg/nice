module Programmes

  # def self.set_price_collection(*ids)
  #     collection = []
  #     ids.each do |id|
  #       collection.push(Fees::FEES[id])
  #     end
  #     return collection
  # end

  Rails.configuration.after_initialize  do

    PROGRAMME = [
      {
        id: 0,
        title: "Face-to-Face 1-on-1 French Classes",
        code: "CPI"
      },
      {
        id: 1,
        title: "Online 1-on-1 French Classes",
        code: "CPO"
      }
    ]

    FBP = [
      {
        id: 0,
        title: "FrenchBooster Programme - Fall 2018",
        code: "FBP",
        start_from: Date.new(2018,9,22),
        end_at: Date.new(2018,12,8)
      }
    ]

  end

end
