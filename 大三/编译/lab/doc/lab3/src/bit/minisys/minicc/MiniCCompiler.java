package bit.minisys.minicc;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringWriter;
import java.lang.reflect.Method;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.python.util.PythonInterpreter;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NameList;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.xml.sax.*;

import bit.minisys.minicc.icgen.internal.IRBuilder;
import bit.minisys.minicc.icgen.internal.MiniCCICGen;
import bit.minisys.minicc.internal.util.MiniCCUtil;
import bit.minisys.minicc.ncgen.internal.MiniCCCodeGen;
import bit.minisys.minicc.optimizer.internal.MiniCCOptimizer;
import bit.minisys.minicc.parser.internal.MiniCCParser;
import bit.minisys.minicc.pp.internal.MiniCCPreProcessor;
import bit.minisys.minicc.scanner.internal.MiniCCScanner;
import bit.minisys.minicc.semantic.internal.MiniCCSemantic;
import bit.minisys.minicc.simulator.*;


public class MiniCCompiler {
	MiniCCCfg pp = new MiniCCCfg();
	MiniCCCfg scanning = new MiniCCCfg();
	MiniCCCfg parsing = new MiniCCCfg();
	MiniCCCfg semantic = new MiniCCCfg();
	MiniCCCfg icgen = new MiniCCCfg();
	MiniCCCfg optimizing = new MiniCCCfg();
	MiniCCCfg codegen = new MiniCCCfg();
	MiniCCCfg simulating = new MiniCCCfg();
	
	private void readConfig() throws ParserConfigurationException, SAXException, IOException{
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse("./config.xml");

		NodeList nodeList = doc.getElementsByTagName("phase");
		for (int i = 0; i < nodeList.getLength(); i++){
			Element temp = (Element) nodeList.item(i);
			String name = temp.getAttribute("name");
			if(name.equals("preprocess")) {
				pp.type = temp.getAttribute("type");
				pp.path = temp.getAttribute("path");
				pp.skip = temp.getAttribute("skip");

			}
			else if(name.equals("scan")) {
				scanning.type = temp.getAttribute("type");
				scanning.path = temp.getAttribute("path");
				scanning.skip = temp.getAttribute("skip");
				
			}
			else if(name.equals("parse")) {
				parsing.type = temp.getAttribute("type");
				parsing.path = temp.getAttribute("path");
				parsing.skip = temp.getAttribute("skip");
			}
			else if(name.equals("semantic")) {
				semantic.type = temp.getAttribute("type");
				semantic.path = temp.getAttribute("path");
				semantic.skip = temp.getAttribute("skip");
			}
			else if(name.equals("icgen")) {
				icgen.type = temp.getAttribute("type");
				icgen.path = temp.getAttribute("path");
				icgen.skip = temp.getAttribute("skip");
			}
			else if(name.equals("optimize")) {
				optimizing.type = temp.getAttribute("type");
				optimizing.path = temp.getAttribute("path");
				optimizing.skip = temp.getAttribute("skip");
			}
			else if(name.equals("ncgen")) {
				codegen.type = temp.getAttribute("type");
				codegen.path = temp.getAttribute("path");
				codegen.skip = temp.getAttribute("skip");
				codegen.target = temp.getAttribute("target");
				codegen.ra = temp.getAttribute("ra");
			}
			else if(name.equals("simulate")) {
				//InterVars.goalAsm = temp.getAttribute("type");
				//InterVars.level = temp.getAttribute("level");
			}
		}
	}
	
	public void run(String cFile) throws Exception{
		
		String filename = cFile;
		
		readConfig();
		
		// step 1: preprocess
		if(pp.skip.equals("false")){
			if(pp.type.equals("java")){
				if(!pp.path.equals("")){
					Class<?> c = Class.forName(pp.path);
					Method method = c.getMethod("run", String.class);
					filename = (String)method.invoke(c.newInstance(), filename);
				}else{
					MiniCCPreProcessor prep = new MiniCCPreProcessor();
					filename = prep.run(cFile);
				}
			}else {
				String ppOutFile = cFile.replace(MiniCCCfg.MINICC_PP_INPUT_EXT, MiniCCCfg.MINICC_PP_OUTPUT_EXT);
				if(pp.type.equals("python")){
					this.runPy(cFile, ppOutFile, pp.path);
				} else {
					this.run(cFile, ppOutFile, pp.path);
				}
				filename = ppOutFile;
			}
		}else{
			ArrayList<String> content = MiniCCUtil.readFile(cFile);
			String ppOutFile = cFile.replace(MiniCCCfg.MINICC_PP_INPUT_EXT, MiniCCCfg.MINICC_PP_OUTPUT_EXT);
			String src = "";
			for(String s: content) {
				src += s + "\n";
			}
			MiniCCUtil.createAndWriteFile(ppOutFile, src);
		}
		
		// step 2: scan
		if(scanning.skip.equals("false")){
			if(scanning.type.equals("java")){
				if(!scanning.path.equals("")){
					Class<?> c = Class.forName(scanning.path);
					Method method = c.getMethod("run", String.class);
					filename = (String)method.invoke(c.newInstance(), filename);
				}else{
					MiniCCScanner sc = new MiniCCScanner();
					filename = sc.run(filename);
				}
			}else {
				String scOutFile = filename.replace(MiniCCCfg.MINICC_SCANNER_INPUT_EXT, MiniCCCfg.MINICC_SCANNER_OUTPUT_EXT);
				if(scanning.type.equals("python")){
					this.runPy(filename, scOutFile, scanning.path);
				}else {
					this.run(filename, scOutFile, scanning.path);
				}
				filename = scOutFile;
			}
		}
		
		// step 3: parser
		if(parsing.skip.equals("false")){
			if(parsing.type.equals("java")){
				if(!parsing.path.equals("")){
					Class<?> c = Class.forName(parsing.path);
					Method method = c.getMethod("run", String.class);
					filename = (String)method.invoke(c.newInstance(), filename);
				}else{
					MiniCCParser p = new MiniCCParser();
					filename = p.run(cFile);	// internal ANTLR parser uses .c as input, and output ast.json
				}
			}else {
				String pOutFile = filename.replace(MiniCCCfg.MINICC_SCANNER_OUTPUT_EXT, MiniCCCfg.MINICC_PARSER_OUTPUT_EXT);
				if(parsing.type.equals("python")){
					this.runPy(filename, pOutFile, parsing.path);
				} else {
					this.run(filename, pOutFile, parsing.path);
				}
				filename = pOutFile;
			}
		}
		
		// step 4: semantic
		if(semantic.skip.equals("false")){
			if(semantic.type.equals("java")){
				if(!semantic.path.equals("")){
					Class<?> c = Class.forName(semantic.path);
					Method method = c.getMethod("run", String.class);
					filename = (String)method.invoke(c.newInstance(), filename);
				}else{
					MiniCCSemantic se = new MiniCCSemantic();
					filename = se.run(filename);
				}
			}else {
				String seOutFile = filename.replace(MiniCCCfg.MINICC_PARSER_OUTPUT_EXT, MiniCCCfg.MINICC_SEMANTIC_OUTPUT_EXT);
				if(semantic.type.equals("python")){
					this.runPy(filename, seOutFile, semantic.path);
				}else{
					this.run(filename, seOutFile, semantic.path);
				}
				filename = seOutFile;
			}
		}

		// step 5: intermediate code generate
		if(icgen.skip.equals("false")){
			if(icgen.type.equals("java")){
				if(!icgen.path.equals("")){
					Class<?> c = Class.forName(icgen.path);
					Method method = c.getMethod("run", String.class);
					filename = (String)method.invoke(c.newInstance(), filename);
				}else{
					MiniCCICGen ic = new MiniCCICGen();
					filename = ic.run(filename);
				}
			}else {
				String icOutFile = filename.replace(MiniCCCfg.MINICC_SEMANTIC_OUTPUT_EXT, MiniCCCfg.MINICC_ICGEN_OUTPUT_EXT);
				if(icgen.type.equals("python")){
					this.runPy(filename, icOutFile, icgen.path);
				} else {
					this.run(filename, icOutFile, icgen.path);
				}
				filename = icOutFile;
			}
		}
		
		// step 6: optimization
		if(optimizing.skip.equals("false")){
			if(optimizing.type.equals("java")){
				if(!optimizing.path.equals("")){
					Class<?> c = Class.forName(optimizing.path);
					Method method = c.getMethod("run", String.class);
					filename = (String)method.invoke(c.newInstance(), filename);
				}else{
					MiniCCOptimizer o = new MiniCCOptimizer();
					filename = o.run(filename);
				}
			}else {
				String oOutFile = filename.replace(MiniCCCfg.MINICC_ICGEN_OUTPUT_EXT, MiniCCCfg.MINICC_OPT_OUTPUT_EXT);
				if(optimizing.type.equals("python")){
					this.runPy(filename, oOutFile, optimizing.path);
				} else {
					this.run(filename, oOutFile, optimizing.path);
				}
				filename = oOutFile;
			}
		}

		// step 7: code generate
		if(codegen.skip.equals("false")){
			if(codegen.type.equals("java")){
				if(!codegen.path.equals("")){
					Class<?> c = Class.forName(codegen.path);
					Method method = c.getMethod("run", String.class, MiniCCCfg.class);
					filename = (String)method.invoke(c.newInstance(), filename, codegen);
				}else{
					MiniCCCodeGen g = new MiniCCCodeGen();
					filename = g.run(filename, codegen);
				}
			}else {
				String cOutFile = filename.replace(MiniCCCfg.MINICC_OPT_OUTPUT_EXT, MiniCCCfg.MINICC_CODEGEN_OUTPUT_EXT);
				if(codegen.type.equals("python")){
					this.runPy(filename, cOutFile, codegen.path);
				} else {
					this.run(filename, cOutFile, codegen.path);
				}
				filename = cOutFile;
			}
		}
		
		// step 8: simulation
		if(codegen.skip.equals("false")){
			if(codegen.target.equals("mips")){
				MIPSSimulator ms = new MIPSSimulator();
				ms.run(filename);
			}else if(codegen.target.equals("riscv")) {
				RISCVSimulator rs = new RISCVSimulator();
				rs.run(filename);
			}
		}
		
	}
	
	private void run(String iFile, String oFile, String path) throws IOException{
		//Runtime rt = Runtime.getRuntime();//鏍煎紡锛歟xe鍚� 杈撳叆鏂囦欢 杈撳嚭鏂囦欢
		ProcessBuilder pb = new ProcessBuilder(path, iFile, oFile);
		
		pb.redirectErrorStream(true);
		pb.redirectOutput(ProcessBuilder.Redirect.INHERIT);
		Process p = pb.start();
		
		try {
			p.waitFor();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	private void runPy(String iFile, String oFile, String path) throws IOException{
		PythonInterpreter pyi = new PythonInterpreter();//鏍煎紡锛歅ython鑴氭湰鍚� 杈撳叆鏂囦欢 杈撳嚭鏂囦欢
		// DIRTY HACK! Apparently the retard who wrote this before don't know how to google.
		pyi.exec("import sys\nsys.argv = ['<string>', \"" + MiniCCUtil.escape(iFile) + "\", \"" + MiniCCUtil.escape(oFile) + "\"]");
		pyi.setOut(System.out);
		pyi.execfile(path);
		pyi.cleanup();
		return;
	}
}
