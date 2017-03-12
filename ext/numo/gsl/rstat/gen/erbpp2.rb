require "erb"

class ErbPpNode

  class ParamNotSetError < StandardError; end

  def initialize(parent, **opts, &block)
    @parent = parent
    @children = []
    @opts = opts
    @parent.add_child(self) if @parent
    instance_eval(&block) if block
  end

  attr_reader :children
  attr_accessor :parent

  def add_child(child)
    @children.push(child)
  end

  def set(**opts)
    @opts.merge!(opts)
  end

  def get(key, *args, &block)
    if respond_to?(key)
      return send(key, *args, &block)
    end
    if args.empty? && block.nil?
      v = @opts[key]
      return v if v
    end
    if @parent
      v = @parent.get(key, *args, &block)
      return v if v
    end
    nil
  end

  alias method_missing_alias method_missing

  def method_missing(_meth_id, *args, &block)
    if args.empty?
      v = get(_meth_id, *args, &block)
      return v if v
    end
    method_missing_alias(_meth_id, *args, &block)
  end

  def run
  end

  def result
  end
end


class ErbPP < ErbPpNode

  @@erb_dir = ""
  def self.set_erb_dir(dir)
    @@erb_dir = dir
  end

  @@erb_suffix = ""
  def self.set_erb_suffix(sufx)
    @@erb_suffix = sufx
  end

  def initialize(parent, erb_file, **opts, &block)
    @erb_path = File.join(@@erb_dir,erb_file)+@@erb_suffix
    super(parent, **opts, &block)
  end

  def load_erb
    safe_level = nil
    trim_mode = '%<>'
    @erb = ERB.new(File.read(@erb_path),safe_level,trim_mode)
    @erb.filename = @erb_path
  end

  def run
    load_erb unless @erb
    @erb.run(binding)
  end

  def result
    load_erb unless @erb
    @erb.result(binding)
  end
end


class DefLib < ErbPP
  def id_assign
    ids = []
    @children.each{|c| ids.concat(c.id_list)}
    ids.sort.uniq.map{|x| "id_#{x} = rb_intern(\"#{x}\");"}
  end
  def id_decl
    ids = []
    @children.each{|c| ids.concat(c.id_list)}
    ids.sort.uniq.map{|x| "ID id_#{x};"}
  end
  def def_class(erb_path, **opts, &block)
    DefClass.new(self, erb_path, **opts, &block)
  end
end

class DefClass < ErbPP
  def id_list
    @id_list ||= []
  end
  def add_id(id)
    id_list << id
  end
  def init_func
    "init_#{name}"
  end
  def call_init
    "#{init_func}(#{namespace_var});"
  end
  def method_code
    @children.map{|c| c.result}.join("\n")
  end
  def description
    @opts[:description]
  end
  def undef_alloc_func
    UndefAllocFunc.new(self)
  end
  def def_method(m, erb_path, **opts, &block)
    DefMethod.new(self, erb_path, name:m, **opts, &block)
  end
  def def_alias(from, to)
    DefAlias.new(self, from:from, to:to)
  end
end

class DefMethod < ErbPP
  def c_func
    s = (singleton) ? "_s" : ""
    "#{@parent.name}#{s}_#{name}"
  end

  def define
    s = (singleton) ? "_singleton" : ""
    "rb_define#{s}_method(#{class_var}, \"#{name}\", #{c_func}, #{n_arg});"
  end

  def description
    @opts[:description] || @opts[:desc]
  end

  def singleton
    @opts[:singleton]
  end
end

class DefAlias < ErbPpNode
  def define
    "rb_define_alias(#{class_var}, \"#{from}\", \"#{to}\");"
  end
end

class UndefAllocFunc < ErbPpNode
  def define
    "rb_undef_alloc_func(#{class_var});"
  end
end