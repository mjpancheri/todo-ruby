module TasksHelper
  def task_symbol(task)
    case status(task)
    when 'pending' then '»'
    when 'done' then '√'
    when 'expired' then '⨯'
    end
  end

  def task_color(task)
    case status(task)
    when 'pending' then 'text-primary'
    when 'done' then 'text-success'
    when 'expired' then 'text-danger'
    end
  end

  private

  def status(task)
    return 'done' if task.done

    task.due_date&.past? ? 'expired' : 'pending'
  end
end
