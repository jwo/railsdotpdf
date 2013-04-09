class RendersPdf
  class Helpers
    extend ApplicationHelper
  end

  attr_accessor :pdf, :renderer, :template, :locals, :av, :html

  def initialize(template, locals={})
    if template.is_a? String
      @template = template
      @locals = locals
    elsif template.is_a? Hash
      @html = template[:html]
    end

    @renderer = WickedPdf.new
  end

  def render
    @pdf ||= begin
      self.renderer.pdf_from_string(html_code, pdf_options)
    end
  end

  private

  def html_code
    @html ||= action_view.render :template => self.template, :locals => self.locals, :layout => "layouts/report.html"
  end

  def footer_code
    action_view.render :template => "layouts/pdf_footer.html"
  end

  def pdf_options
    { :footer => { :content => footer_code},
      "javascript-delay" => 5000
    }
  end

  def action_view
    @av ||= begin
      ActionView::Base.new(Rails.application.config.paths["app/views"].first).tap do |avb|
        avb.class_eval do
          include Rails.application.routes.url_helpers
        end
      end
    end
  end
end

