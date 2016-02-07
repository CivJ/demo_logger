require 'English'

module CleanConfig
  describe Configuration do
    it 'should load correct config when required in a different gem' do
      Dir.chdir(File.join('spec', 'e2e', 'core')) do
        Bundler.with_clean_env do
          `bundle install && bundle exec rake spec:unit`
        end
      end
      expect($CHILD_STATUS.success?).to be true
    end
  end
end
