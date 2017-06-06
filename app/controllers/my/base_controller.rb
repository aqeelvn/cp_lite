class My::BaseController < ApplicationController
  before_action :require_login, except: %i(show)
end
