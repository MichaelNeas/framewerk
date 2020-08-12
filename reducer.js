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
		const content = body.sections[1].groups;
		const { references } = body;
		const output = {};
		
		content.forEach(group => {
			const { technologies, name } = group;
			
			output[name] = technologies.map(technology => {
				const { title: question, destination, tags: sdks } = technology;
				const { identifier: reference } = destination;
				let answer = '';
                let link = 'https://developer.apple.com';
                                
				if (references[reference]) {
					answer = references[reference].abstract[0].text;
					link += references[reference].url;
				}
				return {
					question,
					answer,
					link,
					sdks,
				};
			});
		});
		
		fs.writeFile('db2.json', JSON.stringify(output), (err) => {
			if (err) throw err;
				console.log('complete');
			}
		);
	});
});