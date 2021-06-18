class Api::V1::FactsController < ApplicationController
  before_action :set_fact, only: [:show, :update, :destroy]

  # GET /users/:user_id/facts
  def index
    @user = User.find(params[:user_id])
    render json: @user.facts # note that because the facts route is nested inside users
                             # we return only the facts belonging to that user
  end

  # GET /users/:user_id/facts/:id
  def show
    @user = User.find(params[:id])
    render json: @users.facts
  end

  # POST /users/:user_id/facts
  def create
     @user = User.find(params[:user_id])
    @fact = @user.facts.new(fact_params)
    if @fact.save
      render json: @fact, status: 201
    else
      render json: { error:
"The fact entry could not be created. #{@fact.errors.full_messages.to_sentence}"},
      status: 400
    end
  end

  # PUT /users/:user_id/facts/:id
  def update
     @user = User.find(params[:user_id])
    if @fact.update(fact_params)
      render json: { message: 'Users fact updated'}, status: 202
    else
      render json: { error:
        "Unable to update users fact: #{@facts.errors.full_messages.to_sentence}"},
        status: 400
      end
  end

  # DELETE /users/:user_id/facts/:id
  def destroy
     @user = User.find(params[:user_id])
     if @fact.destroy(fact_params)
     render json: { message: 'Fact record successfully deleted.'}, status: 200
   else
     render json: {error: "Fact not deleted: #{@facts.errors.full_messages.to_sentence}"}, status: 400
   end

  end

  private

  def fact_params
    params.require(:fact).permit(:fact_text, :likes)
  end

  def set_fact
    @fact = Fact.find(params[:id])
  end

end