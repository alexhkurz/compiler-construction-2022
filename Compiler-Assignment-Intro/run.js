const { readFileSync } = require("fs");
var scanf = require('scanf');
const inputWasm = process.argv[2];

const run = async () => {
  const buffer = readFileSync(inputWasm);
  const module = await WebAssembly.compile(buffer);
  const instance = await WebAssembly.instantiate(module, {
	  env: {
	    readInt: () => { return scanf("%d") },
	    readDouble: () => { return scanf("%f") },
	    printInt: (i) => { console.log(i) },
	    printDouble: (i) => { if(Math.round(i) === i){console.log(i+".0")} else {console.log(i)} }
	  }
	});
  instance.exports.main();
};

run();
