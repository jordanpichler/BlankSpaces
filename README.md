# 📚 BlankSpaces
### Test your coding knowledge!

<img width="170" alt="Welcome Screen" src="https://user-images.githubusercontent.com/17742020/49101170-dc8b1d00-f275-11e8-96c2-107f4df8e93e.png"><img width="170" alt="Input Screen" src="https://user-images.githubusercontent.com/17742020/49101172-dd23b380-f275-11e8-9f12-d8cd9a972615.png"><img width="170" alt="Typing" src="https://user-images.githubusercontent.com/17742020/49101698-21fc1a00-f277-11e8-9e37-faf607365fdd.png"><img width="170" alt="Solved" src="https://user-images.githubusercontent.com/17742020/49101709-26c0ce00-f277-11e8-8a97-e2e855b2a1cb.png">
<img width="170" alt="Done" src="https://user-images.githubusercontent.com/17742020/49101174-dd23b380-f275-11e8-87dc-3cb5bd62ded9.png">

#### What's all this about?
BlankSpaces is a simple app, which fetches coding lessons from a server and presents them. Upon completion of a lesson, the time when you started and finished the lesson is stored to a Realm database. 📝

This is my first try implementing the MVVM design pattern in an iOS app. I also experimented with using RxSwift/RxCocoa in here, but ran into some issues (all that was pushed to the `reactive-experiments` branch). But I also got some things to work and was actually surprised on how useful and simple the syntax was! 


#### Realm Output
See below how three solved lessons would print out:

```
[LessonCompletionEvent {
	id = 5;
	startTime = 2018-11-27 17:41:07 +0000;
	endTime = 2018-11-27 17:41:18 +0000;
}, LessonCompletionEvent {
	id = 6;
	startTime = 2018-11-27 17:41:18 +0000;
	endTime = 2018-11-27 17:41:23 +0000;
}, LessonCompletionEvent {
	id = 7;
	startTime = 2018-11-27 17:41:23 +0000;
	endTime = 2018-11-27 17:41:39 +0000;
}]
```

