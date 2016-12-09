class Status < ApplicationRecord
  enum status: [:delimiter, :number, :identify]
end
