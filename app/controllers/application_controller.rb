class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper

  module CurrentUser
    def self.included(base)
      base.send :helper_method, :current_user
    end
  end
end
