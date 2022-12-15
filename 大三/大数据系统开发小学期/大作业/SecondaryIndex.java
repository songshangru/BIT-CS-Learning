import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class SecondaryIndex {

    private static class SecondaryIndexMapper extends Mapper<LongWritable, Text,Text,Text> {

        Text mapKeyOut = new Text();
        Text mapValueOut = new Text();

        @Override
        protected void map(LongWritable key, Text value, Mapper<LongWritable, Text, Text, Text>.Context context)
                throws IOException, InterruptedException {
            //将一行数据以空格为分隔符读入datas
            String[] datas = value.toString().split(" ");
            //datas中第一个元素即是该行的最前面的单词
            String word = datas[0];

            //输出key设置为目标单词，输出value设置为行数
            mapKeyOut.set(word);
            mapValueOut.set(key.toString());
            context.write(mapKeyOut,mapValueOut);
        }
    }

    private static class SecondaryIndexReducer
            extends Reducer<Text, Text, Text,Text> {
        @Override
        protected void reduce(Text key, Iterable<Text> values, Reducer<Text, Text, Text, Text>.Context context) throws IOException, InterruptedException {
            super.reduce(key, values, context);
        }
    }

    public static void main(String[] args)
            throws IOException, ClassNotFoundException, InterruptedException{
        //获取conf
        Configuration conf = new Configuration();
        //创建job对象
        Job job = Job.getInstance(conf, "SecondaryIndex");
        //指定Jar包主类
        job.setJarByClass(SecondaryIndex.class);
        //设置mapper类
        job.setMapperClass(SecondaryIndexMapper.class);
        //设置Combiner类，一般设定为Reducer类
        job.setCombinerClass(SecondaryIndexReducer.class);
        //设置Reducer类
        job.setReducerClass(SecondaryIndexReducer.class);
        //设置输出key类型
        job.setOutputKeyClass(Text.class);
        //设置输出value类型
        job.setOutputValueClass(Text.class);
        //设置文件输入路径
        FileInputFormat.addInputPath(job, new Path(args[0]));
        //设置文件输出路径
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        //提交作业
        job.waitForCompletion(true);
    }

}