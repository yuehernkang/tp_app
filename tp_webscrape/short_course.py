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


class ShortCourseCategory():
    def __init__(self, category_name, list_of_courses):
        self.category_name = category_name
        self.list_of_courses = list_of_courses

    def __str__(self):
        s = ",".join(map(str, self.list_of_courses))

        return '{category_name:' + self.category_name + ', list_of_courses: %s}' % (s)

    # def __repr__(self):
    #     return self.__str__()


class ShortCourse:
    def __init__(self, course_name, course_overview, course_outline, course_url):
        self.course_name = course_name
        self.course_overview = course_overview
        self.course_outline = course_outline
        self.course_url = course_url

    def __str__(self):
        return '{course_name: %s\ncourse_overview: %s\ncourse_overview_html:%s}' % (
            self.course_name, self.course_overview, self.course_outline)


class AddShortCourseToFirebase:
    def __init__(self, short_course_url):
        self.short_course_url = short_course_url

    def extract_data(self):
        course_outline_html = u""
        page = requests.get(self.short_course_url)
        soup = BeautifulSoup(page.content, 'html.parser')
        who_should_attend = soup.find_all("div", {"id": "tab1"})[0].find(
            string="Who Should Attend").parent.next_sibling.next_sibling.get_text()
        course_overview = soup.find_all("div", {"id": "tab1"})[0].p.getText()
        # course_outline = soup.find_all("div", {"id": "tab2"})[0].find(
        #     string="Course Outline").parent.next_sibling.next_sibling
        for tag in soup.find_all("div", {"id": "tab2"})[0].find(
                string="Course Outline").parent.next_siblings:
            if tag.name == "h3":
                break
            else:
                course_outline_html += unicode(tag)
        short_course = ShortCourse("Hello", course_overview, course_outline_html, self.short_course_url)
        print(short_course)
        return short_course




# page = requests.get(
#     "https://www.tp.edu.sg/courses/part-time-courses/short-courses")
# soup = BeautifulSoup(page.content, 'html.parser')
# first_row = soup.find_all("div", {"class": "span12 fullcontent"})[0].find_all(
#     "div", {"class": "row-fluid"})[3].find_all("div", {"class": "span4"})
# second_row = soup.find_all("div", {"class": "span12 fullcontent"})[
#     0].find_all("div", {"class": "row-fluid"})[4].find_all("div", {"class": "span4"})
# third_row = soup.find_all("div", {"class": "span12 fullcontent"})[
#     0].find_all("div", {"class": "row-fluid"})[5].find_all("div", {"class": "span4"})

biz_and_finance = [
    "https://www.tp.edu.sg/courses/part-time-courses/short-courses/basic-statistical-techniques",
    "https://www.tp.edu.sg/courses/part-time-courses/short-courses/driving-creativity-in-your-business",
    "https://www.tp.edu.sg/courses/part-time-courses/short-courses/exe-finance-managers"
]

for url in biz_and_finance:
    AddShortCourseToFirebase(url).extract_data()

# WORKING FOR FIRST ROW
# for sibling in first_row:
#     list_of_courses = []
#     category_title = sibling.h2.getText()
#     for courses in sibling.find_all("li"):
#         print(courses.a.get_text())
#         list_of_courses.append(courses.a.get_text())

#     courseObject = ShortCourse(category_title, list_of_courses)
#     print(courseObject)

# WORKING FOR SECOND ROW
# for sibling in second_row:
#     list_of_courses = []
#     category_title = sibling.h2.getText()
#     for courses in sibling.find_all("li"):
#         courses_name = courses.a.get_text()
#         courses_url = 'http://www.tp.edu.sg' + courses.a['href']
#         page = requests.get(courses_url)
#         soup = BeautifulSoup(page.content, 'html.parser')
#         print(soup.find_all("div", {"class": "tab-content"}))

# #WORKING FOR THIRD ROW
# for sibling in third_row:
#     list_of_courses = []
#     category_title = sibling.h2.getText()
#     for courses in sibling.find_all("li"):
#         print(courses.a.get_text())
#         list_of_courses.append(courses.a.get_text())

#     courseObject = ShortCourse(category_title, list_of_courses)
#     print(courseObject)

# def AddToFirebase():
