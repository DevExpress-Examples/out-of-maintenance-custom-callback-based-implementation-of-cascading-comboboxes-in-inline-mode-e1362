<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MultiCombo._Default" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Custom callback based implementation of cascading comboboxes in an inline mode</title>
</head>
<body>
    <form id="form1" runat="server">        
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>

    <asp:SqlDataSource ID="dsData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [Data] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Data] ([Title], [Description], [Category1ID], [Category2ID], [Category3ID], [Category4ID]) VALUES (@Title, @Description, @Category1ID, @Category2ID, @Category3ID, @Category4ID)" SelectCommand="SELECT * FROM [Data]"
        UpdateCommand="UPDATE [Data] SET [Title] = @Title, [Description] = @Description, [Category1ID] = @Category1ID, [Category2ID] = @Category2ID, [Category3ID] = @Category3ID, [Category4ID] = @Category4ID WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Category1ID" Type="Int32" />
            <asp:Parameter Name="Category2ID" Type="Int32" />
            <asp:Parameter Name="Category3ID" Type="Int32" />
            <asp:Parameter Name="Category4ID" Type="Int32" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Category1ID" Type="Int32" />
            <asp:Parameter Name="Category2ID" Type="Int32" />
            <asp:Parameter Name="Category3ID" Type="Int32" />
            <asp:Parameter Name="Category4ID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="dsCategory1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        SelectCommand="SELECT * FROM [Category1]"></asp:SqlDataSource>
   
    <asp:SqlDataSource ID="dsCategory2All" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString3 %>"
        SelectCommand="SELECT ID, Name FROM Category2 ORDER BY Name">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsCategory3All" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString4 %>"
        SelectCommand="SELECT [ID], [Name] FROM [Category3] ORDER BY [Name]">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsCategory4All" runat="server" EnableCaching="True" ConnectionString="<%$ ConnectionStrings:ConnectionString5 %>"
        SelectCommand="SELECT [ID], [Name] FROM [Category4] ORDER BY [Name]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsCategory3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString4 %>"
        SelectCommand="SELECT [ID], [Name] FROM [Category3] WHERE ([Category2ID] = @Category2ID) ORDER BY [Name]">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="Category2ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsCategory2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString3 %>"
        SelectCommand="SELECT ID, Name FROM Category2 WHERE (Category1ID = @Category1ID) ORDER BY Name">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="Category1ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsCategory4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString5 %>"
        SelectCommand="SELECT [ID], [Name] FROM [Category4] WHERE ([Category3ID] = @Category3ID) ORDER BY [Name]">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="Category3ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        &nbsp;
      <script language="javascript" type="text/javascript">
    // <![CDATA[
    
    function OnCategory1Changed(cmbParent) {
        if(isUpdating)
            return;
        var comboValue = cmbParent.GetSelectedItem().value;
        if(comboValue)
            grid.GetEditor("Category2ID").PerformCallback(comboValue.toString());
    }
    
    function OnCategory2Changed(cmbParent) {
        if(isUpdating)
            return;    
        var comboValue = cmbParent.GetSelectedItem().value;
        if(comboValue)
            grid.GetEditor("Category3ID").PerformCallback(comboValue.toString());
    }
    
    function OnCategory3Changed(cmbParent) {
        if(isUpdating)
            return;    
        var comboValue = cmbParent.GetSelectedItem().value;
        if(comboValue)
            grid.GetEditor("Category4ID").PerformCallback(comboValue.toString());
    }

    var combo = null;
    var isUpdating = false;
   // ]]>
    </script>
    <br />
  
        <dxwgv:ASPxGridView ID="grid" runat="server" AutoGenerateColumns="False"
            DataSourceID="dsData" KeyFieldName="ID"  EnableCallBacks="True" OnCellEditorInitialize="grid_CellEditorInitialize">
            <Columns>
                <dxwgv:GridViewCommandColumn VisibleIndex="0">
                    <EditButton Visible="True">
                    </EditButton>
                    <NewButton Visible="True">
                    </NewButton>
                    <DeleteButton Visible="True">
                    </DeleteButton>
                </dxwgv:GridViewCommandColumn>
                <dxwgv:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dxwgv:GridViewDataTextColumn>
                <dxwgv:GridViewDataTextColumn FieldName="Title" VisibleIndex="2">
                </dxwgv:GridViewDataTextColumn>
                <dxwgv:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
                </dxwgv:GridViewDataTextColumn>
                <dxwgv:GridViewDataComboBoxColumn FieldName="Category1ID" VisibleIndex="4">
                    <PropertiesComboBox DataSourceID="dsCategory1" TextField="Name" ValueField="ID" ValueType="System.Int32">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { OnCategory1Changed(s); }" ></ClientSideEvents>
                    </PropertiesComboBox>
                </dxwgv:GridViewDataComboBoxColumn>
                <dxwgv:GridViewDataComboBoxColumn FieldName="Category2ID" VisibleIndex="5">
                    <PropertiesComboBox DataSourceID="dsCategory2All" TextField="Name" ValueField="ID"
                        ValueType="System.Int32">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { OnCategory2Changed(s); }" EndCallback="function(s, e) { combo = s; window.setTimeout('combo.SetSelectedIndex(0); OnCategory2Changed(combo);', 500); }" ></ClientSideEvents>
                    </PropertiesComboBox>
                </dxwgv:GridViewDataComboBoxColumn>
                <dxwgv:GridViewDataComboBoxColumn FieldName="Category3ID" VisibleIndex="6">
                    <PropertiesComboBox DataSourceID="dsCategory3All" TextField="Name" ValueField="ID"
                        ValueType="System.Int32">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { OnCategory3Changed(s); }" EndCallback="function(s, e) { combo = s; window.setTimeout('combo.SetSelectedIndex(0); OnCategory3Changed(combo);', 500); }"></ClientSideEvents>
                    </PropertiesComboBox>
                </dxwgv:GridViewDataComboBoxColumn>
                <dxwgv:GridViewDataComboBoxColumn FieldName="Category4ID" VisibleIndex="7">
                    <PropertiesComboBox DataSourceID="dsCategory4All" TextField="Name" ValueField="ID"
                        ValueType="System.Int32">
                    </PropertiesComboBox>
                </dxwgv:GridViewDataComboBoxColumn>
</Columns>
            <SettingsEditing Mode="Inline" />
</dxwgv:ASPxGridView>
    
    </div>
    </form>
</body>
</html>
