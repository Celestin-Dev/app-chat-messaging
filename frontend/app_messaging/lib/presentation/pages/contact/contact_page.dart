import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/enum/appbar_variant.dart';
import 'package:app_messaging/presentation/models/contact_model.dart';
import 'package:app_messaging/presentation/pages/contact/widgets/contact_card.dart';
import 'package:app_messaging/presentation/widgets/app_bar.dart';
import 'package:app_messaging/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:app_messaging/core/constants/sizes.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => ContactPageState();
}

void _showDrawer() {
  //TODO : show drawer
}

void _onContactTap(Contact contact) {
  //TODO : liste de contact
}

void _onPressedFab() {
  //TODO : creation de contact
}

class ContactPageState extends State<ContactPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Contact> _listContact = const [
    Contact(
      name: 'Celestin Nomenjanahary',
      email: 'avotranomena04@gmail.col',
      phoneNumber: '+261341013686',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        variant: AppBarVariant.home,
        title: 'Contact',
        onDrawer: _showDrawer,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.defaultPadding,
              AppSizes.defaultPadding,
              AppSizes.defaultPadding,
              0,
            ),
            child: InputText(
              label: 'Recherche...',
              controller: _searchController,
              variant: InputTextVariant.search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding,
              ),
              itemCount: _listContact.length,
              itemBuilder: (context, index) {
                final contact = _listContact[index];
                return InkWell(
                  onTap: () => _onContactTap(contact),
                  child: ContactCard(
                    imageUrl: contact.imgUrl,
                    name: contact.name,
                    email: contact.email,
                    phoneNumber: contact.phoneNumber,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onPressedFab,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        label: Icon(
          Icons.add_outlined,
          color: AppColors.backgroundColor,
          size: 48,
        ),
      ),
    );
  }
}
