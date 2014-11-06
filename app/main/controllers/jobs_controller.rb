class JobsController < Volt::ModelController
  reactive_accessor :_query

  def index
    new()
  end

  def edit
  end

  def new
    self.model = store._jobs.buffer
  end

  def select(job)
    self.model = job.buffer
  end

  def remove(job)
    queried_jobs.delete(job)
  end

  def queried_jobs
    store._jobs.find({name: { '$regex' => _query.or(''), '$options' => 'i' }})
  end

  def searching
    queried_jobs.state == :loading
  end

end