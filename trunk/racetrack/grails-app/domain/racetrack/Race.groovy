package racetrack

class Race {
	String name
	Date startDate
	String city
	Integer distance
	Integer cost

    static constraints = {
		name(blank:false, maxSize:50)
		city(inList:["Taichung","Tainan","Kaohsiung"])
		distance(min:0)
		cost(min:0, max:100)
    }
}
