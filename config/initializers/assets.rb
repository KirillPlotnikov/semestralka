# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( account/account_index.css )
Rails.application.config.assets.precompile += %w( devise/login.css )
Rails.application.config.assets.precompile += %w( devise/sign_up.css )
Rails.application.config.assets.precompile += %w( devise/edit.css )
Rails.application.config.assets.precompile += %w( tasks/_form.css )
Rails.application.config.assets.precompile += %w( tasks/_form.js )
Rails.application.config.assets.precompile += %w( settings/index.css )
Rails.application.config.assets.precompile += %w( tasks/index.css )
Rails.application.config.assets.precompile += %w( tasks/show.css )
Rails.application.config.assets.precompile += %w( tasks/index.js )
Rails.application.config.assets.precompile += %w( categories/index.css )