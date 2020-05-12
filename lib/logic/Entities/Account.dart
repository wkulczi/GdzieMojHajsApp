import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Account extends Equatable {
  int id;
  String login, password, question, answer, role;

  Account(
      {this.id,
      @required this.login,
      @required this.password,
      this.question,
      this.answer,
      this.role});

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
        id: map["id"],
        login: map['login'],
        password: map['password'],
        question: map["question"],
        answer: map["answer"],
        role: map["role"]);
  }

  @override
  List<Object> get props => [id, login, password, question, answer, role];
}
