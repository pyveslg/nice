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
        code: "CPIO"
      },
      {
        id: 2,
        title: "Evening French Classes",
        code: "EFC",
        sessions: [
          DateTime.new(2018,10,16),
          DateTime.new(2018,10,30),
          DateTime.new(2018,11,6),
          DateTime.new(2018,11,13),
          DateTime.new(2018,11,20),
          DateTime.new(2018,11,27),
          DateTime.new(2018,12,4),
          DateTime.new(2018,12,11),
          DateTime.new(2018,12,18),
          DateTime.new(2019,1,8),
          DateTime.new(2019,1,15),
          DateTime.new(2019,1,22),
          DateTime.new(2019,1,29),
          DateTime.new(2019,2,5),
          DateTime.new(2019,2,12),
          DateTime.new(2019,2,19),
          DateTime.new(2019,2,26),
          DateTime.new(2019,3,5),
          DateTime.new(2019,3,12),
          DateTime.new(2019,3,19),
          DateTime.new(2019,3,26),
          DateTime.new(2019,4,2),
          DateTime.new(2019,4,9),
          DateTime.new(2019,4,16),
          DateTime.new(2019,4,23),
          DateTime.new(2019,4,30),
          DateTime.new(2019,5,14),
          DateTime.new(2019,5,21),
          DateTime.new(2019,5,28),
          DateTime.new(2019,6,4),
          DateTime.new(2019,6,11),
          DateTime.new(2019,6,18),
          DateTime.new(2019,6,25)
        ]
      }
    ]

    FBP = [
      {
        id: 2,
        title: "FrenchBooster Programme - Fall 2018",
        code: "FBP",
        start_from: Date.new(2018,9,29),
        end_at: Date.new(2018,12,8),
        second_payment: Date.new(2018,10,20),
        third_payment: Date.new(2018,11,20)
      },
      {
        id: 3,
        title: "FrenchBooster Programme - Winter 2019",
        code: "FBP",
        start_from: Date.new(2019,1,19),
        end_at: Date.new(2019,3,30),
        second_payment: Date.new(2019,2,11),
        third_payment: Date.new(2019,3,11)
      },
      {
        id: 4,
        title: "FrenchBooster Programme - Spring 2019",
        code: "FBP",
        start_from: Date.new(2019,4,6),
        end_at: Date.new(2019,6,22),
        second_payment: Date.new(2019,5,6),
        third_payment: Date.new(2019,6,6)
      }
    ]

  end

end
