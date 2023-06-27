import 'package:flutter/material.dart';

import 'generic_dialogs.dart';

Future<bool> reMoveFavDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "ແນ່ໃຈແລ້ວບໍ?",
    content: "ທ່ານກຳລັງຢືນຢັນການລົບລາຍການນີ້ອອກຈາກປື້ມທີ່ທ່ານມັກ",
    optionsBuilder: () => {
      'ຍົກເລີກ': false,
      'ລົບ': true,
    },
  ).then((value) => value ?? false);
}
