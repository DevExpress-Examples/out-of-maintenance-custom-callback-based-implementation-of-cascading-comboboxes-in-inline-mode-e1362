Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxClasses

Namespace MultiCombo
	Partial Public Class _Default
		Inherits Page
		Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

		End Sub

		Private Sub cmbCombo2_OnCallback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
			FillCombo(TryCast(source, ASPxComboBox), e.Parameter, dsCategory2)
		End Sub

		Private Sub cmbCombo3_OnCallback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
			FillCombo(TryCast(source, ASPxComboBox), e.Parameter, dsCategory3)
		End Sub

		Private Sub cmbCombo4_OnCallback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
			FillCombo(TryCast(source, ASPxComboBox), e.Parameter, dsCategory4)
		End Sub

		Protected Sub InitializeCombo(ByVal e As ASPxGridViewEditorEventArgs, ByVal parentComboName As String, ByVal source As SqlDataSource, ByVal callBackHandler As CallbackEventHandlerBase)

			Dim id As String = String.Empty
			If (Not grid.IsNewRowEditing) Then
				Dim val As Object = grid.GetRowValuesByKeyValue(e.KeyValue, parentComboName)
				If (val Is Nothing OrElse val Is DBNull.Value) Then
					id = Nothing
				Else
					id = val.ToString()
				End If
			End If
			Dim combo As ASPxComboBox = TryCast(e.Editor, ASPxComboBox)
			If combo IsNot Nothing Then
				' unbind combo
				combo.DataSourceID = Nothing
				FillCombo(combo, id, source)
				AddHandler combo.Callback, callBackHandler
			End If
			Return
		End Sub
		Protected Sub FillCombo(ByVal cmb As ASPxComboBox, ByVal id As String, ByVal source As SqlDataSource)
			cmb.Items.Clear()
			' trap null selection
			If String.IsNullOrEmpty(id) Then
				Return
			End If

			' get the values
			source.SelectParameters(0).DefaultValue = id
			Dim view As DataView = CType(source.Select(DataSourceSelectArguments.Empty), DataView)
			For Each row As DataRowView In view
				cmb.Items.Add(row(1).ToString(), row(0))
			Next row
		End Sub

		Protected Sub grid_CellEditorInitialize(ByVal sender As Object, ByVal e As ASPxGridViewEditorEventArgs)
			Select Case e.Column.FieldName
				Case "Category2ID"
					InitializeCombo(e, "Category1ID", dsCategory2, AddressOf cmbCombo2_OnCallback)
				Case "Category3ID"
					InitializeCombo(e, "Category2ID", dsCategory3, AddressOf cmbCombo3_OnCallback)
				Case "Category4ID"
					InitializeCombo(e, "Category3ID", dsCategory4, AddressOf cmbCombo4_OnCallback)
				Case Else
			End Select
		End Sub
	End Class
End Namespace
