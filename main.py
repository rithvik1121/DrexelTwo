import os
from flask import Flask, render_template, request, redirect, url_for
from firebase_admin import credentials, firestore, initialize_app
from utilities import User, Post
from pyrebase import pyrebase
from datetime import datetime

app = Flask(__name__, template_folder='templates', static_folder='static')

cred = credentials.Certificate('topsecretInformation/key.json')

firebaseConfig = {
    'apiKey': "AIzaSyDR8i_6DOSc2zsrH_IAHqu1dcsX0bdXak4",
    'authDomain': "drexeltwo-e5a4b.firebaseapp.com",
    'databaseURL': "https://drexeltwo-e5a4b-default-rtdb.firebaseio.com",
    'projectId': "drexeltwo-e5a4b",
    'storageBucket': "drexeltwo-e5a4b.appspot.com",
    'messagingSenderId': "535339190665",
    'appId': "1:535339190665:web:dbdec58e56247ff1cdf958",
    'measurementId': "G-BC2R846YQF"
}

initialize_app(cred)

pyre = pyrebase.initialize_app(firebaseConfig)
auth = pyre.auth()

db = firestore.client()

global_user = 'bruh'


@app.route('/upload_post', methods=["POST", "GET"])
def upload_post():
    post_content = request.form['post']
    post = Post(content=post_content,
                userID=global_user.uid,
                username=global_user.username,
                uploadTime=datetime.now())
    post_section = request.form['section']
    post_doc = db.collection(post_section).document()
    post.postID = post_doc.id
    post_doc.set(post.to_json())
    return redirect(
        'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/home'
    )


@app.route('/', methods=["POST", "GET"])
def login_page():

    return render_template('login.html')


@app.route('/login', methods=["POST", "GET"])
def login():
    un_concatenated = request.form['user']
    username = un_concatenated + '@drexel.edu'
    password = request.form['pass']
    user = auth.sign_in_with_email_and_password(username, password)
    print(user)
    global global_user
    global_user = User(uid=user['localId'],
                       username=(user['email'].split('@'))[0],
                       name=db.collection('users').document(
                           user['localId']).get().to_dict()['name'])
    print(global_user.to_json())
    return redirect(
        'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/home'
    )


@app.route('/3', methods=["GET"])
def page_two():
    result = 'me'
    return render_template('fml.html', user=result)


@app.route('/profile', methods=["GET"])
def profile_page():
    return render_template('profile.html')


@app.route('/home', methods=["GET"])
def home_page():
    print('login successful')
    return render_template('home.html')


@app.route('/register', methods=["POST", "GET"])
def register_page():

    return render_template('register.html')


@app.route('/registration', methods=["POST", "GET"])
def registration():
    email = request.form['username']
    password = request.form['pass']
    name = request.form['name']
    auth.create_user_with_email_and_password(email=(email + '@drexel.edu'),
                                             password=password)
    user = User(username=email, name=name)
    doc = db.collection('users').document()
    user.uid = doc.id
    doc.set(user.to_json())
    return redirect(
        'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/home'
    )


@app.route('/post_page', methods=["GET", "POST"])
def post():
    return render_template('post_page.html')


@app.route('/media', methods=["GET", "POST"])
def retrieve_media():
    global global_user
    result = db.collection('media').get()
    content = []
    user = []
    upload_time = []
    likes_count = []
    has_liked_pos = []
    names = []
    post_ids = []

    for document in result:
        content.append(document.to_dict()['content'])
        user.append(document.to_dict()['username'])
        upload_time.append(document.to_dict()['uploadTime'])
        likes_count.append(len(document.to_dict()['likes']))
        has_liked_pos.append(
            global_user.username in document.to_dict()['likes'])
        names.append(
            db.collection('users').document(
                document.to_dict()['userID']).get().to_dict()['name'])
        doc = document.reference
        print(doc.id)
        post_ids.append(doc.id)

        if (request.method == "POST"):
            if (request.form["like"] == "Like"):
                doc.update(
                    {'likes': firestore.ArrayUnion([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/media'
                )
            elif (request.form["like"] == "Unlike"):
                doc.update(
                    {"likes": firestore.ArrayRemove([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/media'
                )

    return render_template('fkhm.html',
                           length=len(result),
                           content=content,
                           user=user,
                           names=names,
                           uploadTime=upload_time,
                           has_liked=has_liked_pos,
                           likes_count=likes_count,
                           post_ids=post_ids)


@app.route('/clubs')
def retrieve_clubs():
    result = db.collection('clubs').get()
    content = []
    user = []
    for document in result:
        print(document.to_dict())
        content.append(document.to_dict()['content'])
        user.append(document.to_dict()['username'])
    return render_template('display_posts.html',
                           section="Clubs",
                           length=len(result),
                           content=content,
                           user=user)


@app.route('/community', methods=["GET", "POST"])
def retrieve_community():
    global global_user
    result = db.collection('community').get()
    content = []
    user = []
    upload_time = []
    likes_count = []
    has_liked_pos = []
    names = []
    post_ids = []

    for document in result:
        content.append(document.to_dict()['content'])
        user.append(document.to_dict()['username'])
        upload_time.append(document.to_dict()['uploadTime'])
        likes_count.append(len(document.to_dict()['likes']))
        has_liked_pos.append(
            global_user.username in document.to_dict()['likes'])
        names.append(
            db.collection('users').document(
                document.to_dict()['userID']).get().to_dict()['name'])
        doc = document.reference
        print(doc.id)
        post_ids.append(doc.id)

        if (request.method == "POST"):
            if (request.form["like"] == "Like"):
                doc.update(
                    {'likes': firestore.ArrayUnion([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/community'
                )
            elif (request.form["like"] == "Unlike"):
                doc.update(
                    {"likes": firestore.ArrayRemove([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/community'
                )

    return render_template('templates/fkhm.html',
                           length=len(result),
                           content=content,
                           user=user,
                           names=names,
                           uploadTime=upload_time,
                           has_liked=has_liked_pos,
                           likes_count=likes_count,
                           post_ids=post_ids)


@app.route('/dining')
def retrieve_dining():
    global global_user
    result = db.collection('dining').get()
    content = []
    user = []
    upload_time = []
    likes_count = []
    has_liked_pos = []
    names = []
    post_ids = []

    for document in result:
        content.append(document.to_dict()['content'])
        user.append(document.to_dict()['username'])
        upload_time.append(document.to_dict()['uploadTime'])
        likes_count.append(len(document.to_dict()['likes']))
        has_liked_pos.append(
            global_user.username in document.to_dict()['likes'])
        names.append(
            db.collection('users').document(
                document.to_dict()['userID']).get().to_dict()['name'])
        doc = document.reference
        print(doc.id)
        post_ids.append(doc.id)

        if (request.method == "POST"):
            if (request.form["like"] == "Like"):
                print(doc.id)
                doc.update(
                    {'likes': firestore.ArrayUnion([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/dining'
                )
            elif (request.form["like"] == "Unlike"):
                doc.update(
                    {"likes": firestore.ArrayRemove([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/dining'
                )

    return render_template('fkhm.html',
                           length=len(result),
                           content=content,
                           user=user,
                           names=names,
                           uploadTime=upload_time,
                           has_liked=has_liked_pos,
                           likes_count=likes_count,
                           post_ids=post_ids)


@app.route('/temp_posts')
def temporary_posts():
    return render_template('fkhm.html')


app.run(host='0.0.0.0', port=8080)
