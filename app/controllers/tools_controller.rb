class ToolsController < ApplicationController
  def index
    @tools = current_user.tools.includes(:user).order(created_at: :desc)
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
    @tool = current_user.tools.find(params[:id])
    #総設置台数から各末尾の分母を割り出す
    @each_denominator = @tool.total_unit.to_f / 10.round(1)
    #配列に作り直す
    @tool_units_array = @tool.tool_units.pluck(:number, :medal)
    #差枚数がプラスの要素だけを取り出した配列を作り、さらに差枚プラスの台番だけを残した配列に直す
    @win_unit_number_array = @tool_units_array.select { |key, value| value > 0 }.pluck(0)
    #各末尾(0~9)の台数をカウント
    @win_unit_number_ones_place_array_count = @win_unit_number_array.map { |n| n.digits[0] }.group_by{ |a| a }.map{ |key,value| [key, value.count] }.to_h
    #末尾ゾロ目かつ差枚プラス台の台数をカウント
    @win_same_unit_number_array_count = @win_unit_number_array.select { |n| n > 10 }.map { |n| n.digits[0..1] }.select {|a, b| a - b == 0 }.count
    #各末尾ごとの勝率
    @win_rate_0 = ((@win_unit_number_ones_place_array_count[0].to_i / @each_denominator) * 100).round(1)
    @win_rate_1 = ((@win_unit_number_ones_place_array_count[1].to_i / @each_denominator) * 100).round(1)
    @win_rate_2 = ((@win_unit_number_ones_place_array_count[2].to_i / @each_denominator) * 100).round(1)
    @win_rate_3 = ((@win_unit_number_ones_place_array_count[3].to_i / @each_denominator) * 100).round(1)
    @win_rate_4 = ((@win_unit_number_ones_place_array_count[4].to_i / @each_denominator) * 100).round(1)
    @win_rate_5 = ((@win_unit_number_ones_place_array_count[5].to_i / @each_denominator) * 100).round(1)
    @win_rate_6 = ((@win_unit_number_ones_place_array_count[6].to_i / @each_denominator) * 100).round(1)
    @win_rate_7 = ((@win_unit_number_ones_place_array_count[7].to_i / @each_denominator) * 100).round(1)
    @win_rate_8 = ((@win_unit_number_ones_place_array_count[8].to_i / @each_denominator) * 100).round(1)
    @win_rate_9 = ((@win_unit_number_ones_place_array_count[9].to_i / @each_denominator) * 100).round(1)
    @win_rate_same_number = ((@win_same_unit_number_array_count.to_i / @each_denominator) * 100).round(1)

    #各末尾(0~9まで)ごとの総差枚と平均差枚
    @ones_place_group = @tool_units_array.group_by{|key, value| key.digits[0] }.sort.to_h

    if @ones_place_group[0].present?
      @sum_0 = 0
      @ones_place_group[0].each do |number, medal|
        @sum_0 += medal
      end
      @average_0 = (@sum_0 / @each_denominator).round(1)
    end

    if @ones_place_group[1].present?
      @sum_1 = 0
      @ones_place_group[1].each do |number, medal|
        @sum_1 += medal
      end
      @average_1 = (@sum_1 / @each_denominator).round(1)
    end

    if @ones_place_group[2].present?
      @sum_2 = 0
      @ones_place_group[2].each do |number, medal|
        @sum_2 += medal
      end
      @average_2 = (@sum_2 / @each_denominator).round(1)
    end

    if @ones_place_group[3].present?
      @sum_3 = 0
      @ones_place_group[3].each do |number, medal|
        @sum_3 += medal
      end
      @average_3 = (@sum_3 / @each_denominator).round(1)
    end

    if @ones_place_group[4].present?
      @sum_4 = 0
      @ones_place_group[4].each do |number, medal|
        @sum_4 += medal
      end
      @average_4 = (@sum_4 / @each_denominator).round(1)
    end

    if @ones_place_group[5].present?
      @sum_5 = 0
      @ones_place_group[5].each do |number, medal|
        @sum_5 += medal
      end
      @average_5 = (@sum_5 / @each_denominator).round(1)
    end

    if @ones_place_group[6].present?
      @sum_6 = 0
      @ones_place_group[6].each do |number, medal|
        @sum_6 += medal
      end
      @average_6 = (@sum_6 / @each_denominator).round(1)
    end

    if @ones_place_group[7].present?
      @sum_7 = 0
      @ones_place_group[7].each do |number, medal|
        @sum_7 += medal
      end
      @average_7 = (@sum_7 / @each_denominator).round(1)
    end

    if @ones_place_group[8].present?
      @sum_8 = 0
      @ones_place_group[8].each do |number, medal|
        @sum_8 += medal
      end
      @average_8 = (@sum_8 / @each_denominator).round(1)
    end

    if @ones_place_group[9].present?
      @sum_9 = 0
      @ones_place_group[9].each do |number, medal|
        @sum_9 += medal
      end
      @average_9 = (@sum_9 / @each_denominator).round(1)
    end

    # 末尾ゾロ目の総差枚と平均差枚数
    # 1桁の台番を除き、かつ末尾ゾロ目台番データのみを配列にして返す
    @same_number_tool_units_array = @tool_units_array.select { |n, m| n >= 10 }.select { |n, m| n.digits[0] == n.digits[1] }
    # 末尾ゾロ目の総差枚数・平均差枚数を計算
    if @same_number_tool_units_array.present?
      @sum_same_number = 0
      @same_number_tool_units_array.each do |number, medal|
        @sum_same_number += medal
      end
      @average_same_number = (@sum_same_number / @each_denominator).round(1)
    end
  end

  def edit
    @tool = current_user.tools.find(params[:id])
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
    params.require(:tool).permit(:store_name, :total_unit, tool_units_attributes: [:id, :number, :medal, :_destroy])
  end
end
