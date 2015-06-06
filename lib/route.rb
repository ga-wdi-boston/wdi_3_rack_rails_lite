class Route

  class << self
    # The Application name space is needed to contruct the Controller class
    # from the URL path.
    attr_accessor :app_namespace
  end

  # path - URL path
  attr_accessor :path, :controller_name, :action_name

  def initialize(path, controller_name, action_name)
    @path, @controller_name, @action_name = path, controller_name, action_name
  end

  # True if this route have a path like /songs/:id or album/:album_id/songs/:id ?
  # False if this route have a path like /latest_songs or album/older
  def segmented_path?
    !!path.index(':')
  end

  # TODO: cleanup, assumes we have validated that the path argument
  # is compatable with this this route's path component. We called, same?
  # earlier and it returned true.

  # Constructs a params hash given a segmented route and a URL path
  def get_params(path)
    values = []  # values from the URL path
    params = {}  # params hash to be built

    path_segments = path.split('/').select{|s| !s.empty?}
    # remove the segments that are NOT keys, don't have ':' in the
    # segment name.
    # values will ONLY be the set of non keys.
    values = path_segments - non_key_segments

    # For every key from this route's path
    keys.each_with_index do |key, i|
      # set the params hash key from one key segment for this route.
      # and the corresponding value from the URL path segment.
      params[key.gsub(':','').to_sym] = values[i]
    end
    params
  end

  # return true if the route path matches the URL path.
  # TODO: more testing and robust checking.
  def same?(path)
    values = []
    path_segments = path.split('/').select{|s| !s.empty?}

    result = true

    # if the route path and the given path have the same number of segments
    if segments.length == path_segments.length
      segments.each_with_index do |segment, index|
        # each non-key segment should be the same
        # non-key is a segment without a ':'
        if !segment.index(':')
          result = false  if result && !(segments[index] == path_segments[index])
        end
      end
    end
    result
  end

  # All this route's path segments without a ':'
  def non_key_segments
    segments - keys
  end

  # array of this route's path segments, segments are delimited by slash, '/'
  def segments
    path.split('/').select{|s| !s.empty?}
  end

  # key segments.
  # Ex: For a route with a path component like /songs/:id
  # :id is a key segment
  def keys
    @keys ||= path.split('/').map{ |s| s  if s.index(':') }.compact
  end

  def key_count
    path.indices.length
  end

  # Create a Controller instance and initialize.
  def controller(path)
    controller_name.constantize.new(controller_name, action_name, get_params(path))
  end

  # Run a Controller action
  def invoke_action(path)
    controller(path).send(action_name)
  end

  private

  # Construct a Controller classname
  def controller_name
    "#{self.class.app_namespace}::#{@controller_name}"
  end
end
