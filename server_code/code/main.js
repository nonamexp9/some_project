var restify = require('restify');
var databaseUrl = "localhost:27017/some_database"; // "username:password@example.com/mydb"
var collections = ["pins", "reports"]
var db = require("mongojs").connect(databaseUrl, collections);
console.log("connected");
/**
#############################################################
###################### Pins method  ########################
############################################################
*/
function respond_pins_get(req, res, next) {
	//{sex: "female"},
	db.pins.find(function(err, pins) {
		  res.send(pins);
	  } );
	  return next();
}
// update Pins
function respond_pins_put(req, res, next) {
	return next();
}

// create pins
function respond_pins_post(req, res, next) {
	
 console.log(req.body);
	db.pins.save(req.body);
	
	return next();
}

function respond_pins_del(req, res, next) {
    return next();
} 

/**
#############################################################
###################### Pins Items method  ########################
############################################################
*/

function respond_pins_item_get(req, res, next) {

	db.pins.findOne( { '_id': db.ObjectId(req.params.id)}, function(err, pin) {
		  res.send(pin);
	  } );
	  return next();
}
// update Pins
function respond_pins_item_put(req, res, next) {
	return next();
}

// create pins
function respond_pins_itempost(req, res, next) {
	
	return next();
}

function respond_pins_item_del(req, res, next) {
    
   	db.pins.remove( { '_id': db.ObjectId(req.params.id)});
    return next();
} 





var server = restify.createServer({
		  name: 'Some_project',
});
//set up
server.use(restify.bodyParser({ mapParams: false }));

//pins work flow
server.get('/pins/', respond_pins_get);
server.put('/pins/', respond_pins_put);
server.post('/pins/', respond_pins_post);
server.del('/pins/', respond_pins_del);

//pins/items work flow
server.get('/pins/:id', respond_pins_item_get);
server.put('/pins/:id', respond_pins_item_put);
server.post('/pins/:id', respond_pins_itempost);
server.del('/pins/:id', respond_pins_item_del);

// server.head('/hello/:name', respond); this one is use for calling data of header 

server.listen(8080, function() {
  console.log('%s listening at %s', server.name, server.url);
});