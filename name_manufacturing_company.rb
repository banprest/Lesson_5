module NameManufacturingCompany
  
  def name_company(name)
    self.name_manufacturing_company = name
  end

  def name_manufacturing
    self.name_manufacturing_company
  end

  protected
  attr_accessor :name_manufacturing_company
end