String ellipsisText(String text) {
  if (text.length > 20) {
    return '${text.substring(0, 20)}...';
  } else {
    return text;
  }
}

String ellipsisName(String name, {int length = 20}) {
  if (name.length > 20) {
    var names = name.split(" ");
    var ellipsis = "${names[0]} ";

    for (var i = 1; i < names.length - 1; i++) {
      if (["de", "da", "do", "dos", "das", "e"].contains(names[i])) {
        ellipsis += "${names[i]} ";
        continue;
      }

      ellipsis += "${names[i][0]}. ";
    }

    ellipsis += names[names.length - 1];

    return ellipsis;
  }

  return name;
}