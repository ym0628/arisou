class ToolsController < ApplicationController
  def index
    @tools = current_user.tools.includes(:user).order(created_at: :desc)
  end

  def show
    @tool = current_user.tools.find(params[:id])
    # 総設置台数から各末尾の分母を割り出す
    @each_denominator = @tool.total_unit.to_f / 10.round(1)
    # 台番号に重複があった場合に注意喚起のメッセージを表示
    unit_number_array = @tool.tool_units.pluck(:number)
    if unit_number_array.size != unit_number_array.uniq.size
      duplication_number = unit_number_array.select { |e| unit_number_array.count(e) > 1 }.uniq
      @duplication = flash.now[:warning] = "台番号 #{duplication_number} が#{t('defaults.message.duplication')}"
    end
    # 配列に作り直す
    @tool_units_array = @tool.tool_units.pluck(:number, :medal)
    # 差枚数がプラスの要素だけを取り出した配列を作り、さらに差枚プラスの台番だけを残した配列に直す
    @win_unit_number_array = @tool_units_array.select { |key, value| value > 0 }.pluck(0)
    # 各末尾(0~9)の台数をカウント
    @win_unit_number_ones_place_array_count = @win_unit_number_array.map do |n|
                                                n.digits[0]
                                              end.group_by { |a| a }.map { |key, value| [key, value.count] }.to_h
    # 末尾ゾロ目かつ差枚プラス台の台数をカウント
    @win_same_unit_number_array_count = @win_unit_number_array.select do |n|
                                          n > 10
                                        end.map { |n| n.digits[0..1] }.select { |a, b| a - b == 0 }.count
    # 各末尾ごとの勝率
    @win_rate0 = ((@win_unit_number_ones_place_array_count[0].to_i / @each_denominator) * 100).round(1)
    @win_rate1 = ((@win_unit_number_ones_place_array_count[1].to_i / @each_denominator) * 100).round(1)
    @win_rate2 = ((@win_unit_number_ones_place_array_count[2].to_i / @each_denominator) * 100).round(1)
    @win_rate3 = ((@win_unit_number_ones_place_array_count[3].to_i / @each_denominator) * 100).round(1)
    @win_rate4 = ((@win_unit_number_ones_place_array_count[4].to_i / @each_denominator) * 100).round(1)
    @win_rate5 = ((@win_unit_number_ones_place_array_count[5].to_i / @each_denominator) * 100).round(1)
    @win_rate6 = ((@win_unit_number_ones_place_array_count[6].to_i / @each_denominator) * 100).round(1)
    @win_rate7 = ((@win_unit_number_ones_place_array_count[7].to_i / @each_denominator) * 100).round(1)
    @win_rate8 = ((@win_unit_number_ones_place_array_count[8].to_i / @each_denominator) * 100).round(1)
    @win_rate9 = ((@win_unit_number_ones_place_array_count[9].to_i / @each_denominator) * 100).round(1)
    @win_rate_same_number = ((@win_same_unit_number_array_count.to_i / @each_denominator) * 100).round(1)

    # 各末尾(0~9まで)ごとの総差枚と平均差枚
    @ones_place_group = @tool_units_array.group_by { |key, value| key.digits[0] }.sort.to_h

    def calculate_sum(medals)
      sum = 0
      medals.each { |number, medal| sum += medal }
      sum
    end

    def calculate_average(medals)
      sum = 0
      medals.each { |number, medal| sum += medal }
      average = (sum / @each_denominator).round(1)
    end

    # 各末尾の総差枚数
    @sum0 = calculate_sum(@ones_place_group[0]) if @ones_place_group[0].present?
    @sum1 = calculate_sum(@ones_place_group[1]) if @ones_place_group[1].present?
    @sum2 = calculate_sum(@ones_place_group[2]) if @ones_place_group[2].present?
    @sum3 = calculate_sum(@ones_place_group[3]) if @ones_place_group[3].present?
    @sum4 = calculate_sum(@ones_place_group[4]) if @ones_place_group[4].present?
    @sum5 = calculate_sum(@ones_place_group[5]) if @ones_place_group[5].present?
    @sum6 = calculate_sum(@ones_place_group[6]) if @ones_place_group[6].present?
    @sum7 = calculate_sum(@ones_place_group[7]) if @ones_place_group[7].present?
    @sum8 = calculate_sum(@ones_place_group[8]) if @ones_place_group[8].present?
    @sum9 = calculate_sum(@ones_place_group[9]) if @ones_place_group[9].present?

    # 各末尾の平均差枚数
    @average0 = calculate_average(@ones_place_group[0]) if @ones_place_group[0].present?
    @average1 = calculate_average(@ones_place_group[1]) if @ones_place_group[1].present?
    @average2 = calculate_average(@ones_place_group[2]) if @ones_place_group[2].present?
    @average3 = calculate_average(@ones_place_group[3]) if @ones_place_group[3].present?
    @average4 = calculate_average(@ones_place_group[4]) if @ones_place_group[4].present?
    @average5 = calculate_average(@ones_place_group[5]) if @ones_place_group[5].present?
    @average6 = calculate_average(@ones_place_group[6]) if @ones_place_group[6].present?
    @average7 = calculate_average(@ones_place_group[7]) if @ones_place_group[7].present?
    @average8 = calculate_average(@ones_place_group[8]) if @ones_place_group[8].present?
    @average9 = calculate_average(@ones_place_group[9]) if @ones_place_group[9].present?

    # 末尾ゾロ目の総差枚と平均差枚数
    # 1桁の台番を除き、かつ末尾ゾロ目台番データのみを配列にして返す
    @same_number_tool_units_array = @tool_units_array.select do |n, m|
                                      n >= 10
                                    end.select { |n, m| n.digits[0] == n.digits[1] }
    # 末尾ゾロ目の総差枚数・平均差枚数を計算
    return unless @same_number_tool_units_array.present?

    @sum_same_number = 0
    @same_number_tool_units_array.each { |number, medal| @sum_same_number += medal }
    @average_same_number = (@sum_same_number / @each_denominator).round(1)
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
