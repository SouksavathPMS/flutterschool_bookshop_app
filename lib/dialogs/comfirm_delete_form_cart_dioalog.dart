import 'package:flutter/material.dart';

import 'generic_dialogs.dart';

Future<bool> comfirmDeleteFormCartDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "ແນ່ໃຈແລ້ວບໍ?",
    content: "ທ່ານກຳລັງຢືນຢັນການລົບລາຍການທີ່ເລືອກອອກຈາກກະຕ່າຂອງທ່ານ",
    optionsBuilder: () => {
      'ຍົກເລີກ': false,
      'ລົບ': true,
    },
  ).then((value) => value ?? false);
}
