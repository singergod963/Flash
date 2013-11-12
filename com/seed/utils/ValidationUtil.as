package com.seed.utils
{
	//import fl.controls.RadioButtonGroup;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	/**
	 * @author simon
	 */
	public class ValidationUtil
	{
		public function ValidationUtil()
		{
		}


		/*驗證姓名*/
		public static function isName(name : String) : Boolean
		{
			if (name == "")
			{
				Utils.alert("請輸入姓名");
				return false;
			}
			return true;
		}

		/*驗證暱稱*/
		public static function isNickname(userNickname : String) : Boolean
		{
			if (userNickname == "")
			{
				Utils.alert("請輸入暱稱");
				return false;
			}
			return true;
		}

		/*驗證姓別*/
		/*public static function isSex(userSex : RadioButtonGroup) : Boolean
		{
			if (userSex.selectedData == null)
			{
				Utils.alert("請選擇性別");
				return false;
			}
			return true;
		}

		/*驗證EDM*/
		/*public static function isEDM(userEDM : RadioButtonGroup) : Boolean
		{
			if (userEDM.selectedData == null)
			{
				Utils.alert("請選擇是否收到相關訊息");
				return false;
			}
			return true;
		}

		/*驗證身份證*/
		public static function isTwID(userTwID : String) : Boolean
		{
			var letters:Array =  new Array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'X', 'Y', 'W', 'Z', 'I', 'O');
			var multiply:Array = new Array(1, 9, 8, 7, 6, 5, 4, 3, 2, 1);
			var nums:Array = new Array(2);
			var firstChar:String;
            var firstNum:int;
            var lastNum:int;
            var total:int = 0;
			
			var reg:RegExp = /^[a-z](1|2)\d{8}$/i;
			if (reg.exec(userTwID) == null) {
				Utils.alert("身分證字號格式不正確！");
				return false;
			}
			
			firstChar = userTwID.charAt(0).toUpperCase();
			lastNum = int(userTwID.charAt(9));
			for (var i:int = 0; i < 26; i++) {
				if (firstChar == letters[i]) {
					firstNum = i + 10;
					nums[0] = Math.floor(firstNum / 10);
                    nums[1] = firstNum - (nums[0] * 10);
                    break;
				}
			}
			
			for (i = 0; i < multiply.length; i++) {
                if (i < 2)
                    total += nums[i] * multiply[i];
                else
                    total += parseInt(userTwID.charAt(i - 1)) * multiply[i];
            }
            if ((10 - (total % 10)) != lastNum) {
				Utils.alert("身分證字號格式不正確！");
				return false;
			}
			return true;
		}

		/*驗證電話*/
		public static function isTel(userTel : String) : Boolean
		{
			if (userTel.length < 5)
			{
				Utils.alert("電話字數太少！\\n (格式範例:02-23333333 或 0933-000000)");
				return false;
			}
			return true;
		}


		/*驗證手機*/
		public static function isMobile(userTel : String) : Boolean
		{
			if (userTel.length < 10)
			{
				Utils.alert("手機字數太少！\\n (格式範例:0968000000 )");
				return false;
			}
			return true;
		}

		/*驗證電子信箱*/
		public static function isEmail(email : String) : Boolean
		{
			var reg:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			if (reg.exec(email) == null) {
				Utils.alert("Email格式不正確！");
				return false;
			}
			return true;
		}


		/*驗證地址*/
		public static function isAddress(userAddress1 : String, userAddress2 : String, userAddress3 : String) : Boolean
		{
			if (userAddress1 == "")
			{
				Utils.alert("請選擇縣市！");
				return false;
			}
			else
			{
				if (userAddress2 == "")
				{
					Utils.alert("請選擇鄉鎮市區！");
					return false;
				}
				else
				{
					if (userAddress3.length < 4)
					{
						Utils.alert("請填寫正確地址！");
						return false;
					}
				}
			}
			return true;
		}


		/*驗證生日*/
		public static function isBirthDay(userUYear : String, userUMonth : String, userUDay : String) : Boolean
		{
			if (userUYear == "")
			{
				Utils.alert("請選擇出生年！");
				return false;
			}
			else
			{
				if (userUMonth == "")
				{
					Utils.alert("請選擇出生月份！");
					return false;
				}
				else
				{
					if (userUDay == "")
					{
						Utils.alert("請選擇出生日期！");
						return false;
					}
				}
			}
			return true;
		}

		/*驗證發票*/
		public static function isInvoice(invoice : String) : Boolean
		{
			if (invoice == "")
			{
				Utils.alert("請填寫發票號碼！");
				return false;
			}
			var reg : RegExp = /[A-Za-z][A-Za-z][0-9]{8}/;
			if (!reg.test(invoice))
			{
				Utils.alert("發票號碼不正確！");
				return false;
			}
			if (invoice.length > 10)
			{
				Utils.alert("發票號碼不正確！");
				return false;
			}
			return true;
		}
	}
}
