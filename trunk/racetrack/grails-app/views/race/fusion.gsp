<html>
<head>
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'race.label', default: 'Race')}" />
<title><g:message code="default.list.label" args="[entityName]" />
</title>
</head>
<body>
<!-- visit this page through controller http://localhost:8080/racetrack/race/fusion -->
	<z:window style="padding:5px" apply="racetrack.race.FusionComposer">
		<z:hlayout>
			<z:label value="${message(code:'race.id',default:'Name')}" />
			<z:textbox id="keywordBox" />
		</z:hlayout>
		<g:if test="${flash.message}">
			<z:window mode="popup" border="normal">
				<z:hlayout>
					<z:image src="/images/skin/information.png" />
					<z:div>
						${flash.message}
					</z:div>
				</z:hlayout>
			</z:window>
		</g:if>
		<z:grid id="grid"
			emptyMessage="${message(code:'emptyMessage',default:'No Record')}">
			<z:columns sizable="true">
				<z:column label="${message(code: 'race.id.label', default: 'Id')}"
					width="5%" />
				<z:column
					label="${message(code: 'race.name.label', default: 'Name')}" />
				<z:column
					label="${message(code: 'race.city.label', default: 'City')}" />
				<z:column
					label="${message(code: 'race.distance.label', default: 'Distance')}"
					width="10%" />
				<z:column
					label="${message(code: 'race.cost.label', default: 'Cost')}"
					width="5%" />
				<z:column
					label="${message(code: 'race.startDate.label', default: 'Start Date')}" />
				<z:column width="150px" />
			</z:columns>
		</z:grid>
		<z:paging autohide="true" id="paging" pageSize="15" />
		<z:longbox id="idBox" name="id" value="${raceInstance.id}" visible="false"/>
        <z:longbox id="versionBox" name="version" value="${raceInstance.version}" visible="false"/>
		<z:grid>
			<z:columns sizable="true">
				<z:column label="${message(code:'name',default:'Name')}"
					width="100px" />
				<z:column label="${message(code:'value',default:'Value')}" />
			</z:columns>
			<z:rows>

				<z:row>
					<z:label value="${message(code:'race.name.label',default:'Name')}" />
					<z:textbox id="nameBox" name="name" maxlength="50" value="${raceInstance?.name}" />
				</z:row>
				<z:row>
					<z:label value="${message(code:'race.city.label',default:'City')}" />
					<zkui:select id="citySelect" name="city"
						from="${raceInstance.constraints.city.inList}"
						value="${raceInstance?.city}" valueMessagePrefix="race.city" />
				</z:row>
				<z:row>
					<z:label
						value="${message(code:'race.distance.label',default:'Distance')}" />
					<z:intbox id="distanceBox" name="distance" value="${raceInstance?.distance}" />
				</z:row>

				<z:row>
					<z:label value="${message(code:'race.cost.label',default:'Cost')}" />
					<z:intbox id="costBox" name="cost" value="${raceInstance?.cost}" />
				</z:row>

				<z:row>
					<z:label
						value="${message(code:'race.startDate.label',default:'Start Date')}" />
					<z:datebox id="startDateBox" name="startDate" value="${raceInstance?.startDate}" />
				</z:row>
			</z:rows>
		</z:grid>
		<z:hlayout>
			<z:button id="createButton"
				label="${message(code: 'default.button.create.create', default: 'Create')}" />
			<z:button id="updateButton"
				label="${message(code: 'default.button.create.update', default: 'Update')}" visible="false"/>				
		</z:hlayout>
	</z:window>
</body>
</html>