//
//  MapViewModel.swift
//  Reggie's Map
//
//  Created by angel hernandez   , Tanvai Pohare  , matt Strand , justin ray    on 6/17/25.


import Foundation
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var buildings: [CampusBuilding] = []

    @Published var selectedBuildingShowing: [CampusBuilding] = []   // help us

    @Published var selectedBuilding: CampusBuilding?
    @Published var route: MKRoute?
    @Published var searchText: String = ""

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        loadBuildings()
        selectedBuildingShowing = buildings
    }


    func loadBuildings() {
            buildings = [
                
             //   CampusBuilding(buildingCode: [" lsit attrbutes"],name: "name of building", coordinate: CLLocationCoordinate2D(latitude: 40.54497, longitude: -88.98852)),    // to add new buildings 
            
                
                CampusBuilding(buildingCode: ["211 N nUniversity Street", "Department of Military Science","Karin L. Bone Athletic Study Center"], name: "211 N. University Street", coordinate: CLLocationCoordinate2D(latitude: 40.51188, longitude: -88.99373)),
                CampusBuilding(buildingCode: ["308 Kingsley Street","Civil Service Testing Center","University Assessment Services"],name: "308 Kingsley Street", coordinate: CLLocationCoordinate2D(latitude: 40.50833, longitude: -88.99628)),
                CampusBuilding(buildingCode: ["The Alamo II"],name: "The Alamo II", coordinate: CLLocationCoordinate2D(latitude:40.509156, longitude: -88.989068)),
                CampusBuilding(buildingCode: ["Adelaide Street Field"],name: "Adelaide Street Field", coordinate: CLLocationCoordinate2D(latitude: 40.51486, longitude: -89.00095)),
                CampusBuilding(buildingCode: ["Administration Building #1","Environmental Health and Safety","Facilities Administration","Campus Services Campus Building"],name: "Administration Building #1", coordinate: CLLocationCoordinate2D(latitude: 40.53139, longitude: -89.00001)),
                CampusBuilding(buildingCode: ["Alumni Center","Alumni Engagement Office","Annual Giving Office","Conference Services","Donor and Information Services","Foundation Office","ISU Annuitants Association (ISUAA) ","University Marketing (UMC)"],name: "Alumni Center", coordinate: CLLocationCoordinate2D(latitude: 40.52513, longitude: -88.99686)),
                CampusBuilding(buildingCode: ["Bowling & Billiards Center"], name: "Bowling & Billiards Center",            coordinate: CLLocationCoordinate2D(latitude: 40.512045, longitude: -88.990856)),
                CampusBuilding(buildingCode: ["Bill Waller Parking and Transportation Building","Office of Parking and Transportation"],name: "Bill Waller Parking and Transportation Building", coordinate: CLLocationCoordinate2D(latitude: 40.51932, longitude: -88.99539)),
                CampusBuilding(buildingCode: ["Braden Auditorium"], name: "Braden Auditorium", coordinate: CLLocationCoordinate2D(latitude: 40.51126, longitude: -88.99227)),
                CampusBuilding(buildingCode: ["Bone Student Center" ,"Starbucks", "Brown Ball Room", "Redbird Spirit Shop", "Welcome Desk","ISU Credit Union"], name: "Bone Student Center", coordinate: CLLocationCoordinate2D(latitude: 40.51183, longitude: -88.99224)),
                CampusBuilding(buildingCode: ["CEFCU Arena" , "Athletic Development Office", "Athletic Director's Office", "Athletic Eligibility and Compliance Office","Athletic Facility Scheduling","Athletic Insurance","Athletic Marketing Office","Athletic and Redbird Arena Business Office","Ticket Office"],name: "CEFCU Arena", coordinate: CLLocationCoordinate2D(latitude: 40.51068, longitude: -88.99872)),
                CampusBuilding(buildingCode: ["Campus Religous Center"],name: "Campus Religous Center", coordinate: CLLocationCoordinate2D(latitude: 40.511570, longitude: -88.988752)),
                CampusBuilding(buildingCode: ["Cardinal Court","Birch Hall","Community Center","Cypress Hall","Dogwood Hall","Evergreen Hall","Fir Hall"],name: "Cardinal Court", coordinate: CLLocationCoordinate2D(latitude: 40.51640, longitude: -88.99936)),
                CampusBuilding(buildingCode: ["Carter Harris Building"],name: "Carter Harris Building", coordinate: CLLocationCoordinate2D(latitude: 40.51682, longitude: -88.99753)),
                CampusBuilding(buildingCode: ["Centennial West","School of Theatre, Dance, and Film"],name: "Centennial West", coordinate: CLLocationCoordinate2D(latitude: 40.50655, longitude: -88.99029)),
                CampusBuilding(buildingCode: ["Centennial East","Westhoff Theatre","Illinois State University Bands","Dance Studio","School of Music" ,"Kemp Recital Hall"],name: "Centennial East", coordinate: CLLocationCoordinate2D(latitude: 40.506907, longitude: -88.989938)),
                CampusBuilding(buildingCode: ["Center for Civic Engagement"],name: "Center for Civic Engagement", coordinate: CLLocationCoordinate2D(latitude: 40.50963, longitude: -88.98741)),
                CampusBuilding(buildingCode: ["Center for Mathematics, Science, and Technology"],name: "Center for Mathematics, Science, and Technology", coordinate: CLLocationCoordinate2D(latitude: 40.50940, longitude: -88.99540)),
                CampusBuilding(buildingCode: ["Center for the Performing Arts","Box Office"],name: "Center for the Performing Arts", coordinate: CLLocationCoordinate2D(latitude: 40.50745, longitude: -88.99003)),
                CampusBuilding(buildingCode: ["Center for the Visual Arts","Art Studio Campus Building","Normal Editions","School of Creative Technologies Transpace","Wonsook Kim College of Fine Arts IT","Wonsook Kim School of Art" ],name: "Center for the Visual Arts", coordinate: CLLocationCoordinate2D(latitude: 40.50665, longitude: -88.99068)),
                CampusBuilding(buildingCode: ["Chiller Plant"],name: "Chiller Plant", coordinate: CLLocationCoordinate2D(latitude: 40.50698, longitude: -88.98787)),
                CampusBuilding(buildingCode: ["College of Engineering Complex"],name: "College of Engineering Complex", coordinate: CLLocationCoordinate2D(latitude: 40.501308, longitude: -88.942253)),
                CampusBuilding(buildingCode: ["College Place Uptown","Accounting Office","Autism Spectrum Institute","Facilities Planning and Construction","Grants Accounting Office","National Board Resource Center","Office of Research Ethics and Compliance","Payroll Office","Purchasing Office","Research & Sponsored Programs","Travel Office"],name: "College Place Uptown", coordinate: CLLocationCoordinate2D(latitude: 40.509947, longitude: -88.987000)),
                CampusBuilding(buildingCode: ["Cook Hall"],name: "Cook Hall", coordinate: CLLocationCoordinate2D(latitude: 40.50936,  longitude: -88.99218)),
                CampusBuilding(buildingCode: ["Duffy Bass Field"],name: "Duffy Bass Field", coordinate: CLLocationCoordinate2D(latitude: 40.51533, longitude: -88.99932)),
                CampusBuilding(buildingCode: ["DeGarmo Hall","Cecilia J. Lauby Teacher Education Center","Center for the Study of Educational Policy","College of Education","Department of Psychology","Grapevine Publication","School of Teaching and Learning","Special Education","Studio TEaCH"], name: "DeGarmo Hall", coordinate: CLLocationCoordinate2D(latitude: 40.50894, longitude: -88.99265)),
                CampusBuilding(buildingCode: ["Eyestone School Museum"],name: "Eyestone School Museum", coordinate: CLLocationCoordinate2D(latitude: 40.51061, longitude: -89.0012)),
                CampusBuilding(buildingCode: ["Edwards Hall","Capen Auditorium","School of Nursing","Mennonite College of Nursing"], name: "Edwards Hall", coordinate: CLLocationCoordinate2D(latitude: 40.50987, longitude: -88.99217)),
                CampusBuilding(buildingCode: ["Ewing Cultural Center"], name: "Ewing Cultural Center", coordinate: CLLocationCoordinate2D(latitude: 40.49381, longitude: -88.96571)),
                CampusBuilding(buildingCode: ["Fairchild Hall", "Department of Communication Sciences and Disorders"],name: "Fairchild Hall", coordinate: CLLocationCoordinate2D(latitude: 40.50892, longitude: -88.99393)),
                CampusBuilding(buildingCode: ["Fell Hall","Office of International Studies and Programs","School of Communication","School of Communication Advisement Center","Student Access and Accommodation Services","Study Abroad","TRiO/Student Support Services","TV-10 News","University College","University College Academic Advisement","WZND Radio","Women's Mentoring Network"],name: "Fell Hall", coordinate: CLLocationCoordinate2D(latitude: 40.50841, longitude: -88.99213)),
                CampusBuilding(buildingCode: ["Felmley Hall of Science","Department of Geography, Geology, and the Environment","Department of Health Sciences","The Institute for Geospatial Analysis & Mapping (GEOMAP)","Felmley Hall of Science Annex"],name: "Felmley Hall of Science", coordinate: CLLocationCoordinate2D(latitude: 40.51035, longitude: -88.99092)),
                CampusBuilding(buildingCode: ["Football Practice Field"],name: "Football Practice Field", coordinate: CLLocationCoordinate2D(latitude: 40.51352, longitude: -88.99733)),
                CampusBuilding(buildingCode: ["Gregory Street Tennis Courts"],name: "Gregory Street Tennis Courts", coordinate: CLLocationCoordinate2D(latitude: 40.51902, longitude: -89.0093)),
                CampusBuilding(buildingCode: ["Hayden Auditorium"],name: "Hayden Auditorium", coordinate: CLLocationCoordinate2D(latitude: 40.51025, longitude: -88.99389)),
                CampusBuilding(buildingCode: [" Haynie Hall"],name: " Haynie Hall", coordinate: CLLocationCoordinate2D(latitude: 40.51237, longitude: -88.99989)),
                CampusBuilding(buildingCode: ["Hovey Hall","Academic Senate","Budget Office","Division of Student Affairs","Financial Aid Office","Graduate School","Media Relations","Office of Admissions","Office of Enrollment Management and Academic Services","Office of Equal Opportunity and Access","Office of General Counsel","Office of Internal Auditing","Office of the Comptroller","Office of the President","Office of the Provost","Planning, Research, & Policy Analysis","Title IX","Vice President of Finance and Planning"],name: "Hovey Hall", coordinate: CLLocationCoordinate2D(latitude: 40.5094, longitude: -88.98997)),
                CampusBuilding(buildingCode: ["Heating Plant"],name: "Heating Plant", coordinate: CLLocationCoordinate2D(latitude: 40.5103, longitude: -88.9929)),
                CampusBuilding(buildingCode: ["Honors Program Campus Building","Enterprise Data and Analytics","Honors Program"],name: "Honors Program Campus Building", coordinate: CLLocationCoordinate2D(latitude: 40.5091, longitude: -88.99508)),
                CampusBuilding(buildingCode: ["Horton Field House","Exercise Physiology Laboratory","Gamma Phi Circus","Horton Pool","North Gym","Sports Information Office","Redbird Track & Field Complex"],name: "Horton Field House", coordinate: CLLocationCoordinate2D(latitude: 40.5122, longitude: -88.99853)),
                CampusBuilding(buildingCode: ["Hancock Stadium","Hancock Stadium Club"], name: "Hancock Stadium", coordinate: CLLocationCoordinate2D(latitude: 40.5125, longitude: -88.99662)),
                CampusBuilding(buildingCode: ["Hewett Hall"],name: "Hewett Hall", coordinate: CLLocationCoordinate2D(latitude: 40.51069, longitude: -88.98748)),
                CampusBuilding(buildingCode: ["Horticulture Center"],name: "Horticulture Center", coordinate: CLLocationCoordinate2D(latitude: 40.531822, longitude: -89.002985)),
                CampusBuilding(buildingCode: ["Hudelson Building","English Language Institute"],name: "Hudelson Building", coordinate: CLLocationCoordinate2D(latitude: 40.51397, longitude: -88.99545)),
                CampusBuilding(buildingCode: ["In Exchange"],name: "In Exchange", coordinate: CLLocationCoordinate2D(latitude: 40.50807, longitude: -88.98948)),
                CampusBuilding(buildingCode: ["Julian Hall","Department of Chemistry","Digital Innovation, Graphics, and Gaming Studio","School of Biological Sciences","Technology Solutions","Technology Support Center"],name: "Julian Hall", coordinate: CLLocationCoordinate2D(latitude: 40.50994,    longitude: -88.98909)),
                CampusBuilding(buildingCode: ["John Green Food Science","Office of Energy Management"],name: "John Green Food Science", coordinate: CLLocationCoordinate2D(latitude: 40.51683, longitude: -88.99624)),
                CampusBuilding(buildingCode: ["Kaufman Football Building"],name: "Kaufman Football Building", coordinate: CLLocationCoordinate2D(latitude: 40.51299,    longitude: -88.996)),
                CampusBuilding(buildingCode: ["Linkins Center"],name: "Linkins Center", coordinate: CLLocationCoordinate2D(latitude: 40.51218, longitude: -89.00051)),
                CampusBuilding(buildingCode: ["Manchester Hall"],name: "Manchester Hall", coordinate: CLLocationCoordinate2D(latitude: 40.51106,    longitude: -88.98798)),
                CampusBuilding(buildingCode: ["Marian Kneer Softball Stadium"],name: "Marian Kneer Softball Stadium", coordinate: CLLocationCoordinate2D(latitude: 40.51396,    longitude: -89.00097)),
                CampusBuilding(buildingCode: ["Milner Library", "Administration Office" ,"Dr. Jo Ann Rayfield Archives","Illinois Regional Archives Repository (IRAD)","Milner Library","Milner Library uLab","Reference Desk","Special Collections","Study Spaces" ,"The Library of Congress Teaching with Primary Sources Midwest Region","Wonsook Kim College of Fine Arts"],name: "Milner Library", coordinate: CLLocationCoordinate2D(latitude: 40.511348, longitude: -88.990825)),
                CampusBuilding(buildingCode: ["McCormick Hall","Health Promotion and Wellness","Sports Medicine and Rehabilitation Therapy Clinic","School of Kinesiology and Recreation Academic Advisement","School of Kinesiology and Recreation"],name: "McCormick Hall", coordinate: CLLocationCoordinate2D(latitude: 40.507615, longitude: -88.992170)),
                CampusBuilding(buildingCode: ["Multicultural Center"],name: "Multicultural Center", coordinate: CLLocationCoordinate2D(latitude: 40.50833, longitude: -88.99518)),
                CampusBuilding(buildingCode: ["Moulton Hall","Department of Physics","Office of the University Registrar","Testing Services","Veterans and Military Services" ],name: "Moulton Hall", coordinate: CLLocationCoordinate2D(latitude: 40.50989, longitude: -88.99036)),
                CampusBuilding(buildingCode: ["Mennonite College of Nursing Simulation Center","Nursing Simulation Laboratory"],name: "Mennonite College of Nursing Simulation Center", coordinate: CLLocationCoordinate2D(latitude: 40.51329 ,   longitude: -88.99174)),
                CampusBuilding(buildingCode: ["Metcalf School"],name: "Metcalf School", coordinate: CLLocationCoordinate2D(latitude: 40.50959,  longitude: -88.99382)),
                CampusBuilding(buildingCode: ["Nelson Smith Building","Human Resources","Learning Spaces & Audio/Visual Technologies","Mail Service Center","Printing Services","University Police"],name: "Nelson Smith Building", coordinate: CLLocationCoordinate2D(latitude: 40.51031,    longitude: -89.0001)),
                CampusBuilding(buildingCode: ["North University Street Parking Garage"],name: "North University Street Parking Garage", coordinate: CLLocationCoordinate2D(latitude: 40.5128,  longitude: -88.99146)),
                CampusBuilding(buildingCode: ["Office of Residential Life Building","University Housing Services"],name: "Office of Residential Life Building", coordinate: CLLocationCoordinate2D(latitude: 40.50697,    longitude: -88.99272)),
                CampusBuilding(buildingCode: ["OSF Athletics Training Center"],name: "OSF Athletics Training Center", coordinate: CLLocationCoordinate2D(latitude: 40.51352 ,   longitude: -88.99733)),
                CampusBuilding(buildingCode: ["Old Union","School of Information Technology","Web & Interactive Communications","Web and Interactive Communications"],name: "Old Union", coordinate: CLLocationCoordinate2D(latitude: 40.50876, longitude: -88.98997)),
                CampusBuilding(buildingCode: ["Office of Sustainability" ], name: "Office of Sustainability", coordinate: CLLocationCoordinate2D(latitude: 40.51354, longitude: -88.99003)),
                CampusBuilding(buildingCode: ["Planetarium"],name: "Planetarium", coordinate: CLLocationCoordinate2D(latitude: 40.50864 ,   longitude: -88.99108)),
                CampusBuilding(buildingCode: ["Quad"],name: "Quad", coordinate: CLLocationCoordinate2D(latitude: 40.50864 ,   longitude: -88.99108)),
                CampusBuilding(buildingCode: ["Rachel Cooper","Center for Adoption Studies","Eckelmann-Taylor Speech and Hearing Clinic","School of Social Work","Women's, Gender, and Sexuality Studies Program"],name: "Rachel Cooper", coordinate: CLLocationCoordinate2D(latitude: 40.50873 ,   longitude: -88.99346)),
                CampusBuilding(buildingCode: ["Risk Management"],name: "Risk Management", coordinate: CLLocationCoordinate2D(latitude: 40.51322, longitude: -88.99111)),
                CampusBuilding(buildingCode: ["Ropp Agriculture CampusBuilding","Department of Agriculture"], name: "Ropp Agriculture CampusBuilding", coordinate: CLLocationCoordinate2D(latitude: 40.51336, longitude: -88.99554)),
                CampusBuilding(buildingCode: ["Redbird Adventure Center"],name: "Redbird Adventure Center", coordinate: CLLocationCoordinate2D(latitude: 40.517237  ,  longitude: -89.016506)),
                CampusBuilding(buildingCode: ["Schroeder Hall","Department of Criminal Justice Sciences","Department of History","Department of Politics and Government","Department of Sociology and Anthropology","Developmental Math Lab","Thomas Eimermann Pre-Law Advisement Center"],name: "Schroeder Hall", coordinate: CLLocationCoordinate2D(latitude: 40.51031, longitude: -88.99183)),
                CampusBuilding(buildingCode: ["Student Fitness Center","Starbucks","Campus Recreation"],name: "Student Fitness Center", coordinate: CLLocationCoordinate2D(latitude: 40.508, longitude: -88.99369)),
                CampusBuilding(buildingCode: ["School Street Parking Garage","Parking","Garage"],name: "School Street Parking Garage", coordinate: CLLocationCoordinate2D(latitude: 40.507237, longitude: -88.989118)),
                CampusBuilding(buildingCode: ["South University Street Parking Garage","Parking","Garage"],name: "South University Street Parking Garage", coordinate: CLLocationCoordinate2D(latitude: 40.505904, longitude: -88.992070)),
                CampusBuilding(buildingCode: ["State Farm Hall of Business","College of Business","College of Business Academic Advisement","Department of Accounting","Department of Finance, Insurance, and Law","Department of Management","George R. and Martha Means Center for Entrepreneurial Studies","Katie School of Insurance and Financial Services" ,"Marketing" ,"Master of Business Administration Program" ,"Professional Sales Institute","The Business Bistro" ],name: "State Farm Hall of Business", coordinate: CLLocationCoordinate2D(latitude: 40.507008, longitude: -88.991784)),
                CampusBuilding(buildingCode: ["Student Accounts","Cashier's Office","Student Accounts Office"],name: "Student Accounts Building", coordinate: CLLocationCoordinate2D(latitude: 40.508485, longitude: -88.996017)),
                CampusBuilding(buildingCode: ["Student Services Building","Dean of Students Office","Event Management, Dining, and Hospitality","Student Affairs Information Technology","Student Conduct and Community Responsibilities","Student Counseling Services","Student Government Assocation","Student Health Services","Student Insurance Office","Students' Attorney"] ,name: "Student Services Building", coordinate: CLLocationCoordinate2D(latitude: 40.511230, longitude: -88.993753)),
                CampusBuilding(buildingCode: ["Stevenson Hall","Actuarial Program - Department of Mathematics","Applied Social Research Unit","Center for Writing Research & Pedagogy","College of Arts and Sciences","Department of Economics","Department of English","Department of Languages, Literatures, and Cultures","Department of Mathematics" ,"Department of Philosophy" ,"Institute for Regulatory Policy Studies","Stevenson Center for Community and Economic Development"],name: "Stevenson Hall", coordinate: CLLocationCoordinate2D(latitude: 40.508085, longitude: -88.989038)),
                CampusBuilding(buildingCode: ["Science Laboratory Building"],name: "Science Laboratory Building", coordinate: CLLocationCoordinate2D(latitude: 40.509688, longitude: -88.988196)),
                CampusBuilding(buildingCode: ["Turner Hall","Child Care Center","College of Applied Science and Technology","Department of Family & Consumer Sciences","Department of Technology"],name: "Turner Hall", coordinate: CLLocationCoordinate2D(latitude: 40.51079, longitude: -88.99708)),
                
                CampusBuilding(buildingCode: ["University High School","Stroud Auditorium"],name: "University High School", coordinate: CLLocationCoordinate2D(latitude: 40.51556, longitude: -88.99609)),
                CampusBuilding(buildingCode: ["Uptown Station Gallery"],name: "Uptown Station Gallery", coordinate: CLLocationCoordinate2D(latitude: 40.50835, longitude: -88.98556)),
                CampusBuilding(buildingCode: ["Vertical Farm", "Farm" ,"Vertical" ],name: "Vertical Farm at Illinois State University", coordinate: CLLocationCoordinate2D(latitude: 40.513679, longitude: -88.990046)),
                CampusBuilding(buildingCode: ["University Farm"],name: "University Farm", coordinate: CLLocationCoordinate2D(latitude: 40.66767, longitude: -88.77288)),
                CampusBuilding(buildingCode: ["Vidette", "WGLT Building", "WGLT Radio"],name: "WGLT Building", coordinate: CLLocationCoordinate2D(latitude: 40.513114, longitude: -88.993721)),
                CampusBuilding(buildingCode: ["Vitro Center"],name: "Vitro Center", coordinate: CLLocationCoordinate2D(latitude: 40.51398, longitude: -88.99617)),
                CampusBuilding(buildingCode: ["Vrooman Center","Association of Residence Halls" ,"International House","Julia N Visor Academic Center"],name: "Vrooman Center", coordinate: CLLocationCoordinate2D(latitude: 40.510693, longitude: -88.987828)),
                CampusBuilding(buildingCode: ["Watterson Towers","Watterson","Dorm"],name: "Watterson Towers", coordinate: CLLocationCoordinate2D(latitude: 40.508163, longitude: -88.987783)),
                CampusBuilding(buildingCode: ["Weibring Golf Club" ,"Golf Club", "Weibring","Golf"],name: "Weibring Golf Club", coordinate: CLLocationCoordinate2D(latitude:40.517718, longitude: -89.004493)),
                CampusBuilding(buildingCode: ["Wilkins","Wilkins Hall"],name: "Wilkins Hall", coordinate: CLLocationCoordinate2D(latitude: 40.511679, longitude: -89.000316)),
                CampusBuilding(buildingCode: ["Watterson Dining Commons"],name: "Watterson Dining Commons", coordinate: CLLocationCoordinate2D(latitude: 40.50902, longitude: -88.98766)),
                CampusBuilding(buildingCode: ["Williams Hall","Williams Hall Annex","Center for Integrated Professional Development","College of Engineering","Electrical Engineering","General Engineering","Interdisciplinary Programs","Mechanical Engineering","Opscan Evaluation"],name: "Williams Hall", coordinate: CLLocationCoordinate2D(latitude: 40.50822, longitude: -88.98988)),
                CampusBuilding(buildingCode: ["Warehouse Road Complex 1"],name: "Warehouse Road Complex 1", coordinate: CLLocationCoordinate2D(latitude: 40.5439, longitude: -88.98809)),
                CampusBuilding(buildingCode: ["Warehouse Road Complex 2"],name: "Warehouse Road Complex 2", coordinate: CLLocationCoordinate2D(latitude: 40.54497, longitude: -88.98852)),
                CampusBuilding(buildingCode: ["Wright Hall"],name: "Wright Hall", coordinate: CLLocationCoordinate2D(latitude: 40.512652, longitude: -89.000828))
            ]
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                guard let location = locations.last else { return }
                DispatchQueue.main.async {
                    self.userLocation = location.coordinate
                }
            }

            func calculateRoute(to destination: CLLocationCoordinate2D) {
                guard let userLoc = userLocation else { return }

                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLoc))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
                request.transportType = .walking

                let directions = MKDirections(request: request)
                directions.calculate { [weak self] response, error in
                    if let route = response?.routes.first {
                        DispatchQueue.main.async {
                            self?.route = route
                        }
                    }
                }
            }

    var suggestedBuildings: [BuildingSuggestion] {
        let normalizedSearch = searchText
            .replacingOccurrences(of: " ", with: "")
            .lowercased()
        
        guard !normalizedSearch.isEmpty else { return [] }
        
        return buildings.flatMap { building in
                building.buildingCode.filter { code in
                        code.replacingOccurrences(of: " ", with: "")
                            .lowercased()
                            .contains(normalizedSearch)
                    }
                    .map { matchingCode in
                        BuildingSuggestion(building: building, matchedCode: matchingCode)
                    }
            
            
        }
        
    }
    
    // Open Apple Maps with the destination coordinate
    func openInAppleMaps(coordinate: CLLocationCoordinate2D, name: String) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: nil)
    }
    
    // Open Google Maps if installed, else fallback to Apple Maps
    func openInGoogleMaps(coordinate: CLLocationCoordinate2D) {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        if let url = URL(string: "comgooglemaps://?center=\(lat),\(lon)&zoom=14"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let webUrl = URL(string: "https://www.google.com/maps/search/?api=1&query=\(lat),\(lon)") {
            UIApplication.shared.open(webUrl)
        }
    }

    
    
    
}
