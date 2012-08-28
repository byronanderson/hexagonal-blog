class SettingsController < ApplicationController
  def edit
    @settings = Settings.fetch
  end

  def update
    @settings = Settings.fetch
    @settings.update_attributes(params[:settings])
    flash[:success] = "Settings saved"
    redirect_to edit_settings_path
  end
end
