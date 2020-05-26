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


class ShortCourse:
    def __init__(self, course_name, course_overview, course_outline, who_should_attend, course_url):
        self.who_should_attend = who_should_attend
        self.course_name = course_name
        self.course_overview = course_overview
        self.course_outline = course_outline
        self.course_url = course_url

    def __str__(self):
        return '{course_name: %s, course_overview: %s, course_overview_html:%s, course_url:%s}' % (
            self.course_name, self.course_overview, self.course_outline, self.course_url)


class GetShortCourseData:
    def __init__(self, category_name, short_course_name, short_course_url):
        self.category_name = category_name
        self.short_course_name = short_course_name
        self.short_course_url = short_course_url

    def extract_data(self):
        course_outline_html = u""
        page = requests.get(self.short_course_url)
        soup = BeautifulSoup(page.content, 'html.parser')
        # who_should_attend = soup.find_all("div", {"id": "tab1"})[0].find(
        #     string="Who Should Attend").parent.next_sibling.next_sibling.get_text()
        # who_should_attend = soup.find_all("div", {"id": "tab1"})[0]\
        #     .find(text=re.split(r'who should attend', r'targeted audience', flags=re.IGNORECASE))\
        #     .next_element.next_element
        who_should_attend = soup.find_all("div", {"id": "tab1"})[0]\
            .find_all(text=re.split(r'who should attend', r'targeted audience', flags=re.IGNORECASE))
        course_name = soup.find_all("div", {"id": "tab1"})[0].find("h2").getText()
        course_overview = soup.find_all("div", {"id": "tab1"})[0].p.getText()
        print(who_should_attend)
        # course_outline = soup.find_all("div", {"id": "tab2"})[0].find(
        #     string="Course Outline").parent.next_sibling.next_sibling
        for tag in soup.find_all("div", {"id": "tab2"})[0].find(
                string="Course Outline").parent.next_siblings:
            if tag.name == "h3":
                break
            else:
                course_outline_html += unicode(tag)
        short_course = ShortCourse(course_name, course_overview, course_outline_html, who_should_attend, self.short_course_url)
        return short_course


class AddShortCourseToFirebase:
    def __init__(self, short_course_object, category_name):
        self.category_name = category_name
        self.short_course_object = short_course_object

    def add_short_course_to_firebase(self):
        db = firestore.client()
        doc_ref = db.collection(u'pt_short_courses').document()
        doc_ref.set({
            u'course_name': self.short_course_object.course_name,
            u'category_name': self.category_name,
            u'course_overview': self.short_course_object.course_overview,
            u'course_outline': str(self.short_course_object.course_outline),
            u'who_should_attend': str(self.short_course_object.who_should_attend),
            u'course_url': self.short_course_object.course_url
        })




page = requests.get(
    "https://www.tp.edu.sg/courses/part-time-courses/short-courses")
soup = BeautifulSoup(page.content, 'html.parser')
first_row = soup.find_all("div", {"class": "span12 fullcontent"})[0].find_all(
    "div", {"class": "row-fluid"})[3].find_all("div", {"class": "span4"})
second_row = soup.find_all("div", {"class": "span12 fullcontent"})[
    0].find_all("div", {"class": "row-fluid"})[4].find_all("div", {"class": "span4"})
third_row = soup.find_all("div", {"class": "span12 fullcontent"})[
    0].find_all("div", {"class": "row-fluid"})[5].find_all("div", {"class": "span4"})

biz_and_finance = [
    "https://www.tp.edu.sg/courses/part-time-courses/short-courses/basic-statistical-techniques",
    "https://www.tp.edu.sg/courses/part-time-courses/short-courses/driving-creativity-in-your-business",
    "https://www.tp.edu.sg/courses/part-time-courses/short-courses/exe-finance-managers"
]

# GetShortCourseData("GHell", "asd", "https://www.tp.edu.sg/courses/part-time-courses/short-courses/chocolate-techniques-workshop").extract_data()


# WORKING FOR FIRST ROW
# for sibling in first_row:
#     tp_link = "https://www.tp.edu.sg"
#     list_of_courses = []
#     category_name = sibling.h2.getText()
#     for courses in sibling.find_all("li"):
#         course_name = courses.a.get_text()
#         short_course_url = tp_link + courses.a['href']
#         list_of_courses.append(courses.a.get_text())
#         f = GetShortCourseData(category_name, course_name, short_course_url)
#         AddShortCourseToFirebase(f.extract_data(), category_name.strip()).add_short_course_to_firebase()
#         print(f.extract_data())
#
#     courseObject = ShortCourseCategory(category_name, list_of_courses)

# WORKING FOR SECOND ROW
for sibling in second_row:
    list_of_courses = []
    tp_link = "https://www.tp.edu.sg"
    category_name = sibling.h2.getText()
    for courses in sibling.find_all("li"):
        course_name = courses.a.get_text()
        short_course_url = tp_link + courses.a['href']
        list_of_courses.append(courses.a.get_text())
        f = GetShortCourseData(category_name, course_name, short_course_url)
        # AddShortCourseToFirebase(f.extract_data(), category_name.strip()).add_short_course_to_firebase()
        f.extract_data()

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
