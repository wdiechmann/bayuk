class MainController < Volt::ModelController
  model :store
  reactive_accessor :_query
  
  def index
    # Add code for when the index view is loaded
  end
  
  def per_page
    5
  end
  
  def start_offset
    return (params._page.or(1).to_i - 1) * per_page
  end
  
  def paged_jobs
    _jobs.skip(start_offset).limit(per_page)
  end


  def queried_jobs
    _jobs.find({name: { '$regex' => _query.or(''), '$options' => 'i' }}) #.find({where_at: { '$regex' => _query.or(''), '$options' => 'i' }})
  end

  def about
    # Add code for when the about view is loaded
  end
  
  def current_job
    _jobs[params._index.or(0).to_i]
  end
  
  def add_job
    self._jobs << {name: page._new_job}
    page._new_job=''
  end
  
  def remove_job(job)
    _jobs.delete(job)
  end
  
  def this_year
    Date.today.strftime("%Y")
  end

  def percent_completed
    return ((completed / _jobs.size.to_f) * 100).round
  end
  
  def completed
    _jobs.count{|job| job._completed}
  end

  private

  # the main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end
end
