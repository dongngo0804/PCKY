class TopController < ApplicationController
  def index
    @rules = Rule.all
  end
end
