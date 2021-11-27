// routes
import 'package:flutter/material.dart';

const String homeRoute = '/';
const String registerRoute = '/register';
const String meditationRoute = '/meditation';
const String loginRoute = '/login';
const String yogaRoute = '/yoga';
const String onboardingRoute = '/onboarding';

//regExp

final RegExp emailRegExp = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);
final RegExp passwordRegExp = RegExp(
  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
);

//colors

const Color circleColor = Color(0xffdde53e);
const Color blackColor = Color(0xff020202);
const Color redColor = Colors.redAccent;

//strings

const String placeHolderPhoto =
    'https://www.google.com/imgres?imgurl=https%3A%2F%2Fmedia.istockphoto.com%2Fvectors%2Favatar-5-vector-id1131164548%3Fk%3D6%26m%3D1131164548%26s%3D612x612%26w%3D0%26h%3D3-7WOnmaUlfAmYIkDVHxcOZhgfl0AeMPOgbd3xgi48c%3D&imgrefurl=https%3A%2F%2Fwww.istockphoto.com%2Fillustrations%2Favatar-placeholder&tbnid=XqXD8Jz6UiZSiM&vet=12ahUKEwjLo-fvqpDyAhU4u5UCHWA4CcMQMygHegUIARDFAQ..i&docid=sgp1kxojEO3MVM&w=612&h=612&q=avatar%20placeholder&ved=2ahUKEwjLo-fvqpDyAhU4u5UCHWA4CcMQMygHegUIARDFAQ';
