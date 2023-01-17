module ApplicationHelper
  APPLICATION_NAME = 'StudyRecords'.freeze

  # controllerごとに適用させるcss用のクラス名を生成する
  def style_class_namespace
    controller.controller_path.tr('/', '-')
  end
end
