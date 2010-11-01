class DirectoriosController < ApplicationController
  def index
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  def new
      flash[:notice] = "New: ---- 1 --- "
    @directorio = Directorio.new
    #crea_directorio
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def crea_directorio
#    flash[:notice] = "Pru: --- 1 --- "
    #@directorio.delete;
    dame_directorios().each do | key, valor |
      #flash[:notice] = "Pru: Valor[#{valor}]"
#      puts("Pru: Valor[#{valor.keys}|#{valor.values}]")
      @directorio = Directorio.new(
        :padre => valor.keys[0],
        :directorio => valor.values[0]
      )
      @directorio.save;
      puts( "Valor:--#{valor.keys}-#{valor.values}--" )
    end
  end

  def dame_directorios
    path = PATH_RAIZ
    @carpetas = Hash.new{}

    resultado = 1
    Find.find( path ) do | x |
  #      puts( "---#{x}")
      y = x[path.length,999]
      if(  File.basename( x )[0] == '.' || x == path )
        next
      end
      if File.directory?( x )
        @carpetas[ y ] =   { File.basename( y ) => File.basename( File.dirname( "/"+y )[1,999] )}
#        puts( "\t#{@carpetas.size}-#{@carpetas[ y ]}")
        resultado += 1

        break if resultado > 100
      end
    end

  #    f = Tempfile.new('prefix', "#{Rails.root}/tmp")

    @carpetas.sort
=begin
    @carpetas.values.each do | valor |
      f.puts("\t<carpeta>\n")
      f.puts( "\t\t<Padre>#{valor.keys}</Padre>")
      f.puts( "\t\t<Descripcion>#{valor.values}</Descripcion>")
      f.puts("\t</carpeta>\n")
    end
=end
      return @carpetas
  end
end
