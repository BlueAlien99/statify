enum Reason { market, product, explicit }

const reasonMap = {
  'market': Reason.market,
  'product': Reason.product,
  'explicit': Reason.explicit,
};

class Restrictions {
  final Reason? reason;

  Restrictions({this.reason});

  factory Restrictions.fromJson(Map json) {
    return Restrictions(reason: reasonMap[json['reason']]);
  }
}
