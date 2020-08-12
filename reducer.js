const https = require("https");
const url = "https://developer.apple.com/tutorials/data/documentation/technologies.json";
const fs = require('fs');

https.get(url, res => {
	let body = "";
	res.on("data", data => {
		body += data;
	});
	res.on("end", () => {
		body = JSON.parse(body);
		let content = body.sections[1].groups
		let references = body.references
		let output = {}
		
		for(let i=0;i<content.length; i++){
			let technologies = content[i].technologies
			output[content[i].name] = []
			for(let j=0; j<technologies.length; j++){
				let title = technologies[j].title // better title
				let reference = technologies[j].destination.identifier
				
				let abstract = ""
				let refURL = ""
				if(references[reference]){
					abstract = references[reference].abstract[0].text
					refURL = "https://developer.apple.com" + references[reference].url
				}

				let tags = technologies[j].tags

				output[content[i].name].push({
					question: title,
					answer: abstract,
					link: refURL,
					sdks: tags
				})
			}
			
		}
		
		fs.writeFile('db2.json', JSON.stringify(output), (err) => {
			if (err) throw err;
				console.log('complete');
			}
		);
	});
});