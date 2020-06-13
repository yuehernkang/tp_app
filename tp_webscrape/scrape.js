const request = require("request");
const cheerio = require("cheerio");
const got = require('got');
const { post, get } = require("request");

const vgmUrl = 'https://www.tp.edu.sg/schools/eng/computer-engineering';
const eng = [
    'https://www.tp.edu.sg/schools/eng/common-engineering-programme',
    'https://www.tp.edu.sg/schools/eng/aerospace-electronics',
    'https://www.tp.edu.sg/schools/eng/aerospace-engineering',
    'https://www.tp.edu.sg/schools/eng/architectural-technology-and-building-services',
    'https://www.tp.edu.sg/schools/eng/aviation-management',
    'https://www.tp.edu.sg/schools/eng/biomedical-engineering',
    'https://www.tp.edu.sg/schools/eng/business-process-and-systems-engineering',
    'https://www.tp.edu.sg/schools/eng/computer-engineering',
    'https://www.tp.edu.sg/schools/eng/electronics',
    'https://www.tp.edu.sg/schools/eng/integrated-facility-management',
    'https://www.tp.edu.sg/schools/eng/mechatronics',
]

got(vgmUrl).then(response => {
    var list = [];

    const $ = cheerio.load(response.body);
    const courseOverviewHtml = $('#overview > .pull-left').html();
    const courseName = $('.topbanner > header > .container > .row-fluid > h1').contents()[0].nodeValue.trim();
    const imageUrl = $("#overview")[0].nextSibling().nodeValue;
    // const imageUrl = $("div['span8 pull-right']").each(function (index, element) {
    //     list.push($(element).attr('src'));
    // });;
    console.log(imageUrl);
    // console.log(list);
}).catch(err => {
    console.log(err);
});
