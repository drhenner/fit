namespace :launch do
  task :send_emails => :environment do
    User.last(3).each do |user|
      if !user.admin? and user.active?
        Resque.enqueue(Jobs::SendLaunchEmail, user.id)
      end
    end
  end
end
