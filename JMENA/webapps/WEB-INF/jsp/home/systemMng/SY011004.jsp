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
		var v_selectUserId = "";	//선택된 사용자
		
		$(document).ready(function(){
			f_selectSysMst();
			f_selectUserMst4();
			f_selectUserPgmAuthTb();
		});
		
		function f_selectSysMst() {
			//시스템 메뉴 호출 (SY011001 데이터 사용)
		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/selectListSysMst.do", 
				dataType : 'json' , 
				success: function(data){
					var inHtml = "";
					
					data.rows.forEach(function(currentValue, index, array){
						inHtml += "<option value='" + currentValue.SYSID + "'>" + currentValue.SYSNAME + "</option>\n";
					});
					
					$("#SYSIDCOMBO").append(inHtml);
					
					$("#SYSIDCOMBO").change();
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		$(function(){
			$("#SYSIDCOMBO").change(function() {
				$("#MENUIDCOMBO").empty().data('options');
				
				if ($(this).val() == "ALL") {
					var inHtml = "";
					
					inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
					
					$("#MENUIDCOMBO").append(inHtml);
					
					f_selectUserPgmAuthTb();	//그리드 가져오기
				} else {
					//메뉴 호출 (SY011001 데이터 사용)
					$.ajax({ 
						type: 'POST',
						data: "SYSID=" + $(this).val(),
						url: "/home/selectListSysDtl.do", 
						dataType : 'json' , 
						success: function(data){
							var inHtml = "";
							
							inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
							
							data.rows.forEach(function(currentValue, index, array){
								inHtml += "<option value='" + currentValue.MENUID + "'>" + currentValue.MENUNAME + "</option>\n";
							});
	
							$("#MENUIDCOMBO").append(inHtml);
							
							f_selectUserPgmAuthTb();	//그리드 가져오기
						},
						error:function(e){  
							alert("[ERROR]Menu Combo 호출 중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
		
		$(function(){
			$("#MENUIDCOMBO").change(function() {
				f_selectUserPgmAuthTb();
			});	
		})
	
		function f_selectUserMst4() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListUserMst4.do",
				postData : {
					USERGUBUN:$("input:radio[name=S_USERGUBUN]:checked").val(),
					USERNAME:$("#S_USERNAME").val()
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['사용자ID', '사용자명'] ,
				colModel:[
					{name:"USERID",			index:'USERID',		width:60,	align:'center', sortable:false}
					, {name:"USERNAME",		index:'USERNAME',	width:60,	align:'center', sortable:false}
				] ,
				rowNum:100,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'USERID' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(ids){
					var selRowData = $(this).jqGrid('getRowData', ids);
					
					v_selectUserId = selRowData.USERID;
					
					f_selectUserPgmAuthTb();
				} ,
				loadComplete: function() {
					v_selectUserId = "";	//초기화
					$("#SYSIDCOMBO").val("ALL").attr("selected", "selected").trigger("change");
					$('#rightList').jqGrid("clearGridData", true);
				},
				hidegrid: false
			});
		}
	
		function f_selectUserPgmAuthTb() {
			$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#rightList').jqGrid({
				url:"/home/selectListUserPgmAuthTb.do",
				postData : {
					USERID:v_selectUserId,SYSID:$("#SYSIDCOMBO option:selected").val(),MENUID:$("#MENUIDCOMBO option:selected").val()
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['시스템코드', '시스템 명', '메뉴코드', '메뉴 명', '프로그램ID', '프로그램 명', '조회', '입력', '수정', '삭제', '출력'] ,
				colModel:[
					  {name:"SYSID",		index:'SYSID',		width:60,		align:'center', sortable:false, hidden:true}
					, {name:"SYSNAME",		index:'SYSNAME',	width:60,		align:'center', sortable:false}
					, {name:"MENUID",		index:'MENUID',		width:60,		align:'center', sortable:false, hidden:true}
					, {name:"MENUNAME",		index:'MENUNAME',	width:60,		align:'center', sortable:false}
					, {name:"PGMID",		index:'PGMID',		width:60,		align:'center', sortable:false}
					, {name:"PGMNAME",		index:'PGMNAME',	width:60,		align:'center', sortable:false}
					, {name:"AUTH_S",		index:'AUTH_S',		width:60,		align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"AUTH_I",		index:'AUTH_I',		width:60,		align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"AUTH_U",		index:'AUTH_U',		width:60,		align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"AUTH_D",		index:'AUTH_D',		width:60,		align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"AUTH_P",		index:'AUTH_P',		width:60,		align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
				] ,
				rowNum:100,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'USERID' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(ids){
	
				} ,
				loadComplete: function() {
					
				},
				hidegrid: false
			});
		}
		
		$(function() {
			$("#selectButton").click(function() {
				f_selectUserMst4();
			});
		})
		
		function f_selectUserList() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#selectButton").click();
			}
		}
	</script>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td><a class="ui-button ui-widget ui-corner-all" id="selectButton" name="selectButton">조회</a></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>사용자구분</td>
					<td>
						<input type="radio" id="S_USERGUBUN" name="S_USERGUBUN" value="B" checked="checked" />일반사용자
						<input type="radio" id="S_USERGUBUN" name="S_USERGUBUN" value="A" />관리자
					</td>
				</tr>
				<tr>
					<td>사용자 명</td>
					<td><input type="text" id="S_USERNAME" name="S_USERNAME" onkeydown="f_selectUserList();"/></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>시스템구분</td>
					<td>
						<select id="SYSIDCOMBO" name="SYSIDCOMBO">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>메뉴구분</td>
					<td>
						<select id="MENUIDCOMBO" name="MENUIDCOMBO">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
			</table>
			<table id="rightList"></table>
		</div>
	</div>
</body>
</html>
