module Jobs
  class SubscribeUserToMailChimpList
    @queue = :subscribe_user_to_mail_chimp_list
    def self.perform(user_id)

    end
  end
end
