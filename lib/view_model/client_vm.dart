import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:summiteagle/models/clients_model.dart';

class ClientsVm {
  ClientsVm._pr();
  static final ClientsVm _instance = ClientsVm._pr();
  static ClientsVm get instance => _instance;

  final BehaviorSubject<Stream<QuerySnapshot<ClientsModel>>> _subject =
      BehaviorSubject<Stream<QuerySnapshot<ClientsModel>>>();
  Stream<Stream<QuerySnapshot<ClientsModel>>> get stream => _subject.stream;
  Stream<QuerySnapshot<ClientsModel>> get current => _subject.value;
  void set(Stream<QuerySnapshot<ClientsModel>> data) {
    _subject.add(data);
  }
}
