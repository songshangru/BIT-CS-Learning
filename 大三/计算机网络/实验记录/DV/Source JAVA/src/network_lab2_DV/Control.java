package network_lab2_DV;

import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.net.DatagramPacket;

import javax.swing.JFrame;
import javax.swing.KeyStroke;


//循环接收消息的线程类
public class Control extends Thread implements KeyListener {
    @Override
    public void keyPressed(KeyEvent e) {
        //按下某个键时调用此方法
    	if (e.getKeyCode() == KeyEvent.VK_P) {
			Main.pause = true;
		}
    	if (e.getKeyCode() == KeyEvent.VK_S) {
    		Main.pause = false;
		}
    	if (e.getKeyCode() == KeyEvent.VK_K) {
    		System.exit(0);
		}    	
    }
 
    @Override
    public void keyReleased(KeyEvent e) {
        //释放某个键时调用此方法
    }
 
    @Override
    public void keyTyped(KeyEvent e) {
        //键入某个键时调用此方法
    }

    public void run() {
		JFrame jf = new JFrame("MyListener");
		jf.addKeyListener(new Control());
		jf.setBounds(300,300,800,600);
		jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		jf.setVisible(true);
	}
}
