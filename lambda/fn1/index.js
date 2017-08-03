let uuid = require('uuid/v5');

let handler =  (evt, ctx, cbc) => {
    let response = {
        uuid: uuid("https://"+this.context, uuid.URL),
        context: "api.devschile.com/deploy/fn1",
        count: 1,
        values: [
            {
                name : "Juan Huemul",
                id: "12345678-9",
                address: {
                    street: "carmencita",
                    number: 25,
                    office: 11,
                    floor: 1
                }
            }
        ]
    };
    cbc(null,response);
};

exports.handler = handler;