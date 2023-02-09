require "application_system_test_case"

class ApprovalTest < ApplicationSystemTestCase
  setup do
    @subject = create :subject, :with_exam, name: "GAL 1", credits: 9
  end

  test "student adds approved course from show" do
    visit subject_path(@subject)

    check "Curso aprobado?", visible: :all
    wait_for_approvables_reloaded
    visit root_path

    assert_text "0 créditos"
    assert page.has_checked_field?("checkbox_#{@subject.id}_course_approved", visible: :all)
    visit subject_path(@subject)
    assert page.has_checked_field?("Curso aprobado?", visible: :all)
  end

  test "student adds approved course from index" do
    visit root_path

    find("#checkbox_#{@subject.id}_course_approved", visible: :all).click
    wait_for_approvables_reloaded
    visit root_path

    assert_text "0 créditos"
    assert page.has_checked_field?("checkbox_#{@subject.id}_course_approved", visible: :all)
    visit subject_path(@subject)
    assert page.has_checked_field?("Curso aprobado?", visible: :all)
  end

  test "student adds approved exam from show" do
    visit subject_path(@subject)

    check "Examen aprobado?", visible: :all
    wait_for_approvables_reloaded
    visit root_path

    assert_text "9 créditos"
    assert page.has_checked_field?("checkbox_#{@subject.id}_exam_approved", visible: :all)
    visit subject_path(@subject)
    assert page.has_checked_field?("Examen aprobado?", visible: :all)
  end

  test "student adds approved exam from index" do
    visit root_path
    find("#checkbox_#{@subject.id}_course_approved", visible: :all).click
    wait_for_approvables_reloaded

    find("#checkbox_#{@subject.id}_exam_approved", visible: :all).click

    assert_text "9 créditos"
    visit root_path
    assert_text "9 créditos"
    assert page.has_checked_field?("checkbox_#{@subject.id}_exam_approved", visible: :all)
    visit subject_path(@subject)
    assert page.has_checked_field?("Examen aprobado?", visible: :all)
  end

  test "student remove approved course from show" do
    visit subject_path(@subject)
    check "Curso aprobado?", visible: :all
    wait_for_approvables_reloaded

    visit subject_path(@subject)
    uncheck "Curso aprobado?", visible: :all
    wait_for_approvables_reloaded
    visit subject_path(@subject)

    assert page.has_unchecked_field?("Curso aprobado?", visible: :all)
    visit root_path
    assert page.has_unchecked_field?("checkbox_#{@subject.id}_course_approved", visible: :all)
  end

  test "student remove approved course from index" do
    visit root_path
    find("#checkbox_#{@subject.id}_course_approved", visible: :all).click
    wait_for_approvables_reloaded

    visit root_path
    find("#checkbox_#{@subject.id}_course_approved", visible: :all).click
    wait_for_approvables_reloaded
    visit root_path

    assert page.has_unchecked_field?("checkbox_#{@subject.id}_course_approved", visible: :all)
    visit subject_path(@subject)
    assert page.has_unchecked_field?("Curso aprobado?", visible: :all)
  end

  test "student remove approved exam from show" do
    visit subject_path(@subject)
    check "Curso aprobado?", visible: :all
    wait_for_approvables_reloaded
    check "Examen aprobado?", visible: :all
    wait_for_approvables_reloaded

    visit subject_path(@subject)
    uncheck "Examen aprobado?", visible: :all
    wait_for_approvables_reloaded
    visit subject_path(@subject)

    assert page.has_unchecked_field?("Examen aprobado?", visible: :all)
    visit root_path
    assert page.has_unchecked_field?("checkbox_#{@subject.id}_exam_approved", visible: :all)
  end

  test "student remove approved exam from index" do
    visit root_path
    find("#checkbox_#{@subject.id}_course_approved", visible: :all).click
    wait_for_approvables_reloaded
    find("#checkbox_#{@subject.id}_exam_approved", visible: :all).click
    wait_for_approvables_reloaded

    visit root_path
    find("#checkbox_#{@subject.id}_exam_approved", visible: :all).click
    wait_for_approvables_reloaded
    visit root_path

    assert_text "0 créditos"
    assert page.has_unchecked_field?("checkbox_#{@subject.id}_exam_approved", visible: :all)
    visit subject_path(@subject)
    assert page.has_unchecked_field?("Examen aprobado?", visible: :all)
  end
end
