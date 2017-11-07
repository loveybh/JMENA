<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

<script type="text/javascript">
	var DeptCode = "";
	var v_rightLastSel = 0;
	
	$(document).ready(function(){
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#rightInsertButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#rightSaveButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		
		$("#searchButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
		
		f_selectListEnaBranchMst();
		f_selectListEnaDeptMst();
	});
		

	function f_selectListEnaBranchMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		
		$('#leftList').jqGrid({
			//caption: '지사및부서관리'
			url:"/home/selectListEnaBranchMst.do" ,
			datatype:"json" ,
			mtype: 'POST',
			postData : {
				BRANCHNAME : $("#LS_BRANCHNAME").val()
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['지사코드', '지사 명', '사용여부'] ,
			colModel:[
				{name:"BRANCHCODE",			index:'BRANCHCODE',		width:60,		align:'center'}
				, {name:"BRANCHNAME",		index:'BRANCHNAME',		width:60,		align:'center'}
				, {name:"USEYN",			index:'USEYN',			width:60,		align:'center'}
			] ,
			rowNum:100 ,
			autowidth: true ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//height: '100%',
			jsonReader: {
				repeatitems: false
			},
			onSelectRow: function(ids){
				$("#S_FLAG_L").val("U");
				
				var selRowData = $(this).jqGrid('getRowData', ids);
									
				$("#RS_BRANCHCODE").val(selRowData.BRANCHCODE);
				$("#RS_BRANCHNAME").val(selRowData.BRANCHNAME);
				$("#RS_USEYN").val(selRowData.USEYN);
					
				f_selectListEnaDeptMst();
			},
			loadComplete: function() {
				v_rightLastSel = 0;
				
				var branchCode = $("#RS_BRANCHCODE").val();
				
				var ids = jQuery("#leftList").jqGrid('getDataIDs');
				
				ids.some(function(currentValue, index, array){
					var cellData = $("#leftList").jqGrid('getCell', ids[index], 'BRANCHCODE');
					if (cellData == branchCode) {
						$("#S_FLAG_L").val("U");
						$("#RS_BRANCHCODE").prop("disabled", true);
		        		$("#leftList").jqGrid('setSelection', ids[index]);
		    			return true;
		        	} else {
		        		$("#S_FLAG_L").val("I");
		        	}	        
				});
			},
			hidegrid: false
		});

	}
	
	function f_selectListEnaDeptMst(){
		$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#rightList').jqGrid({
			//caption: '지사및부서관리'
			url:"/home/selectListEnaDeptMst.do" ,
			datatype:"json" ,
			postData : {
				BRANCHCODE : $("#RS_BRANCHCODE").val()
			},
			mtype: 'POST',
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['부서코드', '부서명', '부서구분', '정렬순서', '사용여부', '비고'] ,
			colModel:[
				{name:"DEPTCODE",		index:'DEPTCODE',	width:60,	align:'center', editable:true}
				, {name:"DEPTNAME",		index:'DEPTNAME',	width:60,	align:'center', editable:true}
				, {name:"DEPTGUBUN",	index:'DEPTGUBUN',	width:60,	align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=001", buildSelect:selectListEnaDeptCode} }
				, {name:"SORTKEY",		index:'SORTKEY',	width:60,	align:'center', editable:true}
				, {name:"USEYN",		index:'USEYN',		width:60,	align:'center', editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"} }
				, {name:"REMARK",		index:'REMARK',		width:60,	align:'center', editable:true}
			] ,
			
			
			rowNum:100 ,
			autowidth: true ,
			//rowList:[10,20,30] ,
			sortname: 'DEPTCODE' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//height: '100%' ,
			jsonReader: {
				repeatitems: false
			},
			onSelectRow : function(id) {
				if (id > 0) {
					$("#S_FLAG_R").val("U");
				} else {
					$("#S_FLAG_R").val("I");
				}
				
				if( v_rightLastSel != id ){
			        $(this).jqGrid('restoreRow',v_rightLastSel,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
			        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

			        v_rightLastSel = id;
				}
			},
			loadComplete: function() {
				
			},			
			hidegrid: false
		});
	}
	
	function selectListEnaDeptCode(data){
		var jsonValue = $.parseJSON(data).dcodeList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
		});
		
		result +="</select>";

		return result;
	   	
	}
	
	$(function(){
		$("#selectButton").click(function(){
			$("#RS_BRANCHCODE").prop("disabled", false);
			$("#RS_BRANCHCODE").val("");
			$("#RS_BRANCHNAME").val("");
			$("#RS_USEYN").val("Y");
			
			$('#rightList').jqGrid('clearGridData');
			
			f_selectListEnaBranchMst();
		}) 
	})
	
	function f_selectBranchMst() {
		var keyCode = window.event.keyCode;
		if(keyCode==13) {
			$("#selectButton").click();
		}
	}
	
	$(function() {
		$("#searchButton").click(function() {
			if( $("#RS_BRANCHCODE").val() == "") {
				alert("지사코드를 입력하셔야 합니다."); 
				$("#RS_BRANCHCODE").focus();
				 
				 return false;
			}
			
			$("#LS_BRANCHNAME").val("");
			$("#RS_BRANCHCODE").prop("disabled", false);
			$("#RS_BRANCHNAME").val("");
			$("#RS_BRANCHNAME").focus();
			$("#RS_USEYN").val("Y");
			
			$('#rightList').jqGrid('clearGridData');
			
			f_selectListEnaBranchMst();
		});
	})
	
	function f_searchBranchCode() {
		var keyCode = window.event.keyCode;
		if(keyCode==13) {
			$("#searchButton").click();
		}
	}

	$(function() {
		$("#insertButton").click(function() {
			$("#LS_BRANCHNAME").val("");
			$("#RS_BRANCHCODE").prop("disabled", false);
			$("#RS_BRANCHCODE").val("");
			$("#RS_BRANCHNAME").val("");
			$("#RS_USEYN").val("Y");
			
			$("#RS_BRANCHCODE").focus();
			
			$('#rightList').jqGrid('clearGridData');
			
			f_selectListEnaBranchMst();
		});
	})
	
	$(function() {
		$("#saveButton").click(function() {
			if($("#RS_BRANCHCODE").val() == ""){
				alert("지사코드를 입력하세요.");
				$("#RS_BRANCHCODE").focus();
				return false;
			}
			
			if($("#RS_BRANCHNAME").val() == ""){
				alert("지사명을 입력하세요.");
				$("#RS_BRANCHNAME").focus();
				return false;
			}
			
			var msg = "";
			if ($("#S_FLAG_L").val() == "I") {
				msg = "저장하시겠습니까?";
			} else {
				msg = "수정하시겠습니까?"
			}
			if (confirm(msg) == true) {
				$("#RS_BRANCHCODE").prop("disabled", false);
				
				$.ajax({ 
					type: 'POST' ,
					data: $("#SY021002").serialize(),
					url: "/home/insertEnaBranchMst.do", 
					dataType : 'json' , 
					success: function(data){
						$("#S_FLAG_L").val("U");
						
						alert(data.resultMsg);
						
						$("#searchButton").click();
					},
					error:function(e){  
						alert("[ERROR]프로그램 저장  중 오류가 발생하였습니다.");
					}  
				});
			}
		});
	})
	
	function f_saveBranchCode() {
		var keyCode = window.event.keyCode;
		if(keyCode==13) {
			$("#saveButton").click();
		}
	}

	$(function() {
		$("#rightInsertButton").click(function() {
			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("선택된 지사가 없습니다.");
				
				return false;
			}
			
			$("#S_FLAG_R").val("I");
			
			$("#rightList").jqGrid("addRow", 0);
		});
	})

	$(function() {
		$("#rightSaveButton").click(function() {
			var ids = $("#rightList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}
			
			//jqGrid SelectBox 는 뷰 모드 전에 값을 가져옴.
			var deptGubun = $("#rightList [name=DEPTGUBUN] option:selected").val();
			
			 
			$('#rightList').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경

			var cellData = $("#rightList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기

			if (cellData.DEPTCODE == "") {
				alert("부서 코드를 입력하셔야 합니다.");
				
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"_DEPTCODE").focus();
				
				return false;
			}
			
			if (cellData.DEPTNAME == "") {
				alert("부서 명을 입력하셔야 합니다.");
				
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"_DEPTNAME").focus();
				
				return false;
			}
			
			if (cellData.SORTKEY == "") {
				alert("정렬 순서를 입력하셔야 합니다.");
				
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"_SORTKEY").focus();
				
				return false;
			}
			
			var msg = "";
			if ($("#S_FLAG_R").val() == "I") {
				msg = "저장하시겠습니까?";
			} else {
				msg = "수정하시겠습니까?"
			}

			if (confirm(msg) == true) {
				var formData = "S_FLAG_R=" + $("#S_FLAG_R").val() + 
				               "&BRANCHCODE=" + $("#RS_BRANCHCODE").val() + 
				               "&DEPTCODE=" + cellData.DEPTCODE + 
				               "&DEPTNAME=" + cellData.DEPTNAME + 
				               "&DEPTGUBUN=" + deptGubun + 
				               "&SORTKEY=" + cellData.SORTKEY +
				               "&USEYN=" + cellData.USEYN + 
				               "&REMARK=" + cellData.REMARK;
				               
				
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/insertEnaDeptMst.do", 
					dataType : 'json' , 
					success: function(data){
						$("#S_FLAG_R").val("U");
						
						v_rightLastSel = 0;
						
						alert(data.resultMsg);
						
						$("#searchButton").click();
					},
					error:function(e){  
						alert("[ERROR]부서 정보 처리  중 오류가 발생하였습니다.");
					}  
				});
			} else {
				v_rightLastSel = 0;
				$("#searchButton").click();
			}
		});
	})
	
	
</script>
</head>
<body>
	<div id="TEST"></div>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id='selectButton' /></td>
					<td><input type="button" value="추가" id='insertButton' /></td>
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>지사명</td>
					<td><input type="text" id="LS_BRANCHNAME" name="LS_BRANCHNAME" onkeydown="f_selectBranchMst();"/></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<form id="SY021002">
				<input type="hidden" id="S_FLAG_L" name="S_FLAG_L" />
				<table class="blueone">
					<tr>
						<td>지사코드</td>
						<td><input type="text" id="RS_BRANCHCODE" name="RS_BRANCHCODE" onkeydown="f_searchBranchCode();"/></td>
						<td><input type="button" id='searchButton' /></td>
					</tr>
					<tr>
						<td>지사명</td>
						<td><input type="text" id="RS_BRANCHNAME" name="RS_BRANCHNAME" onkeydown="f_saveBranchCode();" /></td>
					</tr>
					<tr>
						<td>사용여부</td>
						<td>
							<select id="RS_USEYN" name="RS_USEYN" style="width:50px;">
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</td>
					</tr>
				</table>
			</form>
			<input type="hidden" id="S_FLAG_R" name="S_FLAG_R" />
			<div style="width:96%; float:left; padding: 10px" align="left">
				<table align="right">
					<tr>
						<td><input type="button" value="추가" id='rightInsertButton' /></td>
						<td><input type="button" value="저장" id='rightSaveButton' /></td>
					</tr>
				</table>
			</div>
			<div id="rightDiv2" style="width:96%; float:left; padding: 10px" align="left">
				<table id="rightList"></table>
			</div>
		</div>
	</div>
</body>
</html>