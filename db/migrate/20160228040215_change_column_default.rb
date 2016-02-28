class ChangeColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :applications, :verified, true
  end
end
