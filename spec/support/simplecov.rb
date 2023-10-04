require 'simplecov'

# Путь, где будут сохраняться результаты покрытия
SimpleCov.coverage_dir 'coverage'

SimpleCov.start 'rails' do
  # Дополнительные настройки SimpleCov, если необходимо

  # Игнорировать директории или файлы, если необходимо
  # add_filter '/path/to/ignored/directory'
  # add_filter '/path/to/ignored/file.rb'
end
