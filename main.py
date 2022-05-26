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
    print(request.form)
    post = Post(content=post_content,
                userID=global_user.uid,
                username=global_user.username,
                uploadTime=datetime.now())
    post_section = request.form['Category']
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
    try: 
      user = auth.sign_in_with_email_and_password(username, password)
      global global_user
      print(type(db.collection('users').document()))
      global_user = User(uid=user['localId'],
                         username=(user['email'].split('@'))[0],
                         name=db.collection('users').document(
                             user['localId']).get().to_dict()['name'])
      print(global_user.to_json())
      return redirect(
          'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/home'
      )

    except:
        return render_template("login.html")



@app.route('/profile', methods=["GET"])
def profile_page():
    global global_user
    
    guser = global_user.to_json()

    usern = guser['username']
    realn = guser['name']
    foling = guser['following']
    foler = guser['followers']
    gio = guser['bio']
  
    return render_template('profile.html', username = usern, real_name = realn, following = foling, followers = foler, bio = gio)


#@app.route('/home', methods=["GET"])
#def home_page():
#    return render_template('home.html')


@app.route('/register', methods=["POST", "GET"])
def register_page():

    return render_template('register.html')


@app.route('/registration', methods=["POST", "GET"])
def registration():
    email = request.form['username']
    password = request.form['pass']
    name = request.form['name']
  
    reg_info = auth.create_user_with_email_and_password(email=(email + '@drexel.edu'),
                                             password=password)
    user = User(username=email, name=name)
    doc = db.collection('users').document(reg_info['localId'])
    user.uid = doc.id
    print(user.uid, doc.id)
    doc.set(user.to_json())
    return redirect(
        'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/home'
    )


@app.route('/post_page', methods=["GET", "POST"])
def post():
    return render_template('post_page.html')


@app.route('/home', methods=["GET", "POST"])
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


    for x in range(len(result)):
        content.append(result[x].to_dict()['content'])
        user.append(result[x].to_dict()['username'])
        upload_time.append(result[x].to_dict()['uploadTime'])
        likes_count.append(len(result[x].to_dict()['likes']))
        has_liked_pos.append(
            global_user.username in result[x].to_dict()['likes'])
        names.append(
            db.collection('users').document(
                result[x].to_dict()['userID']).get().to_dict()['name'])
        doc = result[x].reference
        print(doc.id)
        post_ids.append(doc.id)


    if (request.method == "POST"):
      
          print(request.form)
          
          if (request.form["like"] == "Like"):
            print(request.form)
            print(request.form['secretlike'])
            result[int(request.form['secretlike'])].reference.update(
                    {'likes': firestore.ArrayUnion([global_user.username])})
            return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/home'
                )
          elif (request.form["like"] == "Unlike"):
              
                result[int(request.form['secretunlike'])].reference.update(
                    {"likes": firestore.ArrayRemove([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/home'
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

@app.route('/disp_cl', methods=["GET", "POST"])
def display_cl():
    global global_user
    result = db.collection('clubs').get()
    content = []
    user = []
    upload_time = []
    likes_count = []
    has_liked_pos = []
    names = []
    post_ids = []


    for x in range(len(result)):
        content.append(result[x].to_dict()['content'])
        user.append(result[x].to_dict()['username'])
        upload_time.append(result[x].to_dict()['uploadTime'])
        likes_count.append(len(result[x].to_dict()['likes']))
        has_liked_pos.append(
            global_user.username in result[x].to_dict()['likes'])
        names.append(
            db.collection('users').document(
                result[x].to_dict()['userID']).get().to_dict()['name'])
        doc = result[x].reference
        print(doc.id)
        post_ids.append(doc.id)


    if (request.method == "POST"):
      
          print(request.form)
          
          if (request.form["like"] == "Like"):
            print(request.form)
            print(request.form['secretlike'])
            result[int(request.form['secretlike'])].reference.update(
                    {'likes': firestore.ArrayUnion([global_user.username])})
            return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/disp_cl'
                )
          elif (request.form["like"] == "Unlike"):
              
                result[int(request.form['secretunlike'])].reference.update(
                    {"likes": firestore.ArrayRemove([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/disp_cl'
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
    return render_template("clubs.html")

@app.route('/dining', methods = ["GET", "POST"])
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


    for x in range(len(result)):
        content.append(result[x].to_dict()['content'])
        user.append(result[x].to_dict()['username'])
        upload_time.append(result[x].to_dict()['uploadTime'])
        likes_count.append(len(result[x].to_dict()['likes']))
        has_liked_pos.append(
            global_user.username in result[x].to_dict()['likes'])
        names.append(
            db.collection('users').document(
                result[x].to_dict()['userID']).get().to_dict()['name'])
        doc = result[x].reference
        print(doc.id)
        post_ids.append(doc.id)


    if (request.method == "POST"):
      
          print(request.form)
          
          if (request.form["like"] == "Like"):
            print(request.form)
            print(request.form['secretlike'])
            result[int(request.form['secretlike'])].reference.update(
                    {'likes': firestore.ArrayUnion([global_user.username])})
            return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/dining'
                )
          elif (request.form["like"] == "Unlike"):
              
                result[int(request.form['secretunlike'])].reference.update(
                    {"likes": firestore.ArrayRemove([global_user.username])})
                return redirect(
                    'https://DrexelFour-or-something-idk-what-number-were-on-at-this-poi.rithviks.repl.co/dining'
                )



    return render_template('dining.html',
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
