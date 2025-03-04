class BaseStudent
  def initialize(approved_approvable_ids)
    @approved_approvable_ids = approved_approvable_ids
  end

  def add(approvable)
    if ids.exclude?(approvable.id) && approvable.available?(ids)
      ids << approvable.id
      add(approvable.subject.course) if approvable.is_exam?
      save!
    end
  end

  def remove(approvable)
    ids.delete(approvable.id)
    if !approvable.is_exam? && approvable.subject.exam.present? && ids.include?(approvable.subject.exam.id)
      ids.delete(approvable.subject.exam.id)
    end
    save!
  end

  def available?(subject_or_approvable) = subject_or_approvable.available?(ids)
  def approved?(subject_or_approvable) = subject_or_approvable.approved?(ids)
  def group_credits(group) = group.subjects.approved_credits(ids)
  def total_credits = Subject.approved_credits(ids)
  def welcome_banner_viewed? = raise NotImplementedError
  def welcome_banner_mark_as_viewed! = raise NotImplementedError
  def met?(prerequisite) = prerequisite.met?(ids)

  private

  attr_reader :approved_approvable_ids
  alias_method :ids, :approved_approvable_ids

  def save!
    raise NotImplementedError
  end
end
