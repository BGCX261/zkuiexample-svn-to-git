<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'race.label', default: 'Race')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>
<z:window style="padding:5px" apply="racetrack.race.CreateComposer">
    <z:grid>
        <z:columns sizable="true">
            <z:column label="${message(code:'name',default:'Name')}" width="100px"/>
            <z:column label="${message(code:'value',default:'Value')}"/>
        </z:columns>
        <z:rows>
        
            <z:row>
                <z:label value="${message(code:'race.name.label',default:'Name')}"/>
                <z:textbox name="name" maxlength="50" value="${raceInstance?.name}" />
            </z:row>
        
            <z:row>
                <z:label value="${message(code:'race.city.label',default:'City')}"/>
                <zkui:select name="city" from="${raceInstance.constraints.city.inList}" value="${raceInstance?.city}" valueMessagePrefix="race.city"  />
            </z:row>
        
            <z:row>
                <z:label value="${message(code:'race.distance.label',default:'Distance')}"/>
                <z:intbox name="distance" value="${raceInstance?.distance}"/>
            </z:row>
        
            <z:row>
                <z:label value="${message(code:'race.cost.label',default:'Cost')}"/>
                <z:intbox name="cost" value="${raceInstance?.cost}"/>
            </z:row>
        
            <z:row>
                <z:label value="${message(code:'race.startDate.label',default:'Start Date')}"/>
                <z:datebox name="startDate" value="${raceInstance?.startDate}"/>
            </z:row>
        
        </z:rows>
    </z:grid>
    <z:hlayout>
        <z:button id="saveButton" label="${message(code: 'default.button.create.label', default: 'Create')}"/>
        <z:button href="${createLink(action:'list')}" label="${message(code: 'default.list.label', args:[entityName])}"/>
    </z:hlayout>
</z:window>
</body>
</html>