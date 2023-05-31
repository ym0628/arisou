module Calc
  extend ActiveSupport::Concern
  # 総設置台数から各末尾の分母を割り出すロジック
  def each_denominator(tool)
    tool.total_unit.to_f / 10.round(1)
  end

  # tool_unitsを配列にして返すロジック（勝率・総差枚・平均差枚の計算に用いる）
  def units_data(tool)
    tool.tool_units.pluck(:number, :medal)
  end

  module WinRate
    extend ActiveSupport::Concern
    # ----各末尾(ゾロ目含む)の勝率を算出するロジック-----
    # 差枚数プラス（勝ってる台）の台データの台番だけをピックアップした配列を返す
    def win_unit(tool)
      units_data(tool).select { |_key, value| value.positive? }.pluck(0)
    end

    # 各末尾(0~9)の差枚プラス（勝っている）台数をカウント
    def win_count(tool)
      win_unit(tool).map { |n| n.digits[0] }.group_by { |a| a }.transform_values(&:count)
    end

    # 末尾ゾロ目の差枚プラス（勝っている）台数をカウント
    def win_same_number_count(tool)
      win_unit(tool).select { |n| n > 10 }.map { |n| n.digits[0..1] }.count { |a, b| (a - b).zero? }
    end

    # 末尾0番の勝率
    def win_rate0(tool)
      ((win_count(tool)[0].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾1番の勝率
    def win_rate1(tool)
      ((win_count(tool)[1].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾2番の勝率
    def win_rate2(tool)
      ((win_count(tool)[2].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾3番の勝率
    def win_rate3(tool)
      ((win_count(tool)[3].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾4番の勝率
    def win_rate4(tool)
      ((win_count(tool)[4].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾5番の勝率
    def win_rate5(tool)
      ((win_count(tool)[5].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾6番の勝率
    def win_rate6(tool)
      ((win_count(tool)[6].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾7番の勝率
    def win_rate7(tool)
      ((win_count(tool)[7].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾8番の勝率
    def win_rate8(tool)
      ((win_count(tool)[8].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾9番の勝率
    def win_rate9(tool)
      ((win_count(tool)[9].to_i / each_denominator(tool)) * 100).round(1)
    end

    # 末尾ゾロ目の勝率
    def win_rate_same_number(tool)
      ((win_same_number_count(tool).to_i / each_denominator(tool)) * 100).round(1)
    end
  end

  module SumMedals
    extend ActiveSupport::Concern
    # ----各末尾(ゾロ目含む)の総差枚を算出するロジック-----
    # 台番・差枚の配列を各末尾(0~9)ごとにグループ分けして昇順に並べ替え
    def ones_place_group(tool)
      units_data(tool).group_by { |key, _value| key.digits[0] }.sort.to_h
    end

    # 末尾ゾロ目の台データを配列にして返す（1桁の台番を除き、かつ末尾ゾロ目の条件に合う要素を取り出す）
    def same_number_group(tool)
      units_data(tool).select { |n, _m| n >= 10 }.select { |n, _m| n.digits[0] == n.digits[1] }
    end

    # 総差枚数を計算するロジック(ゾロ目含む各末尾に使用)
    def calculate_sum(medals)
      sum = 0
      medals.each { |_number, medal| sum += medal }
      sum
    end

    # 末尾0の総差枚数をcalculate_sumメソッドに代入
    def sum0(tool)
      calculate_sum(ones_place_group(tool)[0]) if ones_place_group(tool)[0].present?
    end

    # 末尾1の総差枚数をcalculate_sumメソッドに代入
    def sum1(tool)
      calculate_sum(ones_place_group(tool)[1]) if ones_place_group(tool)[1].present?
    end

    # 末尾2の総差枚数をcalculate_sumメソッドに代入
    def sum2(tool)
      calculate_sum(ones_place_group(tool)[2]) if ones_place_group(tool)[2].present?
    end

    # 末尾3の総差枚数をcalculate_sumメソッドに代入
    def sum3(tool)
      calculate_sum(ones_place_group(tool)[3]) if ones_place_group(tool)[3].present?
    end

    # 末尾4の総差枚数をcalculate_sumメソッドに代入
    def sum4(tool)
      calculate_sum(ones_place_group(tool)[4]) if ones_place_group(tool)[4].present?
    end

    # 末尾5の総差枚数をcalculate_sumメソッドに代入
    def sum5(tool)
      calculate_sum(ones_place_group(tool)[5]) if ones_place_group(tool)[5].present?
    end

    # 末尾6の総差枚数をcalculate_sumメソッドに代入
    def sum6(tool)
      calculate_sum(ones_place_group(tool)[6]) if ones_place_group(tool)[6].present?
    end

    # 末尾7の総差枚数をcalculate_sumメソッドに代入
    def sum7(tool)
      calculate_sum(ones_place_group(tool)[7]) if ones_place_group(tool)[7].present?
    end

    # 末尾8の総差枚数をcalculate_sumメソッドに代入
    def sum8(tool)
      calculate_sum(ones_place_group(tool)[8]) if ones_place_group(tool)[8].present?
    end

    # 末尾9の総差枚数をcalculate_sumメソッドに代入
    def sum9(tool)
      calculate_sum(ones_place_group(tool)[9]) if ones_place_group(tool)[9].present?
    end

    # 末尾ゾロ目の総差枚数をcalculate_sumメソッドに代入
    def sum_same_number(tool)
      calculate_sum(same_number_group(tool)) if same_number_group(tool).present?
    end
  end

  module AverageMedals
    extend ActiveSupport::Concern
    # ----各末尾(ゾロ目含む)の平均差枚を算出するロジック-----
    # 末尾0の平均差枚数を計算
    def average0(tool)
      (sum0(tool) / each_denominator(tool)) if ones_place_group(tool)[0].present?
    end

    # 末尾1の平均差枚数を計算
    def average1(tool)
      (sum1(tool) / each_denominator(tool)) if ones_place_group(tool)[1].present?
    end

    # 末尾2の平均差枚数を計算
    def average2(tool)
      (sum2(tool) / each_denominator(tool)) if ones_place_group(tool)[2].present?
    end

    # 末尾3の平均差枚数を計算
    def average3(tool)
      (sum3(tool) / each_denominator(tool)) if ones_place_group(tool)[3].present?
    end

    # 末尾4の平均差枚数を計算
    def average4(tool)
      (sum4(tool) / each_denominator(tool)) if ones_place_group(tool)[4].present?
    end

    # 末尾5の平均差枚数を計算
    def average5(tool)
      (sum5(tool) / each_denominator(tool)) if ones_place_group(tool)[5].present?
    end

    # 末尾6の平均差枚数を計算
    def average6(tool)
      (sum6(tool) / each_denominator(tool)) if ones_place_group(tool)[6].present?
    end

    # 末尾7の平均差枚数を計算
    def average7(tool)
      (sum7(tool) / each_denominator(tool)) if ones_place_group(tool)[7].present?
    end

    # 末尾8の平均差枚数を計算
    def average8(tool)
      (sum8(tool) / each_denominator(tool)) if ones_place_group(tool)[8].present?
    end

    # 末尾9の平均差枚数を計算
    def average9(tool)
      (sum9(tool) / each_denominator(tool)) if ones_place_group(tool)[9].present?
    end

    # 末尾ゾロ目の平均差枚数を計算
    def average_same_number(tool)
      (sum_same_number(tool) / each_denominator(tool)) if same_number_group(tool).present?
    end
  end
end
