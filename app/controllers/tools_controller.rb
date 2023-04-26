class ToolsController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def index
    @tools = Tool.all.includes(:user).order(created_at: :desc)
  end

  def new
    @tool = Tool.new
    @tool_units = @tool.tool_units.build
  end

  def create
    @tool = current_user.tools.build(tool_params)
    if @tool.save
      redirect_to tool_path(@tool), success: t('.success')
    else
      flash.now['danger'] = t('.fail')
      render :new
    end
  end

  def show
    @tool = Tool.find(params[:id])
  end

  private

  def tool_params
    params.require(:tool).permit(:store_name, :total_unit, tool_units_attributes: [:id, :number, :medal, :_destroy])
  end
end
