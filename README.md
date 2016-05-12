#Boilerplate

This boilerplate is to get up and running quickly with Sass and Webpack.
It requires sass, jshint and webpack CLI to be installed globally.

**Before installation:**  
`npm install -g sass && npm install -g webpack && npm install -g tslint`  


**During installation:**

A `src` folder to contain your `js`, `ts` and `sass` files are automatically created, along with a `dist` folder containing `js` and `css` folders that holds the compiled files. `index.html` is also generated, but is empty.

**Scripts available:**   

`npm run build` Builds the current src files with sourcemaps for development.   
`npm run deploy` Builds the current src files for deployment with no sourcemaps.  

`tslint` is run on both scripts, both `sass` and `webpack` (using the `uglify` plugin) minify before outputting to dist.

**Tips:**

It is recommended you use `npm run -s` instead of `npm run` to squash the readback of the scripts. It makes the output easier to read.

The `webpack` config files are for the build `script` and `deployment` script respectively so add in any configuration you like to those files for development or deployment.
