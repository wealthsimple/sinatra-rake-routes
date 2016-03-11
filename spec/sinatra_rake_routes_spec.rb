describe SinatraRakeRoutes do
  describe ".set_app_class" do
    context "with valid Sinatra::Base subclass" do
      it "sets app class" do
        expect(described_class.app_class).to be_nil

        described_class.set_app_class(SampleApp)
        expect(described_class.app_class).to eq(SampleApp)
      end
    end

    context "with an invalid class supplied" do
      it "raises an error" do
        expect { described_class.set_app_class(Array) }.
          to raise_error("Array does not appear to be a valid Sinatra Application")
      end
    end
  end

  describe "#to_s" do
    it "outputs routes" do
      described_class.set_app_class(SampleApp)
      expect(described_class.new.to_s).to eq(File.read('./spec/fixtures/sample_app_output.txt'))
    end
  end
end
