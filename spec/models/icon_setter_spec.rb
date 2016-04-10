require 'spec_helper'

describe IconSetter do
  let(:police_alert) { FactoryGirl.create(:police_alert)}

  context "#call" do
    it 'selects correct image when matching word is at the beginning of the event string' do
      police_alert.update_attributes(event_clearance_description: "DISTURBANCE, OTHER")
      icon = IconSetter.call(police_alert.event_clearance_description)
      expect(icon).to eq('police.png')
    end

    it 'selects correct image when matching word is at the end of the event string' do
      police_alert.update_attributes(event_clearance_description: "DRIVING WHILE UNDER INFLUENCE (DUI)")
      icon = IconSetter.call(police_alert.event_clearance_description)
      expect(icon).to eq('caraccident.png')
    end

    it 'selects police.png when there is no matching image in hash' do
      police_alert.update_attributes(event_clearance_description: "LEWD CONDUCT")
      icon = IconSetter.call(police_alert.event_clearance_description)
      expect(icon).to eq('police.png')
    end

    it 'selects suspicious_person.png if SUSPICIOUS PERSON in event string' do
      police_alert.update_attributes(event_clearance_description: "SUSPICIOUS PERSON")
      icon = IconSetter.call(police_alert.event_clearance_description)
      expect(icon).to eq('suspicious_person.png')
    end

    it 'selects suspicious_person.png if SUSPICIOUS VEHICLE in event string' do
      police_alert.update_attributes(event_clearance_description: "SUSPICIOUS VEHICLE")
      icon = IconSetter.call(police_alert.event_clearance_description)
      expect(icon).to eq('suspicious_vehicle.png')
    end
  end
end