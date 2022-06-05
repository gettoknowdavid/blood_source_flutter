import 'package:blood_source/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum ContactType { call, email, whatsapp, telegram, none }

class ContactButtonModel {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final dynamic action;
  final ContactType contactType;

  ContactButtonModel(
    this.title,
    this.icon,
    this.backgroundColor,
    this.action,
    this.contactType,
  );
}

final List<ContactButtonModel> contactButtonList = <ContactButtonModel>[
  ContactButtonModel(
    'Call',
    PhosphorIcons.phoneCallBold,
    const Color(0xFFFA6393),
    Routes.requestListView,
    ContactType.call,
  ),
  ContactButtonModel(
    'Email',
    PhosphorIcons.atBold,
    const Color(0xFFFA6393),
    Routes.myRequestsListView,
    ContactType.email,
  ),
  ContactButtonModel(
    'WhatsApp',
    PhosphorIcons.whatsappLogoBold,
    const Color(0xFF00CC99),
    Routes.donateView,
    ContactType.whatsapp,
  ),
  ContactButtonModel(
    'Telegram',
    PhosphorIcons.telegramLogoBold,
    const Color(0xFF999999),
    Routes.donateView,
    ContactType.telegram,
  ),
];
