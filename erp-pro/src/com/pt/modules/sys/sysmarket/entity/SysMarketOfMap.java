package com.pt.modules.sys.sysmarket.entity;


public class SysMarketOfMap {
	private static final long serialVersionUID = 1L;
	private String name;
	private int value;
	
	public SysMarketOfMap() {
		super();
	}
	public SysMarketOfMap(String name) {
		super();
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	
	

}