class StaticPageController < ApplicationController

before_filter :signed_in_user, only: [ :create, :destroy]
before_filter :correct_user,   only: :destroy



 def view
   #@microposts = Micropost.all
	 @microposts = Micropost.paginate(page: params[:page])
    respond_to do |format|
      format.html #view.html.erb
      format.json { render json: @microposts }
    end
  end


  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = current_user.microposts.build(params[:micropost])

    respond_to do |format|
      if @micropost.save
		flash[:success] = "Micropost created!"
        format.html { redirect_to root_path }
        format.json { render json: @micropost, status: :created, location: @micropost }
      else
	  flash[:error] = "Micropost cannot be blank!"
		@feed_items = []
		format.html { redirect_to root_path }
        #format.html { render action: "static_pages/about" }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy

    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.json { head :ok }
    end
  end

  private

def correct_user
  @micropost = current_user.microposts.find(params[:id])
rescue
  redirect_to root_path
end

end
