using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb; 
using System.Windows.Forms;

namespace Course_Selection
{
    public partial class Form1 : Form
    {
        private int number_selected,credit_selected,submited;
        private String SID, SName;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            //获取行序号
            int CID = this.dataGrid1.CurrentRowIndex;
            //建立新行对象
            DataRow row = dataSet11.Class_UnSelected.NewRow();
            row["Class_ID"]=dataSet11.Class_Selected[CID]["Class_ID"];
            row["Name"] = dataSet11.Class_Selected[CID]["Name"];
            row["Credit"] = dataSet11.Class_Selected[CID]["Credit"];
            row["TeacherName"] = dataSet11.Class_Selected[CID]["TeacherName"];
            row["Time"] = dataSet11.Class_Selected[CID]["Time"];
            //删除原表对应行
            dataSet11.Class_Selected[CID].Delete();
            //插入新行
            dataSet11.Class_UnSelected.Rows.InsertAt(row, 0);
            //使数据表接受更新操作，防止重复删除导致的序号错误
            dataSet11.Class_Selected.AcceptChanges();
            dataSet11.Class_UnSelected.AcceptChanges();
            //更新已选课程数和已选学分信息
            Update_Text();
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            //获取行序号
            int CID = this.dataGrid2.CurrentRowIndex;
            //验证是否重复选择同类课程
            int limit = dataSet11.Class_Selected.Count;
            for(int i=0;i<limit;i++)
            {
                if(dataSet11.Class_Selected[i]["Name"].ToString()==
                    dataSet11.Class_UnSelected[CID]["Name"].ToString())
                {
                    MessageBox.Show("不可重复选择同一项课程","提示" );
                    return;
                }
            }
            //建立新行对象
            DataRow row = dataSet11.Class_Selected.NewRow();
            row["Class_ID"] = dataSet11.Class_UnSelected[CID]["Class_ID"];
            row["Name"] = dataSet11.Class_UnSelected[CID]["Name"];
            row["Credit"] = dataSet11.Class_UnSelected[CID]["Credit"];
            row["TeacherName"] = dataSet11.Class_UnSelected[CID]["TeacherName"];
            row["Time"] = dataSet11.Class_UnSelected[CID]["Time"];
            //删除原表对应行
            dataSet11.Class_UnSelected[CID].Delete();
            //插入新行
            dataSet11.Class_Selected.Rows.InsertAt(row, 0);
            //使数据表接受更新操作，防止重复删除导致的序号错误
            dataSet11.Class_Selected.AcceptChanges();
            dataSet11.Class_UnSelected.AcceptChanges();
            //更新已选课程数和已选学分信息
            Update_Text();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("确定保存选课信息（会覆盖原有提交信息）？", "提示", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
            if (dr == DialogResult.No)
                return;

            //从数据库中删除原选课记录
            Adapter_Update.DeleteCommand.Parameters[0].Value = Convert.ToInt32(this.SID);
            Adapter_Update.DeleteCommand.Connection.Open();
            Adapter_Update.DeleteCommand.ExecuteNonQuery();
            Adapter_Update.DeleteCommand.Connection.Close();

            //根据已选课列表向数据库中插入选课记录
            int limit = dataSet11.Class_Selected.Count;
            Adapter_Update.InsertCommand.Connection.Open();
            Adapter_Update.InsertCommand.Parameters[0].Value = Convert.ToInt32(this.SID);
            for (int i=0;i<limit;i++)
            {
                String CID = dataSet11.Class_Selected[i]["Class_ID"].ToString();
                Adapter_Update.InsertCommand.Parameters[1].Value = Convert.ToInt32(CID);
                Adapter_Update.InsertCommand.ExecuteNonQuery();
            }
            Adapter_Update.InsertCommand.Connection.Close();

            //根据原提交状态判断是否要修改提交状态
            if (this.submited == 1)
            {
                Adapter_IsSubmited.DeleteCommand.Parameters[0].Value = Convert.ToInt32(this.SID);
                Adapter_IsSubmited.DeleteCommand.Connection.Open();
                Adapter_IsSubmited.DeleteCommand.ExecuteNonQuery();
                Adapter_IsSubmited.DeleteCommand.Connection.Close();
                this.submited = 0;
            }
            MessageBox.Show("保存成功", "提示");

            //刷新提交状态文本框内容
            Update_Text();
        }

        private void tbxStudentID_TextChanged(object sender, EventArgs e)
        {
            
            int temp;
            bool result = int.TryParse(tbxStudentID.Text, out temp);
            if (!result)
                return;
            this.SID = tbxStudentID.Text;
            //初始化数据表
            dataSet11.Clear();
            //获取姓名
            String strSelectName = "SELECT Name FROM Student WHERE Student_ID = " + this.SID;
            OleDbCommand cmdSelect = new OleDbCommand(strSelectName, this.oleDbConnection);
            this.oleDbConnection.Open();
            if (cmdSelect.ExecuteNonQuery() != -1)
            {
                this.oleDbConnection.Close();
                //清空文本框
                tbxStudentName.Text = "";
                tbxCredit.Text = "";
                tbxNumber.Text = "";
                tbxSubmited.Text = "";
                return;
            }
            this.SName = cmdSelect.ExecuteScalar().ToString();
            this.oleDbConnection.Close();
            tbxStudentName.Text = this.SName;

            //获取提交情况
            String strSelectSubmit = "SELECT Student_ID FROM Submited WHERE Student_ID = " + this.SID;
            cmdSelect = new OleDbCommand(strSelectSubmit, this.oleDbConnection);
            this.oleDbConnection.Open();
            if (cmdSelect.ExecuteNonQuery() != -1)
                this.submited = 0;
            else
                this.submited = 1;
            this.oleDbConnection.Close();
            

            //获取已选课程信息
            Adapter_Selected.SelectCommand.Parameters[0].Value = Convert.ToInt32(this.SID);
            Adapter_Selected.Fill(this.dataSet11);

            //获取可选课程信息
            Adapter_UnSelected.SelectCommand.Parameters[0].Value = Convert.ToInt32(this.SID);
            Adapter_UnSelected.Fill(this.dataSet11);

            Update_Text();
        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            //判断当前已选课程数和总学分是否符合要求
            if (this.number_selected < 3 || this.number_selected > 5 ||
                this.credit_selected < 8 || this.credit_selected > 12)
            {
                MessageBox.Show("不符合要求，提交失败", "提示");
                return;
            }

            //从数据库中删除原选课记录
            Adapter_Update.DeleteCommand.Parameters[0].Value = Convert.ToInt32(this.SID);
            Adapter_Update.DeleteCommand.Connection.Open();
            Adapter_Update.DeleteCommand.ExecuteNonQuery();
            Adapter_Update.DeleteCommand.Connection.Close();

            //根据已选课列表向数据库中插入选课记录
            int limit = dataSet11.Class_Selected.Count;
            Adapter_Update.InsertCommand.Connection.Open();
            Adapter_Update.InsertCommand.Parameters[0].Value = Convert.ToInt32(this.SID);
            for (int i = 0; i < limit; i++)
            {
                String CID = dataSet11.Class_Selected[i]["Class_ID"].ToString();
                Adapter_Update.InsertCommand.Parameters[1].Value = Convert.ToInt32(CID);
                Adapter_Update.InsertCommand.ExecuteNonQuery();
            }
            Adapter_Update.InsertCommand.Connection.Close();

            //根据原提交状态判断是否要修改提交状态
            if (this.submited==0)
            {
                Adapter_IsSubmited.InsertCommand.Parameters[0].Value = Convert.ToInt32(this.SID);
                Adapter_IsSubmited.InsertCommand.Connection.Open();
                Adapter_IsSubmited.InsertCommand.ExecuteNonQuery();
                Adapter_IsSubmited.InsertCommand.Connection.Close();
                this.submited = 1;
            }
            MessageBox.Show("提交成功", "提示");

            //刷新提交状态文本框内容
            Update_Text();
        }

        private void Update_Text()
        {
            //获取已选课程数
            this.number_selected = dataSet11.Class_Selected.Rows.Count;
            //获取已选课程学分
            object sumObject = dataSet11.Class_Selected.Compute("sum(Credit)", "True");
            if (sumObject == System.DBNull.Value)
                this.credit_selected = 0;
            else
                this.credit_selected = Convert.ToInt32(sumObject);
            //将课程数和课程学分显示到相应的文本框控件中
            tbxCredit.Text = this.credit_selected.ToString();
            tbxNumber.Text = this.number_selected.ToString();
            //根据变量submited值修改提交状态的文本框内容
            if (this.submited == 0)
                tbxSubmited.Text = "未提交";
            else
                tbxSubmited.Text = "已提交";
        }

    }
}
