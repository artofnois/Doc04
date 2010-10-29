class PruController < ApplicationController
  def pru
    dame_directorios

#    flash[:notice] = "Terminada la búsqueda[. Econtrados #{resultado} documentos."

    respond_to do |format|
      format.html # show.html.erb
    end
    #redirect_to "/pru/pru"
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
        @carpetas[ y ] =   {File.basename( y ) => File.basename( File.dirname( "/"+y )[1,999] )}
  #      puts( "\t#{@carpetas.size}-#{@carpetas[ y ]}")
        resultado += 1

        break if resultado > 100
      end
    end

#    f = Tempfile.new('prefix', "#{Rails.root}/tmp")

    File.open( "/data/ds/temas.xml", File::CREAT|File::TRUNC|File::RDWR, 0644 ) do  | f |
      f.puts("<List>\n")
      @carpetas.sort
        @carpetas.values.each do | valor |
#       puts("<#{valor.keys}><#{valor.values}>")
#       puts("#{f[0]}|#{f[1]}")
        f.puts("\t<carpeta>\n")
        f.puts( "\t\t<Padre>#{valor.keys}</Padre>")
        f.puts( "\t\t<Descripcion>#{valor.values}</Descripcion>")
        f.puts("\t</carpeta>\n")
      end
    end
  end
 end
