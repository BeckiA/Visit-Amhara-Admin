// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyD6Zp08WbTVbCwlYQd2rvHjWJNDHfrxtTA",
    authDomain: "visit-amhara-login.firebaseapp.com",
    projectId: "visit-amhara-login",
    storageBucket: "visit-amhara-login.appspot.com",
    messagingSenderId: "166015026460",
    appId: "1:166015026460:web:102cc87d9fe26075fbe6d9",
    measurementId: "G-SYGLZ4CZV6"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

  