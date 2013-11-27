var sessionTypes = JSON.parse(twuJson["session_types"]);
var events = JSON.parse(twuJson["events"]);

var typesPerWeek = {
  links: [],
  nodes: []
};

var weeks = [ {week: 0}, {week: 1}, {week: 2}, {week: 3}, {week: 4}, {week: 5}];

function createIndexes() {
  weeks.concat(sessionTypes).forEach(function (e, i) {
    e.index = i;
  });
}

function createLinks() {
  var links = [];
  sessionTypes.forEach(function (type) {
    weeks.forEach(function (week) {
      var sessions = events.filter(function (e) { return e.week == week.week && e.type == type.type});
      sessions.length > 0  && links.push({ source: week.index, target: type.index, value: sessions.length});
    });
  }); 
  return links;
}

function createNodes() {
  var nodes = [];
  weeks.concat(sessionTypes).forEach(function (e) {
    nodes.push({ name: typeof e.week === "number" ? "Week " + e.week : e.type });
  });
  return nodes;
}

createIndexes();
var links = createLinks();
var nodes = createNodes();

var format = function(d) { return d };
    color = d3.scale.category20();

var margin = {top: 1, right: 1, bottom: 6, left: 1},
    width = 1200 - margin.left - margin.right,
    height = 700 - margin.top - margin.bottom;

var svg = d3.select("#sankey").append("svg")
  .attr("width", width + margin.left + margin.right)
  .attr("height", height + margin.top + margin.bottom)
  .append("g")
  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var sankey = d3.sankey()
  .size([width, height]);

sankey
  .nodes(nodes)
  .links(links)
  .layout(32);

var path = sankey.link();

  var link = svg.append("g").selectAll(".link")
.data(links)
  .enter()
  .append("path")
  .attr("class", "link")
  .attr("style", function (d) {
    return "fill: " + color(d.target.name.replace(/ .*/, "")); })
  .attr("d", path)

link.append("title")
  .text(function(d) { return d.source.name + " → " + d.target.name + "\n" + format(d.value); });

var node = svg.append("g").selectAll(".node")
.data(nodes)
  .enter().append("g")
  .attr("class", "node")
  .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; })
  .on("mouseover", function (d) {
      if(/Week/.test(d3.select(d)[0][0].name)) {
        return;
      }
      d3.selectAll('.node').style("opacity", "1");
      d3.selectAll('path').style("opacity", "1");
      var others = d3.selectAll('.node').filter(function (x) { 
        return d.name != x.name && !/Week/.test(x.name); });
      d3.selectAll('.link').filter(function (x) { 
        var name = x.target ? x.target.name : x.data.label;
        return name != d3.select(d)[0][0].name }).style("opacity", "0.1");
      others.style("opacity", "0.1");
  })

node.append("rect")
.attr("height", function(d) { return d.dy; })
.attr("width", sankey.nodeWidth())
.style("fill", function(d) { return d.color = color(d.name.replace(/ .*/, "")); })
.style("stroke", function(d) { return d3.rgb(d.color).darker(2); })
.append("title")
.text(function(d) { return d.name + "\n" + format(d.value); });

node.append("text")
.attr("x", -6)
.attr("y", function(d) { return d.dy / 2; })
.attr("dy", ".35em")
.attr("text-anchor", "end")
.attr("transform", null)
.text(function(d) { return d.name; })
.filter(function(d) { return d.x < width / 2; })
.attr("x", 6 + sankey.nodeWidth())
.attr("text-anchor", "start");
