class BaseObjectsController < ApplicationController

  def index
    @objects = BaseObject.all
  end


end