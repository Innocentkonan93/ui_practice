enum CallType {
  incoming, // Appel entrant
  outgoing, // Appel sortant
  missed, // Appel manqué
  rejected, // Appel rejeté
}

class CallLog {
  final String contactName;
  final String phoneNumber;
  final CallType callType; // incoming, outgoing, missed
  final DateTime callDate; // ✅ Date complète de l'appel

  final Duration callDuration; // Format : "1 min 30 sec"
  final bool isSavedContact;
  final int simSlot; // 1 ou 2 pour SIM 1 et SIM 2

  CallLog({
    required this.contactName,
    required this.phoneNumber,
    required this.callType,
    required this.callDate,
    required this.callDuration,
    required this.isSavedContact,
    required this.simSlot,
  });
}

List<CallLog> dummyCallLogs = [
  CallLog(
    contactName: "Jean Kouadio",
    phoneNumber: "+225 0749566561",
    callType: CallType.outgoing,
    callDate: DateTime(2025, 2, 25, 8, 45),
    callDuration: Duration(minutes: 2, seconds: 10),
    isSavedContact: true,
    simSlot: 1,
  ),
  CallLog(
    contactName: "+225 0555123456",
    phoneNumber: "+225 0555123456",
    callType: CallType.rejected,
    callDate: DateTime(2025, 2, 24, 22, 10),
    callDuration: Duration(seconds: 0),
    isSavedContact: false,
    simSlot: 2,
  ),
  CallLog(
    contactName: "Serge N’Guessan",
    phoneNumber: "+225 0102030405",
    callType: CallType.incoming,
    callDate: DateTime(2025, 2, 24, 18, 30),
    callDuration: Duration(minutes: 5, seconds: 42),
    isSavedContact: true,
    simSlot: 1,
  ),
  CallLog(
    contactName: "MTN Service",
    phoneNumber: "800",
    callType: CallType.outgoing,
    callDate: DateTime(2025, 2, 24, 14, 10),
    callDuration: Duration(minutes: 3, seconds: 15),
    isSavedContact: true,
    simSlot: 2,
  ),
  CallLog(
    contactName: "Orange Assistance",
    phoneNumber: "900",
    callType: CallType.incoming,
    callDate: DateTime(2025, 2, 25, 10, 5),
    callDuration: Duration(minutes: 4, seconds: 5),
    isSavedContact: true,
    simSlot: 1,
  ),
  CallLog(
    contactName: "Fatim Cissé",
    phoneNumber: "+225 0766778899",
    callType: CallType.missed,
    callDate: DateTime(2025, 2, 25, 11, 50),
    callDuration: Duration(seconds: 0),
    isSavedContact: true,
    simSlot: 2,
  ),
];
