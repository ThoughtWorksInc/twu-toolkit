var sessionTypes = JSON.parse(twuJson["session_types"]);
var events = JSON.parse(twuJson["events"]);

var w = 650,
    h = 650,
    r = 300,
    color = d3.scale.category20c();     

data = (function () {
  var sessionTypesData = [];
  sessionTypes.forEach(function (type) {
    typeData = {"label": type.type, "value": 0};
    events.forEach(function (e) {
      e.type == type.type && typeData["value"]++;
    });
    sessionTypesData.push(typeData);
  });
  return sessionTypesData;
}()).filter(function (e) { return e["value"] > 0 });

var vis = d3.select("#piechart")
  .append("svg:svg")              
.data([data])                   
  .attr("width", w)           
  .attr("height", h)
  .append("svg:g")                
  .attr("transform", "translate(" + r + "," + r + ")")    

var arc = d3.svg.arc()              
  .outerRadius(r);

var pie = d3.layout.pie()           
  .value(function(d) { return d.value; });    

  var arcs = vis.selectAll("g.slice")     
  .data(pie)                          
.enter()                            
  .append("svg:g")                
  .attr("class", "slice");    

  arcs.append("svg:path")
  .attr("fill", function(d, i) { return color(i); } ) 
  .attr("d", arc);                                    

  arcs.append("svg:text")                                     
  .attr("transform", function(d) {                    
    d.innerRadius = 0;
    d.outerRadius = r;
    return "translate(" + arc.centroid(d) + ")";        
  })

var legendas = d3.select('#piechart').append('ul');

legendas.selectAll('li')
.data(data)
.enter()
  .append('li').style('list-style', 'none')
  .text(function (d, i) { return d.label })
  .append('div').attr('class', 'legenda').style('background-color', function(d, i) { return color(i) })

legendas.selectAll('li')
  


