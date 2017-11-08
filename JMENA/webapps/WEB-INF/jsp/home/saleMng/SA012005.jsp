<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>


<script type="text/javascript">
	$(document).ready(function(){
		
		var S_IPGUMDATE_FR = "";
		var S_IPGUMDATE_TO = "";
		var S_BRANCHCODE = "";
		var S_SALERCD = "";
		var S_IPGUMGUBUN = "";
		var S_IPGUMPERSON = "";
		var S_IPGUMAMT = "";

		$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		
		f_selectListEnaBranchCode();
		f_selectListEnaSalerCode();
		f_selectListEnaIpgumGubunCode();
		
		f_selectListSA012005(S_IPGUMDATE_FR, S_IPGUMDATE_TO, S_BRANCHCODE, S_SALERCD, S_IPGUMGUBUN, S_IPGUMPERSON, S_IPGUMAMT);
		
	});
	
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
				f_selectListEnaSalerCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	$(function(){
		$("#S_BRANCHCODE").change(function() {
			f_selectListEnaSalerCode();
		});
	});
	
	function f_selectListEnaSalerCode(){
		
		var BRANCHCODE = $("#S_BRANCHCODE").val();
		$("#S_SALERCD").empty().data('options');
		
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/insaMstList.do", 
			dataType : 'json' , 
			data : {
				BRANCHCODE : BRANCHCODE,
			},
			success: function(data){
				var inHtml = "";
				data.insaMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.INSACODE + "'>" + currentValue.KNAME + "</option>\n";
				});
				$("#S_SALERCD").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaIpgumGubunCode(){
		var CCODE = "009";
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
				$("#S_IPGUMGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListSA012005(S_IPGUMDATE_FR, S_IPGUMDATE_TO, S_BRANCHCODE, S_SALERCD, S_IPGUMGUBUN, S_IPGUMPERSON, S_IPGUMAMT){
		var url = "/home/selectListSA012005.do?S_IPGUMDATE_FR=" + S_IPGUMDATE_FR + "&S_IPGUMDATE_TO=" + S_IPGUMDATE_TO + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_SALERCD=" + S_SALERCD + "&S_IPGUMGUBUN=" + S_IPGUMGUBUN + "&S_IPGUMPERSON=" + S_IPGUMPERSON + "&S_IPGUMAMT=" + S_IPGUMAMT;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"IPGUMDATE",		type: 'string' },
				{name:"IPGUMID",		type: 'string' },
				{name:"IPGUMGUBUN",		type: 'string' },
				{name:"IPGUMPERSON",	type: 'string' },
				{name:"IPGUMAMT",		type: 'string' },
				{name:"SUMSUGUMAMT",	type: 'string' },
				{name:"JANGUMAMT",		type: 'string' },
				{name:"SEQ",			type: 'string' },
				{name:"SALEDATE",		type: 'string' },
				{name:"SALEID",			type: 'string' },
				{name:"CONNAME",		type: 'string' },
				{name:"CONM2",			type: 'string' },
				{name:"CONPY",			type: 'string' },
				{name:"DEPOSITGUBUN",	type: 'string' },
				{name:"SUGUMAMT",		type: 'string' },
				{name:"KNAME",			type: 'string' },
				{name:"ADDRESS",		type: 'string' }
				
            ],
            root: "rows",
            //record: "records",
            id: 'CITYCODE',
            url: url
        };

        var dataAdapter = new $.jqx.dataAdapter(source, {
            downloadComplete: function (data, status, xhr) {
            },
            loadComplete: function (data) {
            },
            loadError: function (xhr, status, error) { alert("Error~~!"); }
        });
        
		// initialize jqxGrid
        $("#mainList").jqxGrid({
        	theme: 'energyblue',
        	sorttogglestates: 0,
        	sortable: false,
            width: '98%',
            source: dataAdapter,                
            pageable: false,
            autoheight: false,
            altrows: true,
            enabletooltips: true,
            editable: false,
            selectionmode: 'singlerow',
            columns: [
                      
				{ text: '입금일자',			datafield: "IPGUMDATE",			width: 100, cellsalign: 'center'},
				{ text: '입금번호',			datafield: "IPGUMID",			width: 100, cellsalign: 'center'},
				{ text: '입금구분',			datafield: "IPGUMGUBUN",		width: 100, cellsalign: 'center'},
				{ text: '입금인',			datafield: "IPGUMPERSON",		width: 100, cellsalign: 'center'},
				{ text: '입금금액',			datafield: "IPGUMAMT",			width: 100, cellsalign: 'center'},
				{ text: '수금처리금액',		datafield: "SUMSUGUMAMT",		width: 100, cellsalign: 'center'},
				{ text: '처리잔액',			datafield: "JANGUMAMT",			width: 100, cellsalign: 'center'},
				{ text: '처리순번',			datafield: "SEQ",				width: 100, cellsalign: 'center'},
				{ text: '계약일자',			datafield: "SALEDATE",			width: 100, cellsalign: 'center'},
				{ text: '계약번호',			datafield: "SALEID",			width: 100, cellsalign: 'center'},
				{ text: '계약자',			datafield: "CONNAME",			width: 100, cellsalign: 'center'},
				{ text: '계약면적',			datafield: "CONM2",				width: 100, cellsalign: 'center'},
				{ text: '계약평수',			datafield: "CONPY",				width: 100, cellsalign: 'center'},
				{ text: '입금 구분',		datafield: "DEPOSITGUBUN",		width: 100, cellsalign: 'center'},
				{ text: '수금금액',			datafield: "SUGUMAMT",			width: 100, cellsalign: 'center'},
				{ text: '담당자',			datafield: "KNAME",				width: 100, cellsalign: 'center'},
				{ text: '소재지',			datafield: "ADDRESS",			width: 100, cellsalign: 'center'}
				
			]            
        });

	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_IPGUMDATE_FR = $("#S_IPGUMDATE_FR").val();
			var S_IPGUMDATE_TO = $("#S_IPGUMDATE_TO").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_SALERCD = $("#S_SALERCD").val();
			var S_IPGUMGUBUN = $("#S_IPGUMGUBUN").val();
			var S_IPGUMPERSON = $("#S_IPGUMPERSON").val();
			var S_IPGUMAMT = $("#S_IPGUMAMT").val();
			
			f_selectListSA012005(S_IPGUMDATE_FR, S_IPGUMDATE_TO, S_BRANCHCODE, S_SALERCD, S_IPGUMGUBUN, S_IPGUMPERSON, S_IPGUMAMT);
		});
		
		$("#excelButton").click(function () {
			//dataType String , fileName(optional) String , exportHeader Boolean, rows Array, exportHiddenColumns Boolean, serverURL String, charSet String 
	        $("#mainList").jqxGrid('exportdata', 'xls', 'EnglishFileName', true, null, true, null, 'utf-8');
	    });
		
	})
	
	
</script>
<body>

	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<td align="right">
						<input type="button" value="조회" id='selectButton' />
						<input type="button" value="엑셀" id='excelButton' />
						<input type="button" value="출력" id='printButton' />
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<th>입금기간</th>
					<td><input type="text" id="S_IPGUMDATE_FR" name="S_IPGUMDATE_FR" /> ~ <input type="text" id="S_IPGUMDATE_TO" name="S_IPGUMDATE_TO" /></td>
				</tr>
				<tr>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
						</select>
					</td>
					<th>담당자</th>
					<td>
						<select id="S_SALERCD" name="S_SALERCD">
						</select>
					</td>
				</tr>
				<tr>
					<th>입금구분</th>
					<td>
						<select id="S_IPGUMGUBUN" name="S_IPGUMGUBUN">
						</select>
					</td>
					<th>입금인</th>
					<td><input type="text" id="S_IPGUMPERSON" name="S_IPGUMPERSON" /></td>
					<th>입금금액</th>
					<td><input type="text" id="S_IPGUMAMT" name="S_IPGUMAMT" /></td>
				</tr>
			</table>
			<br/>
			<div id="mainList" width="98%"></div>
		</div>
	</div>
</body>
</html>