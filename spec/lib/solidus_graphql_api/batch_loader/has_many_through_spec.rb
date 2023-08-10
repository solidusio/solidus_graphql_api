# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::BatchLoader::HasManyThrough, skip: (ENV["DB"] == "mysql") do
  include Helpers::ActiveRecord

  subject(:loader) do
    described_class.new(
      physician,
      Physician.reflect_on_association(:patients)
    )
  end

  before do
    run_migrations do
      create_table :physicians, force: true
      create_table :patients, force: true
      create_table :appointments, force: true do |t|
        t.belongs_to :physician
        t.belongs_to :patient
      end
    end
    create_model("Physician") do
      has_many :appointments
      has_many :patients, through: :appointments
    end
    create_model("Patient") do
      has_many :appointments
    end
    create_model("Appointment") do
      belongs_to :physician
      belongs_to :patient
    end

    physician.appointments.create!(patient: Patient.create!)
  end

  after do
    run_migrations do
      drop_table :physicians
      drop_table :patients
      drop_table :appointments
    end
  end

  let!(:physician) { Physician.create! }

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
