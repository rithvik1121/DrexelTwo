class User():
  def __init__(self, username, uid="",bio="", followers=[], following = [], name = ''):
    self.bio=bio
    self.followers=followers
    self.following=following
    self.uid=uid
    self.username=username
    self.name=name

  def to_json(self):
    return {"uid": self.uid, "username": self.username, "bio": self.bio, "followers": self.followers, "following": self.following, "name": self.name}

class Post:
  def __init__(self, userID, uploadTime, username, likes=[], content = "", postID=''):
    self.postID=postID
    self.likes=likes
    self.userID=userID
    self.username=username
    self.content=content
    self.uploadTime=uploadTime
  
  def to_json(self):
    return {"postId": self.postID, "likes": self.likes, "userID": self.userID, "username": self.username, "content": self.content, "uploadTime": self.uploadTime}