require 'super_grouper'

describe SuperGrouper do

  describe '#group' do
    it 'raises an ArgumentError when there are no extractors' do
      expect do
        SuperGrouper.group([1, 2, 3], [])
      end.to raise_exception(ArgumentError)
    end

    # TODO: Yeah... I'll break this into separate tests later...
    it 'works' do
      locations = [
        {country: "US", state: "Ohio",     city: "Dayton"},
        {country: "US", state: "Ohio",     city: "Cincinnati"},
        {country: "CA", state: "Manitoba", city: "Winnipeg"},
        {country: "US", state: "Virginia", city: "Falls Church"},
      ]

      output = SuperGrouper.group(locations, [->(hash) { hash.size}, :country, :state])

      expect(output).to eq({
        3 => {
          "US" => {
            "Ohio" => [
              {country: "US", state: "Ohio",     city: "Dayton"},
              {country: "US", state: "Ohio",     city: "Cincinnati"},
            ],
            "Virginia" => [
              {country: "US", state: "Virginia", city: "Falls Church"},
            ]
          },
          "CA" => {
            "Manitoba" => [
              {country: "CA", state: "Manitoba", city: "Winnipeg"},
            ]
          }
        }
      })
    end
  end

end
