import 'package:flutter/material.dart';

import 'generic_dialogs.dart';

Future<bool> confirmOrder(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "ຢືນຢັນການສັ່ງຊື້",
    content: "ທ່ານກຳລັງຢືນຢັນການສັ່ງຊື້ປື້ມຂອງທ່ານ",
    optionsBuilder: () => {
      'ຍົກເລີກ': false,
      'ສັ່ງຊື້': true,
    },
  ).then((value) => value ?? false);
}
