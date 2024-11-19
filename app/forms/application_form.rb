class ApplicationForm
  include ActiveModel::API
  include ActiveModel::Attributes

  define_callbacks :save, only: :after
  define_callbacks :commit, only: :after

  class << self
    def after_save(...)
      set_callback(:save, :after, ...)
    end

    def after_commit(...)
      set_callback(:commit, :after, ...)
    end

    def form_attribute(name, cast_type = nil, **options)
      attr_name = "form_#{name}"
      attribute attr_name, cast_type, **options

      define_method("#{name}=") do |value|
        public_send("#{attr_name}=", value)
      end

      define_method(name) do
        public_send(attr_name) || record.public_send(name)
      end
    end
  end

  def save!
    return false unless valid?

    with_transaction do
      AfterCommitEverywhere.after_commit { run_callbacks(:commit) }
      run_callbacks(:save) { submit! }
    end
  end

  def save
    save!
  rescue ActiveRecord::RecordInvalid
    false
  end

  def model_name
    ActiveModel::Name.new(
      nil, nil, self.class.name.sub(/Form$/, "")
    )
  end

  def error_messages
    errors.full_messages.to_sentence
  end

  private

  def with_transaction(&)
    ApplicationRecord.transaction(&)
  end

  def submit!; end
end
