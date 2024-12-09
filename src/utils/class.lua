local methods = {}

---New object.
---@param self class
---@return table
function methods.new(self)
	local obj = {}
	for k, v in pairs(self.public) do
		obj[k] = v
	end
  obj._is = methods.is
	return obj
end

---Create subclass.
---@param self class
---@param name string
---@param public table
---@param private table
---@return class
function methods.extend(self, name, public, private)
	self.sub[name] = setmetatable(methods.NewClass(public, private), self._mt)
	return self.sub[name]
end

---Check if object comes from a class.
---@param obj table
---@param class class
---@return boolean
function methods.is(obj, class)
	local obj_mt = getmetatable(obj)
	local class_mt = getmetatable(class._mt)
	if obj_mt == class_mt then
		return true
	else
		return false
	end
end

---Clone a class.
---@param class class
---@return class
function methods.clone(class)
	return methods.NewClass(class.public, class.private)
end

---Merge two classes.
---@param class1 class
---@param class2 class
---@return class
function methods.merge(class1, class2)
	local merged = {
		private = {
			class1 = class1.private,
			class2 = class2.private,
		},
		public = {
			class1 = class1.public,
			class2 = class2.public,
		},
	}
	local final = {
		public = {},
		private = {},
	}
	for _, class in pairs(merged.private) do
		for k, var in pairs(class) do
			final.private[k] = var
		end
	end
	for _, class in pairs(merged.public) do
		for k, var in pairs(class) do
			final.public[k] = var
		end
	end
	return methods.NewClass(final.public, final.private)
end

function methods.NewClass(public, private)
	---@class class
	---@field public public table Public vars
	---@field public private table Private vars
	---@field sub table Subclasses
	local cls = {
		public = {},
		private = {},
		sub = {},
	}
	cls._mt = { _index = cls }
	for k, v in pairs(public) do
		cls.public[k] = v
	end
	for k, v in pairs(private) do
		cls.private[k] = v
	end
  cls.new = methods.new
  cls.extend = methods.extend
  cls.clone = methods.clone
  cls.merge = methods.merge
	return cls
end

return methods.NewClass
