package network_lab2_DV;


//路由表项
public class RouterTable{
	public String DestNode;		//目标节点
	public double Distance;		//距离
	public String Neighbor;		//第一跳
	
	public void myclone(RouterTable r) {
		DestNode = r.DestNode;
		Distance = r.Distance;
		Neighbor = r.Neighbor;
	}
}