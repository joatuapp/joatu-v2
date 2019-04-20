require 'rails_helper'

describe TransferCaps do
  let(:form) do
    f = instance_double(CapsTransactionForm)
    allow(f).to receive(:model)
    f
  end

  let(:auth_context) { object_double(User.new) }

  subject do
    described_class.new(form, auth_context)
  end

  it "instantiates successfully with a caps transaction form and user" do
    expect{ subject }.to_not raise_error
  end

  describe "#prepare" do
    before :each do
      allow(subject).to receive(:authorize!)
      allow(subject).to receive(:validate!)
    end

    it "authorizes" do
      expect(subject).to receive(:authorize!)
      subject.prepare
    end

    it "validates" do
      expect(subject).to receive(:validate!)
      subject.prepare
    end
  end

  describe "#commit_within_transaction!" do
    let(:caps_change) { rand(5) }

    let(:source_caps) do
      d = double
      allow(d).to receive(:-)
      d
    end
    let(:source) do
      s = object_double(User.new)
      allow(s).to receive(:caps).and_return(source_caps)
      allow(s).to receive(:caps=)
      allow(s).to receive(:with_lock).and_yield
      allow(s).to receive(:save)
      s
    end

    let(:destination_caps) do
      d = double
      allow(d).to receive(:+)
      d
    end
    let(:destination) do
      d = object_double(User.new)
      allow(d).to receive(:caps).and_return(destination_caps)
      allow(d).to receive(:caps=)
      allow(d).to receive(:with_lock).and_yield
      allow(d).to receive(:save)
      d
    end

    before :each do
      allow(form).to receive(:source).and_return(source)
      allow(form).to receive(:destination).and_return(destination)
      allow(form).to receive(:caps).and_return(caps_change)
      allow(form).to receive(:save)
    end

    it "locks the form's 'source' record" do
      expect(source).to receive(:with_lock).and_yield
      subject.commit_within_transaction!
    end

    it "subtracts the form's caps amount from the source record's caps balance" do
      expect(source_caps).to receive(:-).with(caps_change)
      subject.commit_within_transaction!
    end

    it "locks the form's 'desitnation' record" do
      expect(destination).to receive(:with_lock).and_yield
      subject.commit_within_transaction!
    end

    it "adds the form's caps amount to the diestination record's caps balance" do
      expect(destination_caps).to receive(:+).with(caps_change)
      subject.commit_within_transaction!
    end

    it "saves the form" do
      expect(form).to receive(:save)
      subject.commit_within_transaction!
    end

    it "saves the form source record" do
      expect(source).to receive(:save)
      subject.commit_within_transaction!
    end

    it "saves the form destination record" do
      expect(destination).to receive(:save)
      subject.commit_within_transaction!
    end
  end
end
