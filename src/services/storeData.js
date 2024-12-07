const { Firestore } = require('@google-cloud/firestore');
const accessSecret = require('../server/handler/access_secret');
 
async function storeData(id, data, accessSecret) {
  const db = new Firestore();
 
  const predictCollection = accessSecret.db.collection('predictions');
  return predictCollection.doc(id).set(data);
}
 
module.exports = storeData;