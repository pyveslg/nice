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
      },
      {
        id: 3,
        title: "1-on-1 FrenchUp Program",
        code: "FUP"
      }
    ]

    FBP = [
      {
        id: 1,
        title: "FrenchBooster Summer Intensive Programme - July 2019",
        code: "FBPI",
        start_from: Date.new(2019,7,1),
        end_at: Date.new(2019,7,11),
        second_payment: Date.new(2019,7,1),
        third_payment: Date.new(2019,7,1)
      },
      {
        id: 2,
        title: "FrenchBooster Programme - Mondays - Winter 2020",
        code: "FBP",
        start_from: Date.new(2020,1,27),
        end_at: Date.new(2020,4,6),
        second_payment: Date.new(2020,2,24),
        third_payment: Date.new(2020,3,24)
      },
      {
        id: 3,
        title: "FrenchBooster Programme - Saturdays - Winter 2020",
        code: "FBP",
        start_from: Date.new(2020,1,25),
        end_at: Date.new(2020,4,4),
        second_payment: Date.new(2020,2,24),
        third_payment: Date.new(2020,3,24)
      }
    ]
  end

end
