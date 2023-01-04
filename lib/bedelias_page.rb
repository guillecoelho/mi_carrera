class BedeliasPage
  attr_reader :browser
  delegate :find, :click_on, :all, :first, :within, to: :browser

  def initialize(browser)
    @browser = browser
  end

  def visit_curriculum
    click_on "PLANES DE ESTUDIO"
    click_on "Planes de estudio / Previas"
    find(:css, 'h3', text: 'TECNOLOGÍA Y CIENCIAS DE LA NATURALEZA').click
    find(:css, 'tr span', text: 'FING - FACULTAD DE INGENIERÍA').click
    within(:css, 'tr', text: 'INGENIERIA EN COMPUTACION', match: :prefer_exact) do
      find(:css, 'div.ui-row-toggler').click
    end
    within(:css, '.ui-expanded-row-content .ui-datatable', text: 'Planes') do
      find(:css, 'tr', text: '1997').click_on "Ver más datos"
    end
  end

  def visit_prerequisites
    visit_curriculum
    click_on "Sistema de previaturas"
  end
end
