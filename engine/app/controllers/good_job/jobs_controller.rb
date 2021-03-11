module GoodJob
  class JobsController < GoodJob::BaseController
    before_action :find_job_class

    def new
    end

    def create
      args = []
      @job_class.new.method(:perform).parameters.each do |req, name|
        if params[name]
          args << params[name]
        else
          args << nil
        end
      end

      @job = @job_class.send(:perform_later, *args)

      flash[:notice] = "Enqueued job with #{args.inspect}"
      redirect_to job_class_path(id: @job_class)
    end

  private

    def find_job_class
      Rails.application.eager_load!
      @job_classes = ActiveJob::Base.descendants
      @job_class = @job_classes.find {|jc| jc.to_s == params[:job_class_id] }
    end
  end
end
