
module FormHelpers
  def submit_form
    find('input[name="submit"]').click
  end
end
