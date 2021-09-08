namespace Course_Selection
{
    partial class Form1
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.tbxStudentID = new System.Windows.Forms.TextBox();
            this.tbxStudentName = new System.Windows.Forms.TextBox();
            this.tbxNumber = new System.Windows.Forms.TextBox();
            this.tbxSubmited = new System.Windows.Forms.TextBox();
            this.tbxCredit = new System.Windows.Forms.TextBox();
            this.oleDbSelectCommand1 = new System.Data.OleDb.OleDbCommand();
            this.oleDbConnection = new System.Data.OleDb.OleDbConnection();
            this.oleDbInsertCommand1 = new System.Data.OleDb.OleDbCommand();
            this.oleDbUpdateCommand1 = new System.Data.OleDb.OleDbCommand();
            this.oleDbDeleteCommand1 = new System.Data.OleDb.OleDbCommand();
            this.Adapter_Update = new System.Data.OleDb.OleDbDataAdapter();
            this.oleDbSelectCommand2 = new System.Data.OleDb.OleDbCommand();
            this.Adapter_Selected = new System.Data.OleDb.OleDbDataAdapter();
            this.oleDbSelectCommand3 = new System.Data.OleDb.OleDbCommand();
            this.Adapter_UnSelected = new System.Data.OleDb.OleDbDataAdapter();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.btnDelete = new System.Windows.Forms.Button();
            this.btnAdd = new System.Windows.Forms.Button();
            this.btnSubmit = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.oleDbSelectCommand5 = new System.Data.OleDb.OleDbCommand();
            this.oleDbInsertCommand3 = new System.Data.OleDb.OleDbCommand();
            this.oleDbUpdateCommand3 = new System.Data.OleDb.OleDbCommand();
            this.oleDbDeleteCommand3 = new System.Data.OleDb.OleDbCommand();
            this.Adapter_IsSubmited = new System.Data.OleDb.OleDbDataAdapter();
            this.dataGrid2 = new System.Windows.Forms.DataGrid();
            this.dataSet11 = new Course_Selection.DataSet1();
            this.dataGrid1 = new System.Windows.Forms.DataGrid();
            ((System.ComponentModel.ISupportInitialize)(this.dataGrid2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet11)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGrid1)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 12);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(52, 15);
            this.label1.TabIndex = 0;
            this.label1.Text = "学号：";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 42);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(52, 15);
            this.label2.TabIndex = 1;
            this.label2.Text = "姓名：";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(279, 44);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(82, 15);
            this.label3.TabIndex = 2;
            this.label3.Text = "提交状态：";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(13, 75);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(112, 15);
            this.label4.TabIndex = 3;
            this.label4.Text = "已选课程数量：";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(280, 76);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(112, 15);
            this.label5.TabIndex = 4;
            this.label5.Text = "已选课程学分：";
            // 
            // tbxStudentID
            // 
            this.tbxStudentID.Location = new System.Drawing.Point(71, 10);
            this.tbxStudentID.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.tbxStudentID.Name = "tbxStudentID";
            this.tbxStudentID.Size = new System.Drawing.Size(100, 25);
            this.tbxStudentID.TabIndex = 5;
            this.tbxStudentID.TextChanged += new System.EventHandler(this.tbxStudentID_TextChanged);
            // 
            // tbxStudentName
            // 
            this.tbxStudentName.Location = new System.Drawing.Point(71, 40);
            this.tbxStudentName.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.tbxStudentName.Name = "tbxStudentName";
            this.tbxStudentName.ReadOnly = true;
            this.tbxStudentName.Size = new System.Drawing.Size(201, 25);
            this.tbxStudentName.TabIndex = 6;
            // 
            // tbxNumber
            // 
            this.tbxNumber.Location = new System.Drawing.Point(131, 72);
            this.tbxNumber.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.tbxNumber.Name = "tbxNumber";
            this.tbxNumber.ReadOnly = true;
            this.tbxNumber.Size = new System.Drawing.Size(143, 25);
            this.tbxNumber.TabIndex = 7;
            // 
            // tbxSubmited
            // 
            this.tbxSubmited.Location = new System.Drawing.Point(371, 39);
            this.tbxSubmited.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.tbxSubmited.Name = "tbxSubmited";
            this.tbxSubmited.ReadOnly = true;
            this.tbxSubmited.Size = new System.Drawing.Size(207, 25);
            this.tbxSubmited.TabIndex = 8;
            // 
            // tbxCredit
            // 
            this.tbxCredit.Location = new System.Drawing.Point(404, 72);
            this.tbxCredit.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.tbxCredit.Name = "tbxCredit";
            this.tbxCredit.ReadOnly = true;
            this.tbxCredit.Size = new System.Drawing.Size(173, 25);
            this.tbxCredit.TabIndex = 9;
            // 
            // oleDbSelectCommand1
            // 
            this.oleDbSelectCommand1.CommandText = "SELECT  Student_ID, Class_ID\r\nFROM      Selected_Class";
            this.oleDbSelectCommand1.Connection = this.oleDbConnection;
            // 
            // oleDbConnection
            // 
            this.oleDbConnection.ConnectionString = "Provider=SQLNCLI11;Data Source=DESKTOP-EBE2QHC\\SQLEXPRESS;Integrated Security=SSP" +
    "I;Initial Catalog=Course_Selection";
            // 
            // oleDbInsertCommand1
            // 
            this.oleDbInsertCommand1.CommandText = "INSERT INTO [Selected_Class] ([Student_ID], [Class_ID]) VALUES (?, ?)";
            this.oleDbInsertCommand1.Connection = this.oleDbConnection;
            this.oleDbInsertCommand1.Parameters.AddRange(new System.Data.OleDb.OleDbParameter[] {
            new System.Data.OleDb.OleDbParameter("Student_ID", System.Data.OleDb.OleDbType.Integer, 0, "Student_ID"),
            new System.Data.OleDb.OleDbParameter("Class_ID", System.Data.OleDb.OleDbType.Integer, 0, "Class_ID")});
            // 
            // oleDbUpdateCommand1
            // 
            this.oleDbUpdateCommand1.CommandText = "UPDATE [Selected_Class] SET [Student_ID] = ?, [Class_ID] = ? WHERE (([Student_ID]" +
    " = ?) AND ([Class_ID] = ?))";
            this.oleDbUpdateCommand1.Connection = this.oleDbConnection;
            this.oleDbUpdateCommand1.Parameters.AddRange(new System.Data.OleDb.OleDbParameter[] {
            new System.Data.OleDb.OleDbParameter("Student_ID", System.Data.OleDb.OleDbType.Integer, 0, "Student_ID"),
            new System.Data.OleDb.OleDbParameter("Class_ID", System.Data.OleDb.OleDbType.Integer, 0, "Class_ID"),
            new System.Data.OleDb.OleDbParameter("Original_Student_ID", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, false, ((byte)(0)), ((byte)(0)), "Student_ID", System.Data.DataRowVersion.Original, null),
            new System.Data.OleDb.OleDbParameter("Original_Class_ID", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, false, ((byte)(0)), ((byte)(0)), "Class_ID", System.Data.DataRowVersion.Original, null)});
            // 
            // oleDbDeleteCommand1
            // 
            this.oleDbDeleteCommand1.CommandText = "DELETE FROM Selected_Class\r\nWHERE   (Student_ID = ?)";
            this.oleDbDeleteCommand1.Connection = this.oleDbConnection;
            this.oleDbDeleteCommand1.Parameters.AddRange(new System.Data.OleDb.OleDbParameter[] {
            new System.Data.OleDb.OleDbParameter("Student_ID", System.Data.OleDb.OleDbType.Integer, 4, System.Data.ParameterDirection.Input, false, ((byte)(0)), ((byte)(0)), "Student_ID", System.Data.DataRowVersion.Original, null)});
            // 
            // Adapter_Update
            // 
            this.Adapter_Update.DeleteCommand = this.oleDbDeleteCommand1;
            this.Adapter_Update.InsertCommand = this.oleDbInsertCommand1;
            this.Adapter_Update.SelectCommand = this.oleDbSelectCommand1;
            this.Adapter_Update.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
            new System.Data.Common.DataTableMapping("Table", "Class_Selected", new System.Data.Common.DataColumnMapping[] {
                        new System.Data.Common.DataColumnMapping("Student_ID", "Student_ID"),
                        new System.Data.Common.DataColumnMapping("Class_ID", "Class_ID")})});
            this.Adapter_Update.UpdateCommand = this.oleDbUpdateCommand1;
            // 
            // oleDbSelectCommand2
            // 
            this.oleDbSelectCommand2.CommandText = resources.GetString("oleDbSelectCommand2.CommandText");
            this.oleDbSelectCommand2.Connection = this.oleDbConnection;
            this.oleDbSelectCommand2.Parameters.AddRange(new System.Data.OleDb.OleDbParameter[] {
            new System.Data.OleDb.OleDbParameter("Param1", System.Data.OleDb.OleDbType.Integer, 4)});
            // 
            // Adapter_Selected
            // 
            this.Adapter_Selected.SelectCommand = this.oleDbSelectCommand2;
            this.Adapter_Selected.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
            new System.Data.Common.DataTableMapping("Table", "Class_Selected", new System.Data.Common.DataColumnMapping[] {
                        new System.Data.Common.DataColumnMapping("Class_ID", "课程号"),
                        new System.Data.Common.DataColumnMapping("Name", "Name"),
                        new System.Data.Common.DataColumnMapping("Credit", "Credit"),
                        new System.Data.Common.DataColumnMapping("TeacherName", "TeacherName"),
                        new System.Data.Common.DataColumnMapping("Time", "Time")})});
            // 
            // oleDbSelectCommand3
            // 
            this.oleDbSelectCommand3.CommandText = resources.GetString("oleDbSelectCommand3.CommandText");
            this.oleDbSelectCommand3.Connection = this.oleDbConnection;
            this.oleDbSelectCommand3.Parameters.AddRange(new System.Data.OleDb.OleDbParameter[] {
            new System.Data.OleDb.OleDbParameter("Param1", System.Data.OleDb.OleDbType.Integer, 4)});
            // 
            // Adapter_UnSelected
            // 
            this.Adapter_UnSelected.SelectCommand = this.oleDbSelectCommand3;
            this.Adapter_UnSelected.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
            new System.Data.Common.DataTableMapping("Table", "Class_UnSelected", new System.Data.Common.DataColumnMapping[] {
                        new System.Data.Common.DataColumnMapping("Class_ID", "Class_ID"),
                        new System.Data.Common.DataColumnMapping("Name", "Name"),
                        new System.Data.Common.DataColumnMapping("Credit", "Credit"),
                        new System.Data.Common.DataColumnMapping("TeacherName", "TeacherName"),
                        new System.Data.Common.DataColumnMapping("Time", "Time")})});
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(13, 114);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(112, 15);
            this.label6.TabIndex = 11;
            this.label6.Text = "已选课程列表：";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(12, 325);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(112, 15);
            this.label7.TabIndex = 13;
            this.label7.Text = "可选课程列表：";
            // 
            // btnDelete
            // 
            this.btnDelete.Location = new System.Drawing.Point(541, 299);
            this.btnDelete.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(75, 28);
            this.btnDelete.TabIndex = 15;
            this.btnDelete.Text = "删除";
            this.btnDelete.UseVisualStyleBackColor = true;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(543, 515);
            this.btnAdd.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(75, 29);
            this.btnAdd.TabIndex = 16;
            this.btnAdd.Text = "添加";
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnSubmit
            // 
            this.btnSubmit.Location = new System.Drawing.Point(541, 560);
            this.btnSubmit.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnSubmit.Name = "btnSubmit";
            this.btnSubmit.Size = new System.Drawing.Size(76, 28);
            this.btnSubmit.TabIndex = 17;
            this.btnSubmit.Text = "提交";
            this.btnSubmit.UseVisualStyleBackColor = true;
            this.btnSubmit.Click += new System.EventHandler(this.btnSubmit_Click);
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(453, 560);
            this.btnSave.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(83, 28);
            this.btnSave.TabIndex = 18;
            this.btnSave.Text = "保存";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // oleDbSelectCommand5
            // 
            this.oleDbSelectCommand5.CommandText = "SELECT  Student_ID\r\nFROM      Submited";
            this.oleDbSelectCommand5.Connection = this.oleDbConnection;
            // 
            // oleDbInsertCommand3
            // 
            this.oleDbInsertCommand3.CommandText = "INSERT INTO [Submited] ([Student_ID]) VALUES (?)";
            this.oleDbInsertCommand3.Connection = this.oleDbConnection;
            this.oleDbInsertCommand3.Parameters.AddRange(new System.Data.OleDb.OleDbParameter[] {
            new System.Data.OleDb.OleDbParameter("Student_ID", System.Data.OleDb.OleDbType.Integer, 0, "Student_ID")});
            // 
            // oleDbUpdateCommand3
            // 
            this.oleDbUpdateCommand3.CommandText = "UPDATE [Submited] SET [Student_ID] = ? WHERE (([Student_ID] = ?))";
            this.oleDbUpdateCommand3.Connection = this.oleDbConnection;
            this.oleDbUpdateCommand3.Parameters.AddRange(new System.Data.OleDb.OleDbParameter[] {
            new System.Data.OleDb.OleDbParameter("Student_ID", System.Data.OleDb.OleDbType.Integer, 0, "Student_ID"),
            new System.Data.OleDb.OleDbParameter("Original_Student_ID", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, false, ((byte)(0)), ((byte)(0)), "Student_ID", System.Data.DataRowVersion.Original, null)});
            // 
            // oleDbDeleteCommand3
            // 
            this.oleDbDeleteCommand3.CommandText = "DELETE FROM [Submited] WHERE (([Student_ID] = ?))";
            this.oleDbDeleteCommand3.Connection = this.oleDbConnection;
            this.oleDbDeleteCommand3.Parameters.AddRange(new System.Data.OleDb.OleDbParameter[] {
            new System.Data.OleDb.OleDbParameter("Original_Student_ID", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, false, ((byte)(0)), ((byte)(0)), "Student_ID", System.Data.DataRowVersion.Original, null)});
            // 
            // Adapter_IsSubmited
            // 
            this.Adapter_IsSubmited.DeleteCommand = this.oleDbDeleteCommand3;
            this.Adapter_IsSubmited.InsertCommand = this.oleDbInsertCommand3;
            this.Adapter_IsSubmited.SelectCommand = this.oleDbSelectCommand5;
            this.Adapter_IsSubmited.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
            new System.Data.Common.DataTableMapping("Table", "Submited", new System.Data.Common.DataColumnMapping[] {
                        new System.Data.Common.DataColumnMapping("Student_ID", "Student_ID")})});
            this.Adapter_IsSubmited.UpdateCommand = this.oleDbUpdateCommand3;
            // 
            // dataGrid2
            // 
            this.dataGrid2.DataMember = "Class_UnSelected";
            this.dataGrid2.DataSource = this.dataSet11;
            this.dataGrid2.HeaderForeColor = System.Drawing.SystemColors.ControlText;
            this.dataGrid2.Location = new System.Drawing.Point(15, 342);
            this.dataGrid2.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.dataGrid2.Name = "dataGrid2";
            this.dataGrid2.ReadOnly = true;
            this.dataGrid2.Size = new System.Drawing.Size(603, 168);
            this.dataGrid2.TabIndex = 14;
            // 
            // dataSet11
            // 
            this.dataSet11.DataSetName = "DataSet1";
            this.dataSet11.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // dataGrid1
            // 
            this.dataGrid1.DataMember = "Class_Selected";
            this.dataGrid1.DataSource = this.dataSet11;
            this.dataGrid1.HeaderForeColor = System.Drawing.SystemColors.ControlText;
            this.dataGrid1.Location = new System.Drawing.Point(16, 132);
            this.dataGrid1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.dataGrid1.Name = "dataGrid1";
            this.dataGrid1.ReadOnly = true;
            this.dataGrid1.Size = new System.Drawing.Size(603, 161);
            this.dataGrid1.TabIndex = 12;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(623, 601);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnSubmit);
            this.Controls.Add(this.btnAdd);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.dataGrid2);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.dataGrid1);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.tbxCredit);
            this.Controls.Add(this.tbxSubmited);
            this.Controls.Add(this.tbxNumber);
            this.Controls.Add(this.tbxStudentName);
            this.Controls.Add(this.tbxStudentID);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "Form1";
            this.Text = "学生选课";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGrid2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet11)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGrid1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tbxStudentID;
        private System.Windows.Forms.TextBox tbxStudentName;
        private System.Windows.Forms.TextBox tbxNumber;
        private System.Windows.Forms.TextBox tbxSubmited;
        private System.Windows.Forms.TextBox tbxCredit;
        private System.Data.OleDb.OleDbCommand oleDbSelectCommand1;
        private System.Data.OleDb.OleDbConnection oleDbConnection;
        private System.Data.OleDb.OleDbCommand oleDbInsertCommand1;
        private System.Data.OleDb.OleDbCommand oleDbUpdateCommand1;
        private System.Data.OleDb.OleDbCommand oleDbDeleteCommand1;
        private System.Data.OleDb.OleDbDataAdapter Adapter_Update;
        private System.Data.OleDb.OleDbCommand oleDbSelectCommand2;
        private System.Data.OleDb.OleDbDataAdapter Adapter_Selected;
        private System.Data.OleDb.OleDbCommand oleDbSelectCommand3;
        private System.Data.OleDb.OleDbDataAdapter Adapter_UnSelected;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.DataGrid dataGrid1;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.DataGrid dataGrid2;
        private DataSet1 dataSet11;
        private System.Windows.Forms.Button btnDelete;
        private System.Windows.Forms.Button btnAdd;
        private System.Windows.Forms.Button btnSubmit;
        private System.Windows.Forms.Button btnSave;
        private System.Data.OleDb.OleDbCommand oleDbSelectCommand5;
        private System.Data.OleDb.OleDbCommand oleDbInsertCommand3;
        private System.Data.OleDb.OleDbCommand oleDbUpdateCommand3;
        private System.Data.OleDb.OleDbCommand oleDbDeleteCommand3;
        private System.Data.OleDb.OleDbDataAdapter Adapter_IsSubmited;
    }
}

