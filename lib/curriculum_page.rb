class CurriculumPage < BedeliasPage
  def groups
    all("//li[@data-nodetype='Grupo'][not(*//li[@data-nodetype='Grupo'])]/span")
  end

  def subjects_in_group(group_node)
    group_node.all('..//li[@data-nodetype="Materia"]/span')
  end

  def group_details(group_node)
    code, name = group_node.text.split(' - ')
    min_credits = group_node.text.split('créditos: ').last

    {
      code: code,
      name: name,
      min_credits: min_credits.delete('^0-9').to_i
    }
  end

  def subject_details(subject_node)
    code, name = subject_node.text.split(' - ')
    credits = subject_node.text.split('créditos: ').last
    {
      code: code,
      name: name,
      credits: credits.delete('^0-9').to_i,
      has_exam: nil
    }
  end
end
