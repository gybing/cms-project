package com.cms.common.exception;

/**
 * @author lansb
 * user defined exception
 */
public class CustomException extends Exception {

	/**
	 * 域 <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 1L;
	public CustomException() {
		super();
	}

	public CustomException(String s) {
		super(s);
	}

}
