shared_examples "has attribute" do |attr|
  it "getter: #{attr}" do
    expect(subject).to respond_to attr
  end

  it "setter: #{attr}=" do
    expect(subject).to respond_to :"#{attr}="
  end
end
