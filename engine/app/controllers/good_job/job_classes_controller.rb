module GoodJob
  class JobClassesController < GoodJob::BaseController
    before_action :find_job_classes

    def index
      @last_success_by_job_class = GoodJob::Job.group("serialized_params->>'job_class'")
                                               .where(error: nil)
                                               .maximum(:finished_at)

      @last_failure_by_job_class = GoodJob::Job.group("serialized_params->>'job_class'")
                                               .where.not(error: nil)
                                               .maximum(:finished_at)
    end

    def show
      @job_class = @job_classes.find {|jc| jc.to_s == params[:id] }

      @jobs = GoodJob::Job.where("serialized_params->>'job_class' = ?", params[:id])
                          .order(finished_at: :desc)
                          .limit(10)
    end

  private

    def find_job_classes
      Rails.application.eager_load!
      @job_classes = ActiveJob::Base.descendants
    end
  end
end
