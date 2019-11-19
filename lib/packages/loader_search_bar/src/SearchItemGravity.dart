abstract class SearchItemGravity {
  static SearchItemGravity get start => _StartItemGravity();

  static SearchItemGravity get end => _EndItemGravity();

  static SearchItemGravity exactly(int index) => _ExactlyItemGravity(index);

  int getInsertPosition(List list);
}

class _StartItemGravity extends SearchItemGravity {
  @override
  int getInsertPosition(List list) => 0;
}

class _EndItemGravity extends SearchItemGravity {
  @override
  int getInsertPosition(List list) => list.length;
}

class _ExactlyItemGravity extends SearchItemGravity {
  _ExactlyItemGravity(this.index);

  int index;

  @override
  int getInsertPosition(List list) {
    if (index < 0) return 0;
    if (index > list.length) return list.length;
    return index;
  }
}
