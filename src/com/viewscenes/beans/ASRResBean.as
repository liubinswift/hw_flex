package com.viewscenes.beans
{
	/**
	 * 
	 * 语音识别返回对象类
	 * */
	[RemoteClass(alias="com.viewscenes.bean.ASRResBean")]
	public class ASRResBean
	{
		
		// 固定1
		public var  type:String = "";
		// 订单ID，即任务ID
		public var  orderID:String = "";
		// 结果类型: BC573
		public var  timePeriodType:String = "";
		// 停播、空播、话少
		public var  status:String = "";
		//执行状态
		public var taskStatus:String = "";
		//错误描述
		public var errorMessage:String = "";
		// 录音文件名称
		public var  file:String = "";
		
		//语音长度（秒）
		public var wavelen:String = "";
		
		//音乐比例
		public var musicratio:String = "";
		
		//噪声比例
		public var noiseratio:String = "";
		
		//话音长度（秒）
		public var speechlen:String = "";
		
		//总体置信度
		public var totalcm:String = "";
		
		// 文件开始时间
		public var  startTime:String = "";
		// 文件结束时间
		public var  endTime:String = "";
		// 可听度得分
		public var  audibilityScore:String = "";
		// 可听度置信度
		public var  audibilityConfidence:String = "";
		// 台名识别结果
		public var  channelName:String = "";
		// 台名识别置信度
		public var  channelNameConfidence:String = "";
		// 节目比对结果
		public var  programName:String = "";
		// 节目比对置信度
		public var  programNameConfidence:String = "";
		
		// 前5名语种识别结果及其置信度
		public var  languageName1:String = "";
		public var  languageName2:String = "";
		public var  languageName3:String = "";
		public var  languageName4:String = "";
		public var  languageName5:String = "";
		public var  languageConfidence1:String = "";
		public var  languageConfidence2:String = "";
		public var  languageConfidence3:String = "";
		public var  languageConfidence4:String = "";
		public var  languageConfidence5:String = "";
		
		public function ASRResBean()
		{
		}
	}
}