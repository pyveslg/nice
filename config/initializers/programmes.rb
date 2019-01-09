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
        title: "Weekly French Classes",
        code: "WFC",
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
          DateTime.new(2019,1,12),
          DateTime.new(2019,1,19),
          DateTime.new(2019,1,26),
          DateTime.new(2019,2,2),
          DateTime.new(2019,2,9),
          DateTime.new(2019,2,16),
          DateTime.new(2019,2,23),
          DateTime.new(2019,3,9),
          DateTime.new(2019,3,16),
          DateTime.new(2019,3,23),
          DateTime.new(2019,3,30),
          DateTime.new(2019,4,6),
          DateTime.new(2019,4,13),
          DateTime.new(2019,4,20),
          DateTime.new(2019,5,4),
          DateTime.new(2019,5,11),
          DateTime.new(2019,5,18),
          DateTime.new(2019,5,25),
          DateTime.new(2019,6,8),
          DateTime.new(2019,6,15),
          DateTime.new(2019,6,22)
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
        title: "FrenchBooster Programme - Saturdays - Winter 2019",
        code: "FBP",
        start_from: Date.new(2019,1,19),
        end_at: Date.new(2019,3,30),
        second_payment: Date.new(2019,2,11),
        third_payment: Date.new(2019,3,11)
      },
      {
        id: 4,
        title: "FrenchBooster Programme - Mondays - Winter 2019",
        code: "FBP",
        start_from: Date.new(2019,1,28),
        end_at: Date.new(2019,4,15),
        second_payment: Date.new(2019,3,1),
        third_payment: Date.new(2019,4,1)
      },
      {
        id: 5,
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
