require 'sms'

describe Text do

let(:text_class_double) { double :twilio_class_double, new: twilio}
subject {described_class.new(twilio_class_double)}
let(:twilio) { double :twilio, :messages => messages }
lets(:messages) { double :messages, create: nil }


end
