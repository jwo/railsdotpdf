class ChartController < ApplicationController
  def show


    data = Struct.new(:month, :usage)
    @months = 30.times.map do |i|
      data.new(rand(30).months.ago, rand(100))
    end

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file_name", 
          layout: 'report.html',
          "javascript-delay" => 5000
      end
    end
  end

end
