<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

</head>
<script type="text/javascript">
	$(document).ready(function(){
		
		//공통코드 가져오기
		f_selectListEnaCityCode();		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		f_selectEnaCode("007");
		f_selectEnaCode("008");
		f_selectEnaCode("013");
		//공통코드 가져오기 끝
		
	});


	$(function(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '수당관리'
			url:"/home/selectListEnaSudangMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['지급일', '담당자','담당자성명', '매출금액', '지급금액', '세액', '차감지급액','계약일자','번호','매출구분','계약지사','관리자번호',
			          '지역구분','주소','계약자성명','계약면적','계약평수','매매대금','매매단가','DC사항','DC율','DC금액','실판매가' ,
			          '수당지급율','추가지급율','신고기준','사업소득세','지방세','부가가치세','비고'],
			colModel:[
				 {name:"PAYDATE",		index:'PAYDATE',		width:60,		align:'center'}
				,{name:"SALERCD",		index:'SALERCD',		width:60,		align:'center'}
				,{name:"SALERNM",		index:'SALERNM',		width:60,		align:'center'}
				,{name:"SELLAMT",		index:'SELLAMT',		width:60,		align:'center'}
				,{name:"PAYAMT",		index:'PAYAMT',			width:60,		align:'center'}
				,{name:"TAXAMT",		index:'TAXAMT',			width:60,		align:'center'}
				,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:60,		align:'center'}
				,{name:"SALEDATE",		index:'SALEDATE',		width:60,		align:'center'}
				,{name:"SALEID",		index:'SALEID',			width:60,		align:'center', hidden:true}
				,{name:"SALEGUBUN",		index:'SALEGUBUN',		width:60,		align:'center', hidden:true}
				,{name:"BRANCHCODE",	index:'BRANCHCODE',		width:60,		align:'center', hidden:true}
				,{name:"MANAGENO",		index:'MANAGENO',		width:60,		align:'center', hidden:true}
				,{name:"CITYCODE",		index:'CITYCODE',		width:60,		align:'center', hidden:true}
				,{name:"ADDRESS",		index:'ADDRESS',		width:60,		align:'center', hidden:true}
				,{name:"CONNAME",		index:'CONNAME',		width:60,		align:'center', hidden:true}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center', hidden:true}
				,{name:"CONPY",			index:'CONPY',			width:60,		align:'center', hidden:true}
				,{name:"SALEAMT",		index:'SALEAMT',		width:60,		align:'center', hidden:true}
				,{name:"SALEDANGA",		index:'SALEDANGA',		width:60,		align:'center', hidden:true}
				,{name:"DCGUBUN",		index:'DCGUBUN',		width:60,		align:'center', hidden:true}
				,{name:"DCRATE",		index:'DCRATE',			width:60,		align:'center', hidden:true}
				,{name:"DCAMT",			index:'DCAMT',			width:60,		align:'center', hidden:true}
				,{name:"SELLAMT",		index:'SELLAMT',		width:60,		align:'center', hidden:true}				
				,{name:"SUDANGRATE",	index:'SUDANGRATE',		width:60,		align:'center', hidden:true}
				,{name:"ADDRATE",		index:'ADDRATE',		width:60,		align:'center', hidden:true}
				,{name:"TAXGUBUN",		index:'TAXGUBUN',		width:60,		align:'center', hidden:true}
				,{name:"TAXINCOME",		index:'TAXINCOME',		width:60,		align:'center', hidden:true}
				,{name:"TAXLOCAL",		index:'TAXLOCAL',		width:60,		align:'center', hidden:true}
				,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:60,		align:'center', hidden:true}
				,{name:"REMARK",		index:'REMARK',			width:60,		align:'center', hidden:true}	
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'sortKey' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#PAYDATE").val(selRowData.PAYDATE);
				$("#SALERCD").val(selRowData.SALERCD);
				$("#SALERCD1").val(selRowData.SALERCD);
				$("#SALERNM").val(selRowData.SALERNM);
				$("#SALEDATE").val(selRowData.SALEDATE);
				$("#SALEID").val(selRowData.SALEID);
				$("#SALEGUBUN").val(selRowData.SALEGUBUN);
				$("#BRANCHCODE").val(selRowData.BRANCHCODE);
				$("#MANAGENO").val(selRowData.MANAGENO);
				$("#CITYCODE").val(selRowData.CITYCODE);
				$("#ADDRESS").val(selRowData.ADDRESS);
				$("#CONNAME").val(selRowData.CONNAME);
				$("#CONM2").val(selRowData.CONM2);
				$("#CONPY").val(selRowData.CONPY);
				$("#SALEAMT").val(selRowData.SALEAMT);
				$("#SALEDANGA").val(selRowData.SALEDANGA);
				$("#DCGUBUN").val(selRowData.DCGUBUN);
				$("#DCRATE").val(selRowData.DCRATE);
				$("#DCAMT").val(selRowData.DCAMT);
				$("#SELLAMT").val(selRowData.SELLAMT);
				$("#SUDANGRATE").val(selRowData.SUDANGRATE);
				$("#ADDRATE").val(selRowData.ADDRATE);
				$("#TAXGUBUN").val(selRowData.TAXGUBUN);
				$("#TAXINCOME").val(selRowData.TAXINCOME);
				$("#TAXLOCAL").val(selRowData.TAXLOCAL);
				$("#SUPPLYTAX").val(selRowData.SUPPLYTAX);
				$("#PAYAMT").val(selRowData.PAYAMT);
				$("#DEDUCTAMT").val(selRowData.DEDUCTAMT);
				$("#REMARK").val(selRowData.REMARK);
			} ,
			hidegrid: false
		});

		
		$('#bottomList').jqGrid({
			//caption: '수당지급관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['직책', '직급', '성명', '수당지급율(%)', '추가지급율(%)', '지급금액', '신고기준', '사업소득세', '지방세', '부가가치세', '차감지급액', '신고인 수', '비고'] ,
			colModel:[  			          
				  {name:"GRADE",			index:'GRADE',		width:60,		align:'center'}
//				{name:"SYSID",			index:'SYSID',		width:60,		align:'center',  editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaBranchCode}}
				, {name:"DUTY",			index:'DUTY',		width:60,		align:'center'}
				, {name:"SALERNM",		index:'SALERNM',	width:60,		align:'center'}
				, {name:"SUDANGRATE",	index:'SUDANGRATE',	width:60,		align:'center'}
				, {name:"ADDRATE",		index:'ADDRATE',	width:60,		align:'center'}
				, {name:"PAYAMT",		index:'PAYAMT',		width:60,		align:'center'}
				, {name:"TAXGUBUN",		index:'TAXGUBUN',	width:60,		align:'center'}
				, {name:"TAXINCOME",	index:'TAXINCOME',	width:60,		align:'center'}
				, {name:"TAXLOCAL",		index:'TAXLOCAL',	width:60,		align:'center'}
				, {name:"SUPPLYTAX",	index:'SUPPLYTAX',	width:60,		align:'center'}
				, {name:"DEDUCTAMT",	index:'DEDUCTAMT',	width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"REMARK",		index:'REMARK',		width:60,		align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'SORTKEY' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
				alert(id);
			} ,
			hidegrid: false
		});
	});
	
	
	function f_selectListEnaCityCode(){
		$("#CITYCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/cityMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				data.cityMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.CITYCODE + "'>" + currentValue.CITYNAME + "</option>\n";
				});
				$("#CITYCODE").append(inHtml);				
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	   	
	}	
	
	
	function f_selectListEnaBranchCode(){
		$("#S_BRANCHCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/branchMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				data.branchMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.BRANCHCODE + "'>" + currentValue.BRANCHNAME + "</option>\n";
				});
				$("#S_BRANCHCODE").append(inHtml);
				$("#BRANCHCODE").append(inHtml);
				f_selectListEnaDeptCode();
				
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}	
	
	function f_selectListEnaDeptCode(){
		var BRANCHCODE = $("#S_BRANCHCODE").val();
		$("#S_DEPTCODE").empty().data('options');
		
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/deptMstList.do", 
			dataType : 'json' , 
			data : {
				BRANCHCODE : BRANCHCODE,
			},
			success: function(data){
				var inHtml = "";
				data.deptMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.DEPTCODE + "'>" + currentValue.DEPTNAME + "</option>\n";
				});				
				$("#S_DEPTCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	
	function f_selectEnaCode(CCODE){
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/dcodeList.do", 
			dataType : 'json' ,
			data : {
				CCODE : CCODE,
			},
			success: function(data){
				var inHtml = "";
				data.dcodeList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
				});
				if(CCODE == "007"){
					$("#SALEGUBUN").append(inHtml);					
				}else if(CCODE == "008"){
					$("#DCGUBUN").append(inHtml);	
				}else if(CCODE == "013"){
					$("#TAXGUBUN").append(inHtml);	
				}
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}	
		
</script>
<body>
<table width="99%">
	<tr>
		<td align="right">
			<table>
				<tr>
					<td><a class="ui-button ui-widget ui-corner-all" id="searchButton" name="searchButton">조회 </a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="addButton"    name="insertButton">추가 </a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="addButton"    name="deleteButton">삭제 </a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="saveButton"   name="saveButton">저장 </a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%" >
				<tr>
					<td>지급년월</td>
					<td colspan="3"><input type="text" id="S_SALEDATESYM" name="S_SALEDATESYM" /> ~ <input type="text" id="S_SALEDATEEYM" name="S_SALEDATEEYM" /></td>
				</tr>
				<tr>
					<td>지사</td>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
							<option></option>
						</select>
					</td>
					<td>부서</td>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>담당자</td>
					<td colspan="3">
						<input type="text" id="S_SALERCD" name="S_SALERCD" />
					</td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table >
				<tr>
					<td>계약일자/번호</td>
					<td colspan="3"><input type="text" id="SALEDATE" name="SALEDATE" />
					<input type="text" id="SALEID" name="SALEID" /><input type="button" id='saleButton'/></td>
				</tr>
				<tr>
					<td>매출구분</td>
					<td colspan="3">
						<select id="SALEGUBUN" name="SALEGUBUN">
						</select>
					</td>
				</tr>
				<tr>
					<td>담당자</td>
					<td><input type="text" id="SALERCD1" name="SALERCD1"/></td>
					<td>계약지사</td>
					<td>
						<select id="BRANCHCODE" name="BRANCHCODE">
						</select>
					</td>
				</tr>
				<tr>
					<td>관리번호</td>
					<td ><input type="text" id="MANAGENO" name="MANAGENO" /></td>
					<td>지역구분</td>
					<td>
						<select id="CITYCODE" name="CITYCODE">
						</select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<td>계약자 성명</td>
					<td colspan="3"><input type="text" id="CONNAME" name="CONNAME" /></td>
				</tr>
				<tr>
					<td>계약면적</td>
					<td><input type="text" id="CONM2" name="CONM2" /></td>
					<td>계약평수</td>
					<td><input type="text" id="CONPY" name="CONPY" /></td>
				</tr>
				<tr>
					<td>매매대금</td>
					<td><input type="text" id="SALEAMT" name="SALEAMT" /></td>
					<td>매매단가</td>
					<td><input type="text" id="SALEDANGA" name="SALEDANGA" /></td>
				</tr>
				<tr>
					<td>DC사항</td>
					<td>
						<select id="DCGUBUN" name="DCGUBUN">
						</select>
					</td>
					<td>DC 율</td>
					<td><input type="text" id="DCRATE" name="DCRATE" /> % </td>
				</tr>
				<tr>
					<td>DC금액</td>
					<td><input type="text" id="DCAMT" name="DCAMT" /></td>
					<td>실 판매가</td>
					<td><input type="text" id="SELLAMT" name="SELLAMT" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table >
				<tr>
					<th width="120">지급일자</th>
					<td><input type="text" id="PAYDATE" name="PAYDATE"> </td>
					<th width="120">담당자 성명</th>
					<td colspan="7"><input type="text" id="SALERCD" name="SALERCD"/>
						<input type="text" id="SALERNM" name="SALERNM"/></td>
				</tr>
				<tr>
					<th width="120">수당지급율(%)</th>
					<td ><input type="text" id="SUDANGRATE" name="SUDANGRATE" style="text-align:right;" /></td>
					<th width="120">추가지급율(%)</th>
					<td><input type="text" id="ADDRATE" name="ADDRATE" style="text-align:right;"/></td>
					<th width="120">지급금액</th>
					<td colspan="5"><input type="text" id="PAYAMT" name="PAYAMT" style="text-align:right;"/></td>
				</tr>
				<tr>
					<th width="120">신고기준</th>				
					<td><select id="TAXGUBUN" name="TAXGUBUN"></select>
					</td>
					<th width="120">사업소득세</th>
					<td><input type="text" id="TAXINCOME" name="TAXINCOME" style="text-align:right;"/></td>
					<th width="120">지방세</th>
					<td ><input type="text" id="TAXLOCAL" name="TAXLOCAL" style="text-align:right;"/></td>
					<th width="120">부가가치세</th>
					<td><input type="text" id="SUPPLYTAX" name="SUPPLYTAX" style="text-align:right;"/></td>
					<th width="120">차감지급액</th>
					<td><input type="text" id="DEDUCTAMT" name="DEDUCTAMT" style="text-align:right;"/></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="9"><input type="text" id="REMARK" name="REMARK"/></td>
				</tr>
			</table>
			<table id="bottomList"></table>
		</div>
	</div>
</body>
</html>