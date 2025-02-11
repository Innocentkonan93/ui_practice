class Contact {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String avatarUrl;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.avatarUrl,
  });
}

List<Contact> dummyContacts = [
  Contact(
    id: '1',
    name: 'Jean Dupont',
    phone: '+225 07 12 34 56 78',
    email: 'jean.dupont@example.com',
    avatarUrl: 'assets/avatars/10.png',
  ),
  Contact(
    id: '2',
    name: 'Awa Koné',
    phone: '+225 05 98 76 54 32',
    email: 'awa.kone@example.com',
    avatarUrl: 'assets/avatars/3.png',
  ),
  Contact(
    id: '3',
    name: 'Moussa Traoré',
    phone: '+225 01 22 33 44 55',
    email: 'moussa.traore@example.com',
    avatarUrl: 'assets/avatars/7.png',
  ),
  Contact(
    id: '4',
    name: 'Fatou Bamba',
    phone: '+225 07 66 55 44 33',
    email: 'fatou.bamba@example.com',
    avatarUrl: 'assets/avatars/4.png',
  ),
  Contact(
    id: '5',
    name: 'Koffi Kouadio',
    phone: '+225 05 11 22 33 44',
    email: 'koffi.kouadio@example.com',
    avatarUrl: 'assets/avatars/5.png',
  ),
];
