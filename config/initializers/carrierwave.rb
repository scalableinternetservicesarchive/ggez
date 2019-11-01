if Rails.env.production?
    CarrierWave.configure do |config|
      config.fog_credentials = {
        provider: 'AWS',                        # required
        use_iam_profile: true,
        region: 'us-west-2'
      }
      config.fog_directory  = 'ggez-resumes'
    end
end
