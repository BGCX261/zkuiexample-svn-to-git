package racetrack.race

import java.text.SimpleDateFormat;

import org.zkoss.zk.ui.Component
import org.zkoss.zul.*
import org.zkoss.zk.ui.event.*
import racetrack.Race

class FusionComposer {
	Window self
    Grid grid
    ListModelList listModel = new ListModelList()
    Paging paging
	Textbox keywordBox
	Longbox idBox
	Longbox versionBox
	Textbox nameBox
	Combobox citySelect
	Intbox distanceBox
	Intbox costBox
	Datebox startDateBox
	Button createButton
	Button updateButton
	
	SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

    def afterCompose = {Component comp ->
        grid.setRowRenderer(rowRenderer as RowRenderer)
        grid.setModel(listModel)
        redraw()
    }
	
	void onChanging_keywordBox(InputEvent e) {
		keywordBox.value = e.value
		redraw()
	}

    void onClick_searchButton(Event e) {
        redraw()
    }

    void onPaging_paging(ForwardEvent fe) {
        def event = fe.origin
        redraw(event.activePage)
    }

	void onClick_createButton(Event e) {
		def raceInstance = new Race(self.params)
		if (!raceInstance.save() && raceInstance.hasErrors()) {
			log.error raceInstance.errors
			self.renderErrors(bean: raceInstance)
		} else {
			flash.message = g.message(code: 'default.created.message', args: [g.message(code: 'race.label', default: 'Race'), raceInstance.id])
		}
		redraw()
		clearInput()
	}

	void onClick_updateButton(Event e) {
		def params=self.params
		def raceInstance = Race.get(params.id)
		if (raceInstance) {
			if (params.version != null) {
				def version = params.version
				if (raceInstance.version > version) {
					String failureMessage = g.message(code:"default.optimistic.locking.failure",args:[g.message(code: 'race.label', default: 'Race')],default:"Another user has updated this ${raceInstance} while you were editing")
					Messagebox.show(failureMessage, g.message(code:'error',default:'Error'), Messagebox.YES, Messagebox.ERROR)
					return
				}
			}
			raceInstance.properties = params
			if (!raceInstance.hasErrors() && raceInstance.save(flush: true)) {
				flash.message = g.message(code: 'default.updated.message', args: [g.message(code: 'race.label', default: 'Race'), raceInstance.id])
			}else {
				log.error raceInstance.errors
				self.renderErrors(bean: raceInstance)
			}
		}
		else {
			flash.message = g.message(code: 'default.not.found.message', args: [g.message(code: 'race.label', default: 'Race'), params.id])
		}
		redraw()
		clearInput()
		updateButton.visible = false
		createButton.visible = true
	}
	
	void clearInput(){
		nameBox.value = null
		citySelect.selectedItem = null
		distanceBox.value = null
		costBox.value = null
		startDateBox.value = null
	}
	
    private redraw(int activePage = 0) {
        int offset = activePage * paging.pageSize
        int max = paging.pageSize
        def raceInstanceList = Race.createCriteria().list(offset: offset, max: max) {
            order('id','desc')
			if (keywordBox.value){
				ilike('name',"%"+keywordBox.value+"%")
			}
        }
        paging.totalSize = raceInstanceList.totalCount
        listModel.clear()
        listModel.addAll(raceInstanceList.id)
    }

	void test(){
		println "test"
	}
    private rowRenderer = {Row row, Object id ->
        def raceInstance = Race.get(id)
        row << {
                a(href: g.createLink(controller:"race",action:'edit',id:id), label: raceInstance.id)
                label(value: raceInstance.name)
                label(value: raceInstance.city)
                label(value: raceInstance.distance)
                label(value: raceInstance.cost)
                label(value: dateFormatter.format(raceInstance.startDate))
                hlayout{
                    toolbarbutton(label: g.message(code: 'default.button.edit.label', default: 'Edit'),image:'/images/skin/database_edit.png',
						onClick:{
							idBox.value = raceInstance.id
							versionBox.value = raceInstance.version
							nameBox.value = raceInstance.name
							citySelect.selectedItem = citySelect.items.find { it.value == raceInstance.city }
							distanceBox.value = raceInstance.distance
							costBox.value = raceInstance.cost
							startDateBox.value = raceInstance.startDate
							updateButton.visible = true
							createButton.visible = false	
						})
                    toolbarbutton(label: g.message(code: 'default.button.delete.label', default: 'Delete'), image: "/images/skin/database_delete.png", client_onClick: "if(!confirm('${g.message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}'))event.stop()", onClick: {
                        Race.get(id).delete(flush: true)
                        listModel.remove(id)
                    })
                }
        }
    }
}