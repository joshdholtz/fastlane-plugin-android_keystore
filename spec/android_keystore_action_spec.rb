describe Fastlane::Actions::AndroidKeystoreAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The android_keystore plugin is working!")

      Fastlane::Actions::AndroidKeystoreAction.run(nil)
    end
  end
end
