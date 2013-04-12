namespace :launch do
  task :send_emails => :environment do
    User.find_each(:conditions => "state = 'signed_up'", :batch_size => 1000) do |user|
      Resque.enqueue(Jobs::SendLaunchEmail, user.id)
    end
  end
end
