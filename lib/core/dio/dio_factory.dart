enum ApiType { empapps, eLearn, ePkwt }

String baseUrl(ApiType type) {
  switch (type) {
    case ApiType.empapps:
      return 'https://empapps.mitraabadimahakam.id/api/v2/';
    case ApiType.eLearn:
      return 'https://e-learning.mitraabadimahakam.id/api/v1/';
    case ApiType.ePkwt:
      return 'https://e-pkwt.mitraabadimahakam.id/api/v1/';
  }
}
