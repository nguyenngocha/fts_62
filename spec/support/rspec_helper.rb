module RspecHelper
  def log_in user
    visit admin_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def log_out
    visit admins_root_path
    click_link "Log out"
  end
end
