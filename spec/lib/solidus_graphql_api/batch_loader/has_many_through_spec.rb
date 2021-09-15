# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::BatchLoader::HasManyThrough do
  subject(:loader) do
    described_class.new(
      physician,
      Physician.reflect_on_association(:patients)
    )
  end

  with_model :Physician, scope: :all do
    model do
      has_many :appointments
      has_many :patients, through: :appointments
    end
  end

  with_model :Appointment, scope: :all do
    table do |t|
      t.belongs_to :physician, index: { name: :appointment_on_physician }
      t.belongs_to :patient
    end

    model do
      belongs_to :physician
      belongs_to :patient
    end
  end

  with_model :Patient, scope: :all do
    model do
      has_many :appointments
    end
  end

  let!(:physician) { Physician.create! }

  before do
    physician.appointments.create!(patient: Patient.create!)
  end

  it 'loads the association properly' do
    expect(loader.load.sync).to eq(physician.patients)
  end

  it "doesn't duplicate result when another record loaded in the batch is also associated to the same target record" do
    second_physician = Physician.create!
    Appointment.create!(patient: physician.patients.first, physician: second_physician)

    described_class.new(
      second_physician,
      Physician.reflect_on_association(:patients)
    ).load

    expect(loader.load.sync.length).to be(1)
  end
end
