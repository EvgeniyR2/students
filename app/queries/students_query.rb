# frozen_string_literal: true

class StudentsQuery
  def call(relation, params)
    relation = filter_out(relation, params[:filter]) if params[:filter]
    relation = sort(relation, params[:sort]) if params[:sort]
    relation
  end

  private

  def filter_out(initial_relation, filter_line)
    relation = filter_by_full_name(initial_relation, filter_line)
    relation = filter_by_gender(initial_relation, relation, filter_line)
    relation = filter_by_identifier(initial_relation, relation, filter_line)
    relation
  end

  def filter_by_full_name(relation, filter_line)
    relation.where("first_name ilike '%#{filter_line}%' OR
      last_name ilike '%#{filter_line}%' OR
      middle_name ilike '%#{filter_line}%' OR
      CONCAT(first_name, ' ', middle_name, ' ', last_name) ilike '%#{filter_line}%' OR
      CONCAT(last_name, ' ', first_name, ' ', middle_name) ilike '%#{filter_line}%'")
  end

  def filter_by_gender(initial_relation, relation, filter_line)
    relation.or(initial_relation.where('gender ilike ?', "%#{filter_line}%"))
  end

  def filter_by_identifier(initial_relation, relation, filter_line)
    relation.or(initial_relation.where('identifier ilike ?', "%#{filter_line}%"))
  end

  def sort(relation, order_line)
    return relation unless Student::SORTING.key?(order_line)

    relation.order(Student::SORTING[order_line])
  end
end
