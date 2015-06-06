class Route
  class << self
    attr_accessor :app_namespace
  end

  attr_accessor :path, :controller_name, :action_name

  def initialize(path, controller_name, action_name)
    @path, @controller_name, @action_name = path, controller_name, action_name
  end

  def controller
    controller_name.constantize.new
  end

  def invoke_action
    controller.send(action_name)
  end

  private

  def controller_name
    "#{self.class.app_namespace}::#{@controller_name}"
  end
end
