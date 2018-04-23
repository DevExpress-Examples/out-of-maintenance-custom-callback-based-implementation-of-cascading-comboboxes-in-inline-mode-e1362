using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxClasses;

namespace MultiCombo
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void cmbCombo2_OnCallback(object source, CallbackEventArgsBase e) {
            FillCombo(source as ASPxComboBox, e.Parameter, dsCategory2);
        }

        private void cmbCombo3_OnCallback(object source, CallbackEventArgsBase e) {
            FillCombo(source as ASPxComboBox, e.Parameter, dsCategory3);
        }

        private void cmbCombo4_OnCallback(object source, CallbackEventArgsBase e) {
            FillCombo(source as ASPxComboBox, e.Parameter, dsCategory4);
        }

        protected void InitializeCombo(ASPxGridViewEditorEventArgs e, 
            string parentComboName, SqlDataSource source, CallbackEventHandlerBase callBackHandler) {

            string id = string.Empty;
            if (!grid.IsNewRowEditing) {
                object val = grid.GetRowValuesByKeyValue(e.KeyValue, parentComboName);
                id = (val == null || val == DBNull.Value) ? null : val.ToString();
            }
            ASPxComboBox combo = e.Editor as ASPxComboBox;
            if (combo != null) {
                // unbind combo
                combo.DataSourceID = null;
                FillCombo(combo, id, source);
                combo.Callback += callBackHandler;
            }
            return;
        }
        protected void FillCombo(ASPxComboBox cmb, string id, SqlDataSource source) {
            cmb.Items.Clear();
            // trap null selection
            if (string.IsNullOrEmpty(id)) return;

            // get the values
            source.SelectParameters[0].DefaultValue = id;
            DataView view = (DataView)source.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView row in view) {
                cmb.Items.Add(row[1].ToString(), row[0]);
            }
        }

        protected void grid_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e) {
            switch (e.Column.FieldName) {
                case "Category2ID":
                    InitializeCombo(e, "Category1ID", dsCategory2, cmbCombo2_OnCallback);
                    break;
                case "Category3ID":
                    InitializeCombo(e, "Category2ID", dsCategory3, cmbCombo3_OnCallback);
                    break;
                case "Category4ID":
                    InitializeCombo(e, "Category3ID", dsCategory4, cmbCombo4_OnCallback);
                    break;
                default:
                    break;
            }
        }
    }
}
