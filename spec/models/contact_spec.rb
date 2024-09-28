require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:valid_contact) { Contact.new(name: "John Doe", email: "john@example.com", phone_number: "+1234567890") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(valid_contact).to be_valid
    end

    it "is invalid without a name" do
      valid_contact.name = nil
      expect(valid_contact).not_to be_valid
      expect(valid_contact.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an email" do
      valid_contact.email = nil
      expect(valid_contact).not_to be_valid
      expect(valid_contact.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a duplicate email" do
      Contact.create(name: "Jane Doe", email: "john@example.com", phone_number: "+1987654321")
      expect(valid_contact).not_to be_valid
      expect(valid_contact.errors[:email]).to include("has already been taken")
    end

    it "is invalid with an incorrect email format" do
      valid_contact.email = "invalid_email"
      expect(valid_contact).not_to be_valid
      expect(valid_contact.errors[:email]).to include("invalid email format")
    end

    it "is invalid without a phone number" do
      valid_contact.phone_number = nil
      expect(valid_contact).not_to be_valid
      expect(valid_contact.errors[:phone_number]).to include("can't be blank")
    end

    it "is invalid with a duplicate phone number" do
      Contact.create(name: "Jane Doe", email: "jane@example.com", phone_number: "+1234567890")
      expect(valid_contact).not_to be_valid
      expect(valid_contact.errors[:phone_number]).to include("has already been taken")
    end

    it "is invalid with an incorrect phone number format" do
      valid_contact.phone_number = "12345"
      expect(valid_contact).not_to be_valid
      expect(valid_contact.errors[:phone_number]).to include("invalid phone number format")
    end
  end
end
