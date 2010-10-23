class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml

# machines_controller.rb
  def index
    @items = Item.paginate :page => params[:page], :order => 'updated_at ASC', :per_page=>25
    @texto_busqueda = "pepe"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end

  def borratodo
    vacia_encontrados
    redirect_to items_path
  end

  def vacia_encontrados
    Item.all.each do | x |
      x.destroy
    end
  end
  
  def importa
path = PATH_RAIZ
    busqueda = params[ :busqueda ]
    Debug( busqueda )

    flash[:notice] = "Param:busqueda [#{ params(:busqueda) }]"

#    flash[:notice] = "Vaciando resultado antiguos ....]"
    vacia_encontrados

#    flash[:notice] = "Buscando nuevos resultados ....]"

    resultado = 1
    Find.find( path ) do | x |
      if File.file?( x ) and x[ busqueda ]
        Item.create(
          :tipo => resultado,
          :titulo => File.basename( x ),
          :descripcion => x,
          :path => File.dirname( x ).slice(PATH_RAIZ.size+1,999 ) ,
          :fichero => x,
          :tamano => File.size(x)
        )
        resultado += 1
        debug( resultado )
        break if resultado == 10
      end
    end

    flash[:notice] = "Terminada la búsqueda ....]"

    redirect_to items_path
  end
end
