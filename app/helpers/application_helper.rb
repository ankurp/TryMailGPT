module ApplicationHelper
  def current_git_hash
    `git rev-parse HEAD`.strip
  end
end
