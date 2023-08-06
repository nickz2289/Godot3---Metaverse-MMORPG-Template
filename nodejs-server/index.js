var ws = require('ws');

var server = new ws.Server({port: 3000});

var userNumber = 1;

var users = {};

server.on('connection', function connection(ws) {
    ws.on('message', message => {
        let data = JSON.parse(message);
        console.log(data);

        if(data['type'] === 'pesan'){
            if(data['value']){
                //broadcast to all user
                server.broadcast(JSON.stringify({'type': 'pesan', 'username': data['username'] ,'value': data['value']}));
            }
        }

        if(data['type'] === 'player_move'){
            //broadcast to all user
            server.broadcast(JSON.stringify({'type': 'player_move',
            'username': data['username'] ,
            'value': data['value'], 
            'position_x': data['position_x'],
            'position_y': data['position_y'],
            'position_z': data['position_z']
        }));
        users['user ' + data['username'].toString()]['position_x'] = data['position_x'];
        users['user ' + data['username'].toString()]['position_y'] = data['position_y'];
        users['user ' + data['username'].toString()]['position_z'] = data['position_z'];
            console.log(users['user ' + data['username'].toString()]);
        }
        
        if(data['type'] === 'dc'){
            //broadcast to all user
            console.log(data['username'])
        }

    })

    ws.on('close',(code, reason) => {
        console.log(`disconnected: ${code} ${reason} id: ${ws.uuid}`);
        delete users['user '+ws.uuid.toString()];
        server.broadcast(JSON.stringify({'type': 'player_close', 
        'username': ws.uuid,
       }));
    })

    //proses tambah user
    ws.uuid = userNumber

    var user = {
        'username': userNumber,
        'position_x': 3.599999,
        'position_y': 3.48847,
        'position_z': -4.863132,
    }

    users["user "+userNumber.toString()] = user;

    ws.send(JSON.stringify({'type': 'userDetail',
     'value': userNumber, 
     'position_x': users["user "+userNumber.toString()]['position_x'],
     'position_y': users["user "+userNumber.toString()]['position_y'],
     'position_z': users["user "+userNumber.toString()]['position_z']
    }));
    
    //broadcast player to all user
    server.broadcast(JSON.stringify({'type': 'player_come', 
     'username': userNumber,
     'position_x': users["user "+userNumber.toString()]['position_x'],
     'position_y': users["user "+userNumber.toString()]['position_y'],
     'position_z': users["user "+userNumber.toString()]['position_z']
    }));

    console.log(users);

    //add player available untuk pas pertama join
    ws.send(JSON.stringify({'type': 'addplayer', 'usernames': users}));

    userNumber++;
})

//broadcast function
server.broadcast = function broadcast(msg) {
    console.log(msg);
    server.clients.forEach(function each(client) {
        client.send(msg);
     });
 };