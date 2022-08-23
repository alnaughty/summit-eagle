import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:summiteagle/models/news_model.dart';

class NewsVm {
  NewsVm._pr();
  static final NewsVm _instance = NewsVm._pr();
  static NewsVm get instance => _instance;
  final BehaviorSubject<Stream<QuerySnapshot<NewsModel>>> _subject =
      BehaviorSubject<Stream<QuerySnapshot<NewsModel>>>();
  Stream<Stream<QuerySnapshot<NewsModel>>> get stream => _subject.stream;
  Stream<QuerySnapshot<NewsModel>> get current => _subject.value;
  set(Stream<QuerySnapshot<NewsModel>> data) {
    _subject.add(data);
  }
}
