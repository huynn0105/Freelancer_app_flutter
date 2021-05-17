import 'package:freelance_app/domain/models/freelancer.dart';
import 'package:freelance_app/domain/models/user.dart';

List<String> skillsList0 = ['Flutter','OOP','Dart'];
List<String> skillsList1 = ['Web','JS','React'];
List<String> serviceList0 = ['Viết Mobile App cho web có sẵn', 'Thiết kế app theo yêu cầu'];
List<String> serviceList1 = ['Xây dựng website', 'Thiết kế website theo yêu cầu'];


Freelancer me =   Freelancer(
  avatar: 'assets/images/avatar.jpg',
  id : 10,
  name: 'Nguyễn Nhật Huy',
  money: 10000000,
  email: 'huynn0105@gmail.com',
  city: 'HCM',
  contract: 'Nguyễn Nhật Huy',
  cv: '',
  description: '''Experienced English - Vietnamese Translator & Editor
I am looking forward to becoming a great partner who will bring you a great translation & edition. I do believe that creating and sharing meaningful contents is the best way to build the good relationship with others.
I worked for an international advertising company for 1 year then quit to start freelancing full-time. I have worked as an English - Vietnamese Translator & Editor since May 2016. In my 2 years as a freelancer, I have supported at least 2 companies to improve their Content Marketing by providing a large number of great articles which were translated and edited well. I can translate English to Vietnamese in many aspects such as SEO, Marketing & Sales, Startup, Business, Travel, Books, etc...Not only can I translate English into Vietnamese, but also I am able to edit them. It can be said that translating and editing are my strengths.''',
  phoneNumber: '090909090990',
  rate: 5,
  services: serviceList0,
  skills: skillsList0,
  work: 'Lập trình mobile',
);

List<Freelancer> freelancers = [
  Freelancer(
    avatar: 'assets/images/avatar.jpg',
    id : 0,
    name: 'Nguyễn Nhật Huy',
    money: 10000000,
    email: 'huynn0105@gmail.com',
    city: 'HCM',
    contract: 'Nguyễn Nhật Huy',
    cv: '',
    description: '''Experienced English - Vietnamese Translator & Editor
I am looking forward to becoming a great partner who will bring you a great translation & edition. I do believe that creating and sharing meaningful contents is the best way to build the good relationship with others.
I worked for an international advertising company for 1 year then quit to start freelancing full-time. I have worked as an English - Vietnamese Translator & Editor since May 2016. In my 2 years as a freelancer, I have supported at least 2 companies to improve their Content Marketing by providing a large number of great articles which were translated and edited well. I can translate English to Vietnamese in many aspects such as SEO, Marketing & Sales, Startup, Business, Travel, Books, etc...Not only can I translate English into Vietnamese, but also I am able to edit them. It can be said that translating and editing are my strengths.''',
    phoneNumber: '090909090990',
    rate: 5,
    services: serviceList0,
    skills: skillsList0,
    work: 'Lập trình mobile',
  ),
  Freelancer(
    id: 1,
    avatar: 'assets/images/avatar.jpg',
    name: 'Huy Hyun',
    money: 5000000,
    email: 'boyhsky@gmail.com',
    city: 'Phú Yên',
    contract: 'Huy',
    cv: '',
    description: '''Experienced English - Vietnamese Translator & Editor
I am looking forward to becoming a great partner who will bring you a great translation & edition. I do believe that creating and sharing meaningful contents is the best way to build the good relationship with others.
I worked for an international advertising company for 1 year then quit to start freelancing full-time. I have worked as an English - Vietnamese Translator & Editor since May 2016. In my 2 years as a freelancer, I have supported at least 2 companies to improve their Content Marketing by providing a large number of great articles which were translated and edited well. I can translate English to Vietnamese in many aspects such as SEO, Marketing & Sales, Startup, Business, Travel, Books, etc...Not only can I translate English into Vietnamese, but also I am able to edit them. It can be said that translating and editing are my strengths.''',
    phoneNumber: '090909090990',
    rate: 5,
    services: serviceList1,
    skills: skillsList1,
    work: 'Lập trình Web app',
  ),
  Freelancer(
    id: 2,
    name: 'Huy Nguyễn',
    money: 15000000,
    email: 'huy@gmail.com',
    city: 'Đà nẵng',
    contract: 'Huynn',
    cv: '',
    description: '''Experienced English - Vietnamese Translator & Editor
I am looking forward to becoming a great partner who will bring you a great translation & edition. I do believe that creating and sharing meaningful contents is the best way to build the good relationship with others.
I worked for an international advertising company for 1 year then quit to start freelancing full-time. I have worked as an English - Vietnamese Translator & Editor since May 2016. In my 2 years as a freelancer, I have supported at least 2 companies to improve their Content Marketing by providing a large number of great articles which were translated and edited well. I can translate English to Vietnamese in many aspects such as SEO, Marketing & Sales, Startup, Business, Travel, Books, etc...Not only can I translate English into Vietnamese, but also I am able to edit them. It can be said that translating and editing are my strengths.''',
    phoneNumber: '090909090990',
    rate: 3,
    services: serviceList1,
    skills: skillsList1,
    work: 'Lập trình Web',
  ),
  Freelancer(
    id: 2,
    name: 'Huy Lệ',
    avatar: 'assets/images/avatar.jpg',
    money: 25000000,
    email: 'huyle@gmail.com',
    city: 'Đà nẵng',
    contract: 'HuyLe',
    cv: '',
    description: '''Experienced English - Vietnamese Translator & Editor
I am looking forward to becoming a great partner who will bring you a great translation & edition. I do believe that creating and sharing meaningful contents is the best way to build the good relationship with others.
I worked for an international advertising company for 1 year then quit to start freelancing full-time. I have worked as an English - Vietnamese Translator & Editor since May 2016. In my 2 years as a freelancer, I have supported at least 2 companies to improve their Content Marketing by providing a large number of great articles which were translated and edited well. I can translate English to Vietnamese in many aspects such as SEO, Marketing & Sales, Startup, Business, Travel, Books, etc...Not only can I translate English into Vietnamese, but also I am able to edit them. It can be said that translating and editing are my strengths.''',
    phoneNumber: '090909090990',
    rate: 4,
    services: serviceList0,
    skills: skillsList0,
    work: 'Lập trình mobile',
  )
];