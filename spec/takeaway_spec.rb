require 'takeaway'

describe Takeaway do

  let(:menu_class) { double :menu_class, new: menu }
  let(:menu) { double :menu, print_menu: nil, included?: false, price_checker: 3.50 }
  subject {described_class.new(menu_class.new, sms_class)}
  let(:sms_class) { double :sms_class, new: sms }
  let(:sms) { double :sms, send_text: nil }

  context '#print_menu' do
    it 'will allow user to view the menu' do
      subject.get_menu
      expect(menu).to have_received(:print_menu)
    end
  end

  context '#select_food with error' do
    it 'should raise an error if food is not on menu' do
      expect{subject.select_food("pancakes", 5)}.to raise_error(/not on the menu/)
    end
  end

  context '#checkout and #select_food without error' do
    before (:each) do
      allow(menu).to receive(:included?) {true}
    end

    it 'should give back the total' do
      subject.select_food("chicken", 1)
      expect(subject.checkout).to eq 3.50
    end

    it 'should add the food to the basket' do
      subject.select_food("fish", 2)
      expect(subject.basket).to eq "fish"=>2
    end

  end

  context '#confirmation_text' do
    it 'should receive the send_text method' do
      subject.confirmation_text
      expect(sms).to have_received(:send_text)
    end
  end

end
