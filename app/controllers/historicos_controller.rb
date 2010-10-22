class HistoricosController < ApplicationController
  helper_method :sort_column, :sort_direction

  # GET /historicos
  # GET /historicos.xml
  def index
    @historicos = Historico.order(sort_column + " " + sort_direction)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @historicos }
    end
  end

  # GET /historicos/1
  # GET /historicos/1.xml
  def show
    @historico = Historico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  # GET /historicos/new
  # GET /historicos/new.xml
  def new
    @historico = Historico.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  # GET /historicos/1/edit
  def edit
    @historico = Historico.find(params[:id])
  end

  # POST /historicos
  # POST /historicos.xml
  def create
    @historico = Historico.new(params[:historico])

    respond_to do |format|
      if @historico.save
        format.html { redirect_to(@historico, :notice => 'Historico se ha creado.') }
        format.xml  { render :xml => @historico, :status => :created, :location => @historico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /historicos/1
  # PUT /historicos/1.xml
  def update
    @historico = Historico.find(params[:id])

    respond_to do |format|
      if @historico.update_attributes(params[:historico])
        format.html { redirect_to(@historico, :notice => 'Historico actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /historicos/1
  # DELETE /historicos/1.xml
  def destroy
    @historico = Historico.find(params[:id])
    @historico.destroy

    respond_to do |format|
      format.html { redirect_to(historicos_url) }
      format.xml  { head :ok }
    end
  end

private
  def sort_column
    Historico.column_names.include?(params[:sort]) ? params[:sort] : "contenido"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
