class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def new
    if params[:food_id].present?
      @reviewable_type = 'Food'
      @reviewable_id = params[:food_id]
    elsif params[:restaurant_id].present?
      @reviewable_type = 'Restaurant'
      @reviewable_id = params[:restaurant_id]
    end

    @review = Review.new
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    
  end

  # GET /reviews/1/edit
  def edit    
    @voucher_opt = Voucher.all
  end

  # POST /reviews
  # POST /reviews.json
  def create

    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to store_index_path, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: store_index_path }
      else        
        # format.html { redirect_to "/#{@review.reviewable_type.underscore}s/#{@review.reviewable_id}/reviews/new" }
        format.html { redirect_back fallback_location: "/#{@review.reviewable_type.underscore}s/#{@review.reviewable_id}/reviews/new" }
        # format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }

        @reviews = Review.review(:name)
        ActionCable.server.broadcast 'reviews', html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def check_cart
      if @cart.line_items.empty?
        redirect_to store_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:name, :title, :description, :reviewable_id, :reviewable_type)
    end
end
