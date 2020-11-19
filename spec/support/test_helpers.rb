module TestHelpers
  def define_helper_methods(view, methods)
    methods.each do |name, value|
      view.define_singleton_method(name){ value }
    end
  end
end
