class TermValidator < ActiveModel::Validator
  def validate(record)
    if (!record.term.end_term || !record.term.start_term) || record.term.end_term <= record.term.start_term
      record.errors[:'Time:'] << "Enter valid start & end times"
    end
  end
end
