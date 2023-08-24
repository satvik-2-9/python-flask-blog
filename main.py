from flask import Flask, render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from datetime import datetime
from flask_mail import Mail
import os
import math
import json

# this is how python i/o works, if we wanna access another file.
with open('config.json','r')as c:
    params = json.load(c)["params"]

local_server = True
app = Flask(__name__)
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME= params['gmail-user'],
    MAIL_PASSWORD= params['gmail-password']
)
app.secret_key="super-secret-key"
app.config['UPLOAD_FOLDER'] = params['upload_location']
mail = Mail(app)

if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI']=params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, unique=False, nullable=False)
    phone_num = db.Column(db.String, nullable=False)
    mes = db.Column(db.String, nullable=False)
    date = db.Column(db.String, nullable=True)
    email  = db.Column(db.String, nullable=False)

class Posts( db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String, unique=False, nullable=False)
    slug = db.Column(db.String, nullable=False)
    content = db.Column(db.String, nullable=False)
    date = db.Column(db.String, nullable=True)
    img_file = db.Column(db.String, nullable = False)


@app.route("/")
def home():
    # pagination ka logic:
    # 1) get all the posts, 2) find the number of pages we will need., 3) find the current page that we are on
    # 4) find the posts that we have to serve in the current page.
    # 5) create the previous & next urls and how we use the information passed to figure out page number
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts) / int(params['no_of_posts']))
    # [0: params['no_of_posts']]
    # posts = posts[]

    # page ke URL se page number uthaate huye
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page - 1) * int(params['no_of_posts']): (page - 1) * int(params['no_of_posts']) + int(
        params['no_of_posts'])]
    # Pagination Logic
    # First
    if (page == 1):
        prev = "#"
        next = "/?page=" + str(page + 1)
    elif (page == last):
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)
    return render_template('index.html',params=params,posts = posts, prev=prev, next=next)



@app.route("/dashboard",methods=['GET','POST'])
def dashboard():

    if ('user' in session and session['user'] == params['admin_user']):
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method=='POST':
        #     redirect to admin panel.
        username = request.form.get('name')
        userpass = request.form.get('pass')
        if (username == params['admin_user'] and userpass == params['admin_password']):
            # set the session variable
            session['user']=username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)
        pass

    return render_template('login.html',params=params)

@app.route("/about")
def about():
    return render_template('about.html',params=params)


@app.route("/post/<string:post_slug>", methods=['GET'])
def serve_post(post_slug):
    # give me the post with the slug=the slug i have received.
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html',params=params,post=post)


@app.route("/contact",methods=['GET','POST'])
def contact():
    # therefore depending upon, request method, i can either serve static HTML to the client or
    # process the POST,DELETE,UPDATE etc backend requests, since i have already connected to the DB.
    # this right here is a FLASK REST API.
    if(request.method=='POST'):
    #     add entry to database
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name,phone_num=phone,email=email,mes=message,date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Message from ' + name,
                          sender=email,
                          recipients = [params['gmail-user']],
                          body = message + '\n' + "Phone Number: " + phone
                         )

    return render_template('contact.html',params=params)

@app.route("/edit/<string:sno>", methods = ['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno=='0':
                post = Posts(title=box_title, slug=slug, content=content, tagline=tline, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.tagline = tline
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post, sno=sno)

@app.route("/uploader", methods = ['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if (request.method == 'POST'):
            f = request.files['file1']
            # secure_filename helps in mantaining security over the directories if public upload button is provided.
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename) ))
            return "Uploaded successfully"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/delete/<string:sno>", methods = ['GET', 'POST'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')

app.run(debug=True)