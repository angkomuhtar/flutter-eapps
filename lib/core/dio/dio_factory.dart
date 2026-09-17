enum ApiType { empapps, eLearn, ePkwt, p2h }

String baseUrl(ApiType type) {
  switch (type) {
    case ApiType.empapps:
      return 'https://empapps.mitraabadimahakam.id/api/v2/';
    // return 'http://localhost:8000/api/v2/';
    case ApiType.eLearn:
      return 'https://e-learning.mitraabadimahakam.id/api/v1/';
    case ApiType.ePkwt:
      return 'https://e-pkwt.mitraabadimahakam.id/api/v1/';
    case ApiType.p2h:
      return 'https://p2h.mitraabadimahakam.id/api/v1/';
    // return 'http://localhost/api/v1/';
  }
}
