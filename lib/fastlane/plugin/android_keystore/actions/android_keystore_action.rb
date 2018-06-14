module Fastlane
  module Actions
    module SharedValues
      ANDROID_KEYSTORE_KEYSTORE_PATH = :ANDROID_KEYSTORE_KEYSTORE_PATH
      ANDROID_KEYSTORE_RELEASE_SIGNING_PATH = :ANDROID_KEYSTORE_RELEASE_SIGNING_PATH
    end

    class AndroidKeystoreAction < Action
      def self.run(params)
      
        output_directory = params[:output_directory]
        
        keystore_name = params[:keystore_name]
        alias_name = params[:alias_name]
        password = params[:password]
        key_password = params[:key_password]
        full_name = params[:full_name]
        org = params[:org]
        org_unit = params[:org_unit]
        city_locality = params[:city_locality]
        state_province = params[:state_province]
        country = params[:country]
        
        generate_cordova_release_signing = params[:generate_cordova_release_signing]
        
        # Validating output doesn't exist yet for our android signing info
        if File.directory?(output_directory)
          UI.message "`android_keystore` signing directory already exists - #{output_directory}"
        else
          Dir.mkdir output_directory
        end
        
        keystore_path = File.join(output_directory, keystore_name)
        Actions.lane_context[SharedValues::ANDROID_KEYSTORE_KEYSTORE_PATH] = keystore_path
        
        # Create keystore with command
        unless File.file?(keystore_path)
          keytool_parts = [
            "keytool -genkey -v",
            "-keystore '#{keystore_path}'",
            "-alias #{alias_name}",
            "-keyalg RSA -keysize 2048 -validity 10000",
            "-storepass #{password} ",
            "-keypass #{key_password}",
            "-dname \"CN=#{full_name}, OU=#{org_unit}, O=#{org}, L=#{city_locality}, S=#{state_province}, C=#{country}\"",
          ]
          sh keytool_parts.join(" ")
        else
          UI.message "Keystore file already exists - #{keystore_path}"
        end
        
        # Create release-signing.properties for automatic signing with Ionic
        if generate_cordova_release_signing
          
          release_signing_path = File.join(output_directory, "release-signing.properties")
          Actions.lane_context[SharedValues::ANDROID_KEYSTORE_RELEASE_SIGNING_PATH] = release_signing_path
          
          unless File.file?(release_signing_path)
            out_file = File.new(release_signing_path, "w")
            out_file.puts("storeFile=#{keystore_name}")
            out_file.puts("storePassword=#{password}")
            out_file.puts("keyAlias=#{alias_name}")
            out_file.puts("keyPassword=#{key_password}")
            out_file.close
          else
            UI.message "release-signing.properties file already exists - #{release_signing_path}"
          end
        end
        
        return output_directory
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Generate an Android keystore file"
      end

      def self.details
        "Generate an Android keystore file"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :output_directory,
                                       env_name: "ANDROID_KEYSTORE_OUTPUT_DIRECTORY",
                                       description: "",
                                       is_string: true,
                                       optional: false,
                                       default_value: File.absolute_path(File.join(Dir.pwd, ".android_signing"))),
          FastlaneCore::ConfigItem.new(key: :keystore_name,
                                       env_name: "ANDROID_KEYSTORE_KEYSTORE_NAME",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :alias_name,
                                       env_name: "ANDROID_KEYSTORE_ALIAS_NAME",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "ANDROID_KEYSTORE_PASSWORD",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :key_password,
                                       env_name: "ANDROID_KEYSTORE_KEY_PASSWORD",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :full_name,
                                       env_name: "ANDROID_KEYSTORE_FULL_NAME",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :org,
                                       env_name: "ANDROID_KEYSTORE_ORG",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :org_unit,
                                       env_name: "ANDROID_KEYSTORE_ORG_UNIT",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :city_locality,
                                       env_name: "ANDROID_KEYSTORE_CITY_LOCALITY",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :state_province,
                                       env_name: "ANDROID_KEYSTORE_STATE_PROVINCE",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :country,
                                       env_name: "ANDROID_KEYSTORE_COUNTRY",
                                       description: "",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :generate_cordova_release_signing,
                                       env_name: "ANDROID_KEYSTORE_GENERATE_CORDOVA_RELEASE_SIGNING",
                                       description: "",
                                       is_string: false,
                                       optional: true)
        ]
      end

      def self.output
        [
          ['ANDROID_KEYSTORE_KEYSTORE_PATH', 'Path to keystore'],
          ['ANDROID_KEYSTORE_RELEASE_SIGNING_PATH', 'Path to release-signing.properties']
        ]
      end

      def self.return_value
        "Path to keystore"
      end

      def self.authors
        ["joshdholtz"]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
