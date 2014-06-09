class StaticPagesController < ApplicationController
  layout :layout

  def privacy
  end

  def layout
    'blank'
  end
end
