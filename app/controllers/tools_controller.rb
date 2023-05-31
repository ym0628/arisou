class ToolsController < ApplicationController
  def index
    @tools = current_user.tools.includes(:user).order(created_at: :desc)
  end

  def show
    @tool = current_user.tools.find(params[:id])
    # モデルで@toolを呼び出すためにローカル変数へ代入
    tool = @tool
    # 台番号に重複があった場合に注意喚起のメッセージを表示
    flash.now[:warning] = "台番号 #{tool.duplication?(tool)} が重複しています。確認してください。" if tool.duplication?(tool)
  end

  def new
    @tool = Tool.new
    @tool_units = @tool.tool_units.build
  end

  def edit
    @tool = current_user.tools.find(params[:id])
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

  def update
    @tool = current_user.tools.find(params[:id])
    if @tool.update(tool_params)
      redirect_to @tool, success: t('defaults.message.updated')
    else
      flash.now['danger'] = t('defaults.message.not_updated')
      render :edit
    end
  end

  def destroy
    @tool = current_user.tools.find(params[:id])
    @tool.destroy!
    redirect_to tools_path, success: t('defaults.message.deleted')
  end

  private

  def tool_params
    params.require(:tool).permit(:store_name, :total_unit, tool_units_attributes: %i[id number medal _destroy])
  end
end
