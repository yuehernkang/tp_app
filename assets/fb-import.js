import { firestoreImport } from 'node-firestore-import-export';
import * as firebase from 'firebase-admin';
var serviceAccount = require("admin-fb.json");

firebase.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://tp-app-aff2e.firebaseio.com",
});

const data = [    {
    "courseName": "Common Business Programme",
    "courseCode": "T01",
    "courseDetails": "Have you set your sights on a business course but need some time to explore the many possibilities it offers? Look no further! Our Common Business Programme (CBP) is specially designed to help you gain a good understanding of foundational business subjects. \n\nWhat's more—you’ll get to study various core business subjects to discover your strengths, aptitudes, interests and career aspirations before you choose your preferred diploma towards the end of your first semester!",
    "image": "assets/images/business/cbp-banner.jpg",
    "year1": "Build a good foundation in fundamental business subjects. The early exposure to TP Fundamental subjects and business subjects in the first semester will better guide you to the course you want to pursue.",
    "year2": "Here, you will deepen your engineering skills, pick up fundamental knowledge of the life sciences, and learn how engineering is used to further the development of technology in the medical and life sciences fields.",
    "year3": "You can specialise by choosing an elective in Audiometry & Hearing Devices, Clinical Laboratory Equipment, or Medical Biochemistry. Together with the Major Project and internship, you will be ready for an exciting and lucrative career upon graduation.",
    "careerProspects": "As this programme branches out into different diploma courses, it provides you with a strong foundation in business to start a meaningful career in the dynamic business landscape. \n\nDepending on which diploma course you choose to specialise in after your first semester, you will find excellent job prospects in areas such as banking and finance, digital business innovation, human resource management, international business and entrepreneurship, digital and social media marketing, e-commerce, travel and tourism and culinary and pastry arts."
},
{
    "courseName": "Accountancy & Finance",
    "courseCode": "T02",
    "courseDetails": "One is good but two is always better! This course will provide you with a dual specialisation in both accountancy and finance – giving you the ultimate flexibility when it comes to future career choices and further education options. \n\nWith the government committed to promoting Singapore as a financial centre and wealth management hub, there will always be a demand for qualified accountancy and finance professionals. Our course’s robust and technology-driven curriculum will give you the upper hand by preparing you for today’s fintech environment. \n\nYou could also clinch an invaluable internship opportunity with one of our partners, which include the Big Four accounting firms and other reputable multinational companies.",
    "image": "assets/images/business/af-banner.jpg",
    "year1": "To secure your future as a professional, first you need to get the fundamentals right. You will achieve this though modules such as Financial Accounting, Business Law, Economics & Cost Management Accounting.",
    "year2": "Increase your market value and employability prospects by gaining proficiency in high demand skills, including Corporate Accounting, Business Finance, Financial Analytics, Auditing and FinTech.",
    "year3": "Position yourself further through your choice of specialist elective modules, which will prepare you for post-diploma education and work in the Accountancy Profession or in the Financial Services Sector."
},
{
    "courseName": "Business",
    "courseCode": "T10",
    "courseDetails": "Get ready to excel in the fast-paced and dynamic world of business! With our broad-based and holistic curriculum, you will acquire a firm foundation in business, an international business outlook and an entrepreneurial mindset.\nPick from one of the four elective clusters: Banking & Finance, Digital Business Innovation, Human Resource Management & Development and International Business & Entrepreneurship. Whether you choose to start your own business or join a corporation, we will equip you with the skills to transform business with technology and prepare you to take on executive positions in a wide variety of industries. The possibilities are endless!",
    "image": "assets/images/business/bus-banner.jpg",
    "year1": "You will receive a firm foundation in fundamental engineering concepts, through lab work, study trips to companies, and hands-on learning opportunities, preparing you for specialisation in the medical and life sciences fields.",
    "year2": "Here, you will deepen your engineering skills, pick up fundamental knowledge of the life sciences, and learn how engineering is used to further the development of technology in the medical and life sciences fields.",
    "year3": "You can specialise by choosing an elective in Audiometry & Hearing Devices, Clinical Laboratory Equipment, or Medical Biochemistry. Together with the Major Project and internship, you will be ready for an exciting and lucrative career upon graduation."
}
]

const collectionRef = firebase.firestore().collection('courses/business/courseList');

firestoreImport(data, collectionRef)
    .then(() => console.log('Data was imported.'));
