import requests
from bs4 import BeautifulSoup
import re
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from idna import unicode

cred = credentials.Certificate(
    'tp-app-aff2e-firebase-adminsdk-v0eyn-a5f556b175.json')
firebase_admin.initialize_app(cred)

# soup = BeautifulSoup(open("Micro-Learning.html", encoding='utf8'), "html.parser")

page = requests.get("https://www.tp.edu.sg/courses/part-time-courses/micro-learning-courses")
soup = BeautifulSoup(page.content, 'html.parser')
tabContent = soup.find('div', {"class": "tab-content"})

tabData = tabContent.find(id='tab8').find('div', {"class": "row-fluid"})
for litag in tabData.find('ul').findAll('li'):
    courseItem = litag.findAll('div',{"class": "thumbnail"})
    for x in courseItem:
        tpLink = "https://www.tp.edu.sg"
        courseImage = tpLink + x.div.img['src']
        courseName = x.find('div', {"class": "caption"}).p.next_element
        coursePrice = x.find('div', {"class": "caption"}).findAll('p')[1].getText()
        courseLink = x.find('div', {"class": "caption"}).findAll('p')[2].a['href']
        buyLink = x.find('div', {"class": "caption"}).findAll('p')[2].findAll('a')[1]['href']
        print(courseImage)


    # for litag in ultag.find_all('li'):
    #     print(litag.text)
# for x in range(10):
#     tabId = x + 1
#     if tabId != 2:
#         print(tabId)