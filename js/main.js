var musherHighlight = "Peter Kaiser"
// const sortTimes =times.sort((a,b)=> b-a);

// console.log(times)
// const units = 500;
const yUnits = 550;


const screenWidth = window.innerWidth;

var units;
screenWidth < 500 ? units = 350 : units= (screenWidth -30)/2;
console.log(units+"units");








const lineScaleX = d3.scaleLinear().domain([1,53]).range([90,units-5])
const lineScaleY = d3.scaleLinear().domain([0,23]).range([6,yUnits-60])

const lineGenerator =  d3.line()
                    .x(d=> lineScaleX(d.checkPlace))
                    .y(d=>lineScaleY(d.index))
                    // .curve(d3.curveNatural) 
                    // .curve(d3.curveBundle) 
                    // .curve(d3.curveStepBefore) 
                    .curve(d3.curveStep) 
                    // .curve(d3.curveStepAfter) 
                    // .curve(d3.curveCardinal) 
                    // .curve(d3.curveLinear) 


function highlight (musher){

musherHighlight = musher;

    d3.selectAll('path').attr("class", "line")


    d3.selectAll('rect').attr("fill", "#444")
    d3.selectAll('rect').attr("rx", 4)
    d3.selectAll('rect').attr("ry", 4)
    d3.selectAll('rect').attr("height", 8)
    d3.selectAll('rect').attr("width", 8)
    d3.selectAll('rect').attr("stroke", "none")
    
    
const musherParsed =musher.replace(" ","").replace(" ", "");

    // console.log("this is the"+ musherParsed)


    d3.selectAll('rect').attr("class", "rectSelect")

        d3.select(`#${musherParsed}`).attr("fill", "black")
        // d3.select(`#${musherParsed}`).attr("class", "rectSelect")
        d3.select(`#${musherParsed}`).attr("stroke-width",5)
        d3.select(`#${musherParsed}`).attr("stroke","salmon")
        d3.select(`#${musher.replace(" ","")}`).attr("width", 9)
        d3.select(`#${musher.replace(" ","")}`).attr("height", 9)
        d3.select(`#${musherParsed}`).attr("rx", 12)
        d3.select(`#${musherParsed}`).attr("ry", 12)
        // d3.select(`#${musherParsed}`).append("g").append("text").attr("y", 10).attr("x", 10).text(musherParsed)
        // d3.select(`#_${musher.replace(" ","")}`).attr("stroke-width", 5)
        d3.select(`#_${musherParsed}`).transition().attr("class", "lineSelect")

// const joar1 = d3.select("#JoarLeifsethUlsom").attr("fill", "blue")
}




var parseTime = d3.timeParse("%Y-%m-%d %H:%M:%S");
var parseTimeZ = d3.timeParse("%Y-%m-%dT%H:%M:%SZ");
var formatTime = d3.timeFormat("%Y-%m-%d %H:%M:%S")
var formatStamp = d3.timeFormat("%A, %B %e %H:%M")
// console.log(parseTime(times[1]))
// parseTime("June 30, 2015"); // Tue Jun 30 2015 00:00:00 GMT-0700 (PDT)


// const timesMini = times.filter((d,i)=> i%10 ==0)
const timesMini = times.filter((d,i)=> i%6 ==0)
console.log(timesMini)

// const timesSmall = times.filter(d=> d>'2019-03-04 12:10:00'&&  d>'2019-03-04 19:10:00')



    // d3.selectAll('rect').remove();
    // d3.selectAll('text').remove();




    d3.csv("data/allHour.csv", function(data){
        d3.csv("data/locationIndexName.csv",function(labelData) {
            d3.csv("data/resGroup.csv", function (lineData){

                const labelDataSelect = labelData.filter((d,i)=> i%2 == 0)

        document.querySelector(".replay").addEventListener("click", loop)
        // function full (){

            console.log("is this full!!")
                    d3.selectAll('svg').remove();
                    d3.selectAll('p').remove();
                
                const height = 550;
                // const width= 700;
                const width = units;
                
                
                // const svg = d3.select("#dot").append('svg').attr("height",height).attr("width", width).attr("class", "bg")
                // const svgG = svg.append('g')
                // const svgLabel = svg.append('g');
                
                // const svgLine = d3.select("#line").append("svg").attr("width", units).attr("height", yUnits)
                
                
        

        data.forEach(function (d) {
        
            d.index = +d.index
            d.relOrder = +d.relOrder;
            d.parsedDate = formatTime(parseTimeZ(d.currentTimeStamp));
            d.musher = d.currentMusher.replace(" ","")
            d.musher = d.musher.replace(" ","")
        
        })
        
        
        
            const middle =  data.filter(d=> d.currentTimeStamp == '2019-03-08T14:00:00Z')
            const threeQ =  data.filter(d=> d.currentTimeStamp == '2019-03-03T19:00:00Z')
            const start =  data.filter(d=> d.currentTimeStamp == '2019-03-03T14:00:00Z')
                
        
        //make an array of eavh indivual time stamp
        //forEach it. with an setTimeout
        
        const leftOffset = 30;
        
        
        const scaleX = d3.scaleLinear().domain([0,45]).range([0,yUnits-79]);
        // const scaleY = d3.scaleLinear().domain([0,52]).range([0,800]);
        
        
        
        
        
        
        
        
        
        
        
        
        // const rp = textArea.append('p').attr("class", "city").attr("innerText", "RanyPass").attr("class", "city")
        
        // const wil = textArea.append('text').attr('y', 200).attr('x', scaleX(1)).text("Willow").attr("class", "city").style("transform-origin", scaleX(1), 200)
        // const nome = textArea.append('text').attr('y', 200).attr('x', scaleX(44)).text("Nome").attr("class", "city").style("transform-origin", scaleX(44), 200)
        
        // const pete = recs.select("[currentMusher='Pete Kaiser']").attr("fill", "red")
        // const pete1 = d3.select("#PeterKaiser").attr("fill", "salmon")
        // const nic1 = d3.select("#NicolasPetit").attr("fill", "green")
        // const joar1 = d3.select("#JoarLeifsethUlsom").attr("fill", "blue")

        
        
        
        
        function loop () {
        
        
        //    svg ? svg.remove() : console.log('no svg')

                  
        d3.selectAll('#dotSvg').remove();
        

        
            const svg = d3.select("#dot").append('svg').attr("height",height).attr("width", width).attr("class", "bg").attr("id", "dotSvg")
            const svgG = svg.append('g')
            // const svgLabel = svg.append('g');
            


            d3.selectAll('p').remove();
            d3.selectAll('span.timeSpan').remove();


            var recs = svgG.selectAll('rect').data(start, d=>d.currentMusher).enter()
            .append('rect')
            .attr("width", 8)
            .attr("height", 8)
            // .attr("y", d=>scaleX(d.index)).attr('x', (d,i)=>700-(i*7))
            .attr("y", d=>scaleX(d.index)+13)
            .attr('x', d=>d.relOrder*10 +leftOffset+60)
            .attr("opacity", 1)
            .attr("currentMusher", d=>d.currentMusher)
            .attr("id", d=>d.musher)
            .attr("rx", 4)
            .attr("ry", 4)
            // .attr("stroke", 'white')
            .attr("fill", '#444')
            // const textArea = svgTop.append('g')
            // const textArea = d3.select('#time').append('p')
            const textArea = d3.select('#time').append('span').attr("class", "timeSpan")
            
        

            const svg1 = svgG.append('g')
            const textY = 60
            
            
       
            
            const svgLabel = svg.append('g');

            svgLabel.selectAll('text').data(labelDataSelect).enter().append('text')
                .attr("x", textY+leftOffset)
                .attr('y', (d,i) =>  (i*21) +30)
                .text(d=> `${d.location_name}`)
                .attr('text-anchor', "end")
                .attr('class', "city")
            
            
                highlight(musherHighlight);
                console.log('musherHighLight')
                console.log(musherHighlight)





        // const pete1 = d3.select("#PeterKaiser").attr("stroke-width", 4).attr("stroke", "salmon")


            
            timesMini.forEach(function(t, i){

                function inner (){
                    // console.log("looping")
                    const currentData = data.filter(d=> d.parsedDate == t.toString())
                    // console.log(currentData)
        
                
    
                const newRects = svgG.selectAll('rect').data(currentData, d=>d.currentMusher)
                
                newRects.transition()
                    .duration(400)
                    .attr("y", d=>scaleX(d.index)+13)
                    .attr('x', (d,i)=>(d.relOrder*10+leftOffset+60))
                    .attr("opacity", d=> d.index%2 > 0 ? .3 : 1)
                        .ease(d3.easeLinear)
                    
                    newRects.append('text').text(d=>d.currentMusher).attr('x', 0).attr('y', 1)
                
                
                
                
                textArea.selectAll('text').remove()
                
                textArea.append('text').attr('x', 0).attr('y', 0).text(formatStamp(parseTime(t))).attr("class", "time")
              
                
                    }


                if (i <= timesMini.length) {
        setTimeout(inner,400*i)
             } else  {
                 
                console.log("DDdone??");
                clearTimeout(inner)
            }
            
            
    
            })
        
            } //loop
        
            loop()
            highlight(musherHighlight);
        // var waff = dropSvg.selectAll('div').data(waffArray)
        // waff.exit().remove()
        
        // waff.transition()
        // .duration(1000)
        // waff.enter().append('div')
        // .attr("class", "waffle")
        
        
        
        //line stuff



lineData.forEach(function (r){

    r.checkPlace = +r.checkPlace
    r.index = +r.index
    // r.musher = r.musher.replace(" ","")
    r.musherShort = r.musher.replace(" ","").replace(" ","")
    // r.musherShort = r.musherShort.replace(" ","")
    
    // console.log(r)
    })
    
    const musherList = ["Jessie Holmes","Matt Hall","Linwood Fiedler","Mats Pettersson","Peter Kaiser","Jessie Royer","Jason Campeau","Ramey Smyth","Lev Shvarts","Anna Berington","Nicolas Petit","Jeff King","Aliy Zirkle","Martin Buser","Anja Radano","Emily Maxwell","Joar Leifseth Ulsom","Richie Diehl","Kristy Berington","Charley Bejna","Ryan Redington","Ed Hopkins","Brett Bruggeman","Kristin Bacon","Paige Drobny","Mitch Seavey","Aaron Burmeister","Travis Beals","Alison Lifka","Robert Redington","Ryan Santiago","Aaron Peck","Sarah Stokey","Marcelle Fressineau","Jeremy Keller","Sebastien Dos Santos Borges","Cindy Gallea","Richie Beattie","Wade Marrs","Matthew Failor","Martin Apayauq Reitan","Jessica Klejka","Michi Konno","Jeff Deeter","Cindy Abbott","Blair Braverman","Shaynee Traska","Lance Mackey","Seth Barnes","Niklas Wikstrand","Michael Baker","Victoria Hardwick"] 
    
    lineData.sort((a,b)=> b.index - a.index)
        //append svg
    const svgLine = d3.select("#line").append("svg").attr("width", units).attr("height", yUnits)
    


    const svgLabelLine = svgLine.append('g');

    svgLabelLine.selectAll('text').data(labelDataSelect).enter().append('text')
        .attr("x", leftOffset+50) //used to be 55
        .attr('y', (d,i) =>  (i*21) +30)
        .text(d=> `${d.location_name}`)
        .attr('text-anchor', "end")
        .attr('class', "citySmall")










const axis = d3.axisTop(lineScaleX).tickValues([1,10,20, 30,40, 50])

svgLine.append('g')
.attr("transform", "translate(0,23)")
.attr('class', "axisClass")
    .call(axis)
    .select(".domain").remove()


    
    const pete = lineData.filter(d=> d.musher == "Peter Kaiser")
    const joar = lineData.filter(d=> d.musher == "Joar Leifseth Ulsom")
    const aliy = lineData.filter(d=> d.musher == "Aliy Zirkle")
    // console.log(pete)
    
    const keys = d3.keys(lineData)
    const entries = d3.entries(lineData)
    // console.log(entries)
    
    musherList.forEach(function (d, i){  
        
        const mush = lineData.filter(j=> j.musher == d );
        svgLine.append("path")
        .datum(mush)
        .attr("d", lineGenerator)
        .attr("class", "line")
        .attr("id", q=>`_${d.replace(" ","").replace(" ","")}`)
    }
    )
    
    
    svgLine.append("path")
        .datum(pete)
        .attr("d", lineGenerator)
        .attr("class", "lineSelect")
    
        // svgLine.append("path")
        // .datum(aliy)
        // .attr("d", lineGenerator)
        // .attr("class", "lineSelect")
    
    
    // svgLine.append("path")
    // .datum(joar)
    // .attr("d", lineGenerator)
    // .attr("class", "line")
    
    
    
    
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       
// } // full


// full(); 
        
        
        
        
        })
        })  //sedcond csv
    }) //.linedata csv




///












