class SettingsController < ApplicationController
	  before_action :set_setting, only: [:show, :update, :destroy]

end
