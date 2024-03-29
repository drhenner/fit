namespace :launch do
  task :send_emails => :environment do
    User.where(:users => {:country_id => [Country::USA_ID, Country::CANADA_ID]}).
        where("users.state = 'signed_up'").
        find_each do |user|
      Resque.enqueue(Jobs::SendLaunchEmail, user.id)
    end
  end
end
