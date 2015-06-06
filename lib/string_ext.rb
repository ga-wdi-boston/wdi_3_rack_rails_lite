class String
  def indices(character)
    all_indices = []
    split(/\.*/).each_with_index{ |char, i| all_indices << i if char == character }
    all_indices
  end

  def keys
    indices
  end
end
