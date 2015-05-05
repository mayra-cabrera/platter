require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Platter
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :skip_test_unit, type: :boolean, aliases: "-T", default: true,
      desc: "Skip Test::Unit files"

    class_option :skip_turbolinks, type: :boolean, default: true,
      desc: "Skips the turbolinks gem"

    class_option :api, type: :boolean, default: false,
      desc: "Adds API support gems"

    class_option :skip_bundle, type: :boolean, aliases: "-B", default: true,
      desc: "Don't run bundle install"

    def finish_template
      invoke :platter
      super
    end

    def platter
      invoke :custom_gemfile
      invoke :add_api_support
      invoke :setup_git
    end

    def custom_gemfile
      build :replace_gemfile

      bundle_command 'install'
    end

    def add_api_support
      build :add_api_support if options[:api]
    end

    def setup_git
      say "Initializing git"
      build :setup_git
    end

    protected

      def get_builder_class
        Platter::AppBuilder
      end
  end
end
