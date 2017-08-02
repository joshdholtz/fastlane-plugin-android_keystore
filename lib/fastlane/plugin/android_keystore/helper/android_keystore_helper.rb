module Fastlane
  module Helper
    class AndroidKeystoreHelper
      # class methods that you define here become available in your action
      # as `Helper::AndroidKeystoreHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the android_keystore plugin helper!")
      end
    end
  end
end
