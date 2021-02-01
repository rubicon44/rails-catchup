class NamespaceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "#{value}はすでに使用されています") if value =~ PathRegex.root_namespace_path_regex
  end
end
