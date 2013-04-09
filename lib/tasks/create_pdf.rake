desc "Create a PDF"
task :create_pdf => :environment do
  Rails.application.eager_load!

    data = Struct.new(:month, :usage)
    months = 30.times.map do |i|
      data.new(rand(30).months.ago, rand(100))
    end

  File.open("output.pdf", "wb") do |f|
    f << RendersPdf.new("chart/_show", {pdf: true, months: months}).render
  end
  puts "created output.pdf"
end
