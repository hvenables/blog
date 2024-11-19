module ApplicationHelper
  include Pagy::Frontend

  def og_keys
    %i[title description url image type]
  end
end
