<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'race.label', default: 'Race')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <z:window style="padding:5px" apply="racetrack.race.ListComposer">
            <z:hlayout>
                <z:toolbarbutton href="${createLink(action:'create')}" image="/images/skin/database_add.png" label="${message(code:'default.new.label',args:[entityName])}"/>
                <z:space/>
                <z:label value="${message(code:'race.id',default:'Name')}"/>

                <z:textbox id="keywordBox"/> 
                <z:space/>
                <!-- 
                <z:button id="searchButton" label="${message(code:'search')}"/>
                 -->
            </z:hlayout>
            <g:if test="${flash.message}">
                <z:window mode="popup" border="normal">
                    <z:hlayout>
                        <z:image src="/images/skin/information.png"/>
                        <z:div>
                            ${flash.message}
                        </z:div>
                    </z:hlayout>
                </z:window>
            </g:if>
            <z:grid id="grid" emptyMessage="${message(code:'emptyMessage',default:'No Record')}">
                <z:columns sizable="true">
                    <z:column label="${message(code: 'race.id.label', default: 'Id')}" width="5%"/>
                    <z:column label="${message(code: 'race.name.label', default: 'Name')}"/>
                    <z:column label="${message(code: 'race.city.label', default: 'City')}"/>
                    <z:column label="${message(code: 'race.distance.label', default: 'Distance')}" width="10%"/>
                    <z:column label="${message(code: 'race.cost.label', default: 'Cost')}"  width="5%"/>
                    <z:column label="${message(code: 'race.startDate.label', default: 'Start Date')}"/>
                    <z:column width="150px"/>
                </z:columns>
            </z:grid>
            <z:paging autohide="true" id="paging" pageSize="15"/>
        </z:window>
    </body>
</html>