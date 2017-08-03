'use strict';

let handler = (evt ,ctx, cbx) => {
   let response = {
       context: "api.devschile.com/deploy/fn2",
       count: 1,
       values: [
           {
               name : "Huemul Ql",
               id: "98765432-1",
               address: {
                   street: "DevsChile",
                   number: "S/N",
                   office: 5,
                   floor: -15
               }
           }
       ]
   };

   cbx(null, response);
};

exports.handler = handler;

