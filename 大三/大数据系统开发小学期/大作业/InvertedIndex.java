import java.util.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;
import org.apache.hadoop.hbase.mapreduce.TableReducer;
import org.apache.hadoop.hbase.util.Bytes;

public class InvertedIndex {
    //偏移量\文本\单词\文件编号
    static class MyMapper extends Mapper<LongWritable, Text, Text, Text> {
        String fileName = null;
        Text mk = new Text();  //map端输出的键
        Text mv = new Text();  //map端输出的值

        // 在setup中通过切片来获取文件名
        @Override
        protected void setup(Mapper<LongWritable, Text, Text, Text>.Context context)
                throws IOException, InterruptedException {
            FileSplit files = (FileSplit) context.getInputSplit();
            fileName = files.getPath().getName();
        }

        @Override
        //偏移量，字符串，暂存处理结果
        protected void map(LongWritable key, Text value, Mapper<LongWritable, Text, Text, Text>.Context context)
                throws IOException, InterruptedException {

            String[] datas = value.toString().split(" ");
            String line = datas[0];
            int line_num = Integer.parseInt(line);
            //文件编号
            int file_num = line_num / 100000 + 1;
            //map存储单词和出现次数
            Map<String, Integer> map = new HashMap<String, Integer>();
            //更新单词出现次数
            for (int i = 1; i < datas.length; i++) {
                String word = datas[i];
                if (map.containsKey(word))
                    map.put(word, map.get(word) + 1);
                else
                    map.put(word, 1);
            }
            //获取所有单词
            Set<String> keySet = map.keySet();
            for (String s : keySet) {
                mk.set(s);
                // 拼接信息，这里本来写入了文件名、行号和出现次数
                //但考虑到hbase写入内容的大小上限，仅写入单词出现的文件编号
            //    mv.set(fileName + ":" + line + "," + map.get(s));
                mv.set(Integer.toString(file_num));
                context.write(mk, mv);
            }

        }

    }


    static class MyReducer extends TableReducer<Text, Text, ImmutableBytesWritable> {
        Text rv = new Text();

        @Override
        protected void reduce(Text key, Iterable<Text> values, Context context)
                throws IOException, InterruptedException {
            // 用StringBuilde来进行拼接
            StringBuilder s = new StringBuilder();
            //存储该单次出现的所有文件的编号
            List<String> mylist = new ArrayList<>();
            for (Text v : values) {
                String str1 = v.toString();
                if (!mylist.contains(str1)) {
                    mylist.add(str1);
                }
            }
            for (String i : mylist) {
                s.append(i).append(",");
            }
            // 去掉最后一个符号
            rv.set(s.substring(0, s.length() - 1));

            //设置单次为Row Key 构建Put对象
            Put put = new Put(key.toString().getBytes());
            //指定插入的列族、列名和值
            put.addColumn("col_family".getBytes(), "info".getBytes(), rv.toString().getBytes());
            context.write(null, put);
        }

    }

    public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException {

        Configuration conf = new Configuration();
        conf = HBaseConfiguration.create(conf);

        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();

        Job job = Job.getInstance(conf);

        job.setJarByClass(InvertedIndex.class);

        job.setMapperClass(MyMapper.class);

        job.setReducerClass(MyReducer.class);

        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(Text.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        // 设置HBase表输出：表名，reducer类
        TableMapReduceUtil.initTableReducerJob("test_table", MyReducer.class, job);

        FileInputFormat.addInputPath(job, new Path(otherArgs[0]));

        job.waitForCompletion(true);
    }

}
