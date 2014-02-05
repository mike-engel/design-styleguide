# TODO
# 1. CSS
# 2. Add README.md
# 3. Create html redirect, .htaccess redirect, or PHP redirect, to go to port 4567.
# 3. Release!

# require all the installed gems
require 'sinatra'
require 'haml'
require 'sinatra/flash'
require 'sinatra/partial'
require 'sinatra/reloader' if development?
require 'active_support/inflector'
require 'zipruby'

# misc functions for the app
helpers do
  def create_html(params)
    @html_src = erb params[:page]
  end
  def create_zip(erb_pages)
    zip_buf = Zip::Archive.open_buffer(Zip::CREATE) do |ar|
      ar.add_dir("#{@folder_name}-styleguide")
      ar.add_buffer("#{@folder_name}-styleguide/index.html", erb_pages[:idx])
      ar.add_buffer("#{@folder_name}-styleguide/resources.html", erb_pages[:res])
      ar.add_file("#{@folder_name}-styleguide/changelog.md", 'public/styleguide_template/changelog.md')
      ar.add_dir("#{@folder_name}-styleguide/css")
      ar.add_dir("#{@folder_name}-styleguide/img")
      ar.add_dir("#{@folder_name}-styleguide/js")
      ar.add_file("#{@folder_name}-styleguide/css/bootstrap.min.css", 'public/styleguide_template/css/bootstrap.min.css')
      ar.add_file("#{@folder_name}-styleguide/css/html5reset.css", 'public/styleguide_template/css/html5reset.css')
      ar.add_file("#{@folder_name}-styleguide/css/stylesheet.css", 'public/styleguide_template/css/stylesheet.css')
      ar.add_file("#{@folder_name}-styleguide/img/your-layout-image.png", 'public/styleguide_template/img/your-layout-image.png')
      ar.add_file("#{@folder_name}-styleguide/img/favicon.png", 'public/styleguide_template/img/favicon.png')
      ar.add_file("#{@folder_name}-styleguide/js/bootstrap.min.js", 'public/styleguide_template/js/bootstrap.min.js')
      ar.add_file("#{@folder_name}-styleguide/js/html5.js", 'public/styleguide_template/js/html5.js')
      ar.add_file("#{@folder_name}-styleguide/js/scripts-min.js", 'public/styleguide_template/js/scripts.js')
    end
    return zip_buf
  end
  def concatenate_section(section)
    @new_section_name = section.split(' ').join('-')
  end
end

get '/' do
  @this_year = Time.now.year
  haml :index
end

get '/*' do
  redirect '/'
end

post '/download' do
  @client = params[:client_name]
  @project = params[:project_name]
  @sections = params[:section]
  @client_name = @client.split(' ').join('-')
  @project_name = @project.split(' ').join('-')
  @folder_name = "#{@client_name}-#{@project_name}"
  @t = Time.now
  @timestamp = @t.strftime("%k:%M on %B %e, %Y")
  @index_src = create_html client: @client, sections: @sections, project: @project, page: :styleguide_index
  @devres_src = create_html client: @client, sections: @sections, project: @project, page: :styleguide_resources
  @zip_file = create_zip idx: @index_src, res: @devres_src, folder_name: @folder_name
  
  # send file
  content_type 'application/zip'
  attachment("#{@folder_name}-styleguide.zip")
  @zip_file
end