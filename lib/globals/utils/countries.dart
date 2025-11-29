/// Representa la información mínima necesaria
/// para manejar:
/// - selección de país
/// - prefijo telefónico
/// - bandera
///
/// Se usa principalmente en el componente PhoneField.
///
class Country {
  /// Nombre del país en inglés.
  final String name;

  /// Nombre local del país (idioma nativo).
  final String localName;

  /// Prefijo telefónico internacional.
  /// Ej: "+57", "+86"
  final String phoneExtension;

  /// Sufijo ISO del país.
  /// Se usa como identificador interno.
  /// Ej: "co", "us", "cn"
  final String countrySuffix;

  /// URL de la bandera del país.
  ///
  /// Normalmente se consume directamente
  /// en widgets de imagen.
  ///
  final String flagUrl;

  const Country({
    required this.name,
    required this.localName,
    required this.phoneExtension,
    required this.countrySuffix,
    required this.flagUrl,
  });
}

/// Dataset base de países.
///
/// Contiene la información necesaria para:
/// - renderizar el selector de países
/// - mostrar banderas
/// - construir números telefónicos con prefijo
///
const List<Country> countries = [
  Country(
    name: "China",
    localName: "中国",
    phoneExtension: "+86",
    countrySuffix: "cn",
    flagUrl: "https://flagcdn.com/w320/cn.png",
  ),
  Country(
    name: "Germany",
    localName: "Deutschland",
    phoneExtension: "+49",
    countrySuffix: "de",
    flagUrl: "https://flagcdn.com/w320/de.png",
  ),
  Country(
    name: "United Kingdom",
    localName: "United Kingdom",
    phoneExtension: "+44",
    countrySuffix: "gb",
    flagUrl: "https://flagcdn.com/w320/gb.png",
  ),
  Country(
    name: "Netherlands",
    localName: "Nederland",
    phoneExtension: "+31",
    countrySuffix: "nl",
    flagUrl: "https://flagcdn.com/w320/nl.png",
  ),
  Country(
    name: "Russia",
    localName: "Россия",
    phoneExtension: "+7",
    countrySuffix: "ru",
    flagUrl: "https://flagcdn.com/w320/ru.png",
  ),
  Country(
    name: "Brazil",
    localName: "Brasil",
    phoneExtension: "+55",
    countrySuffix: "br",
    flagUrl: "https://flagcdn.com/w320/br.png",
  ),
  Country(
    name: "France",
    localName: "France",
    phoneExtension: "+33",
    countrySuffix: "fr",
    flagUrl: "https://flagcdn.com/w320/fr.png",
  ),
  Country(
    name: "Colombia",
    localName: "Colombia",
    phoneExtension: "+57",
    countrySuffix: "co",
    flagUrl: "https://flagcdn.com/w320/co.png",
  ),
  Country(
    name: "Canada",
    localName: "Canada",
    phoneExtension: "+1",
    countrySuffix: "ca",
    flagUrl: "https://flagcdn.com/w320/ca.png",
  ),
  Country(
    name: "United States",
    localName: "United States",
    phoneExtension: "+1",
    countrySuffix: "us",
    flagUrl: "https://flagcdn.com/w320/us.png",
  ),
  Country(
    name: "India",
    localName: "भारत",
    phoneExtension: "+91",
    countrySuffix: "in",
    flagUrl: "https://flagcdn.com/w320/in.png",
  ),
  Country(
    name: "Japan",
    localName: "日本",
    phoneExtension: "+81",
    countrySuffix: "jp",
    flagUrl: "https://flagcdn.com/w320/jp.png",
  ),
  Country(
    name: "Mexico",
    localName: "México",
    phoneExtension: "+52",
    countrySuffix: "mx",
    flagUrl: "https://flagcdn.com/w320/mx.png",
  ),
  Country(
    name: "Australia",
    localName: "Australia",
    phoneExtension: "+61",
    countrySuffix: "au",
    flagUrl: "https://flagcdn.com/w320/au.png",
  ),
  Country(
    name: "Italy",
    localName: "Italia",
    phoneExtension: "+39",
    countrySuffix: "it",
    flagUrl: "https://flagcdn.com/w320/it.png",
  ),
  Country(
    name: "Spain",
    localName: "España",
    phoneExtension: "+34",
    countrySuffix: "es",
    flagUrl: "https://flagcdn.com/w320/es.png",
  ),
  Country(
    name: "South Korea",
    localName: "대한민국",
    phoneExtension: "+82",
    countrySuffix: "kr",
    flagUrl: "https://flagcdn.com/w320/kr.png",
  ),
  Country(
    name: "Indonesia",
    localName: "Indonesia",
    phoneExtension: "+62",
    countrySuffix: "id",
    flagUrl: "https://flagcdn.com/w320/id.png",
  ),
  Country(
    name: "Turkey",
    localName: "Türkiye",
    phoneExtension: "+90",
    countrySuffix: "tr",
    flagUrl: "https://flagcdn.com/w320/tr.png",
  ),
  Country(
    name: "Vietnam",
    localName: "Việt Nam",
    phoneExtension: "+84",
    countrySuffix: "vn",
    flagUrl: "https://flagcdn.com/w320/vn.png",
  ),
  Country(
    name: "Poland",
    localName: "Polska",
    phoneExtension: "+48",
    countrySuffix: "pl",
    flagUrl: "https://flagcdn.com/w320/pl.png",
  ),
  Country(
    name: "Thailand",
    localName: "ประเทศไทย",
    phoneExtension: "+66",
    countrySuffix: "th",
    flagUrl: "https://flagcdn.com/w320/th.png",
  ),
  Country(
    name: "Argentina",
    localName: "Argentina",
    phoneExtension: "+54",
    countrySuffix: "ar",
    flagUrl: "https://flagcdn.com/w320/ar.png",
  ),
  Country(
    name: "South Africa",
    localName: "South Africa",
    phoneExtension: "+27",
    countrySuffix: "za",
    flagUrl: "https://flagcdn.com/w320/za.png",
  ),
  Country(
    name: "Ukraine",
    localName: "Україна",
    phoneExtension: "+380",
    countrySuffix: "ua",
    flagUrl: "https://flagcdn.com/w320/ua.png",
  ),
  Country(
    name: "Malaysia",
    localName: "Malaysia",
    phoneExtension: "+60",
    countrySuffix: "my",
    flagUrl: "https://flagcdn.com/w320/my.png",
  ),
  Country(
    name: "Philippines",
    localName: "Pilipinas",
    phoneExtension: "+63",
    countrySuffix: "ph",
    flagUrl: "https://flagcdn.com/w320/ph.png",
  ),
  Country(
    name: "Sweden",
    localName: "Sverige",
    phoneExtension: "+46",
    countrySuffix: "se",
    flagUrl: "https://flagcdn.com/w320/se.png",
  ),
  Country(
    name: "Belgium",
    localName: "België",
    phoneExtension: "+32",
    countrySuffix: "be",
    flagUrl: "https://flagcdn.com/w320/be.png",
  ),
  Country(
    name: "Switzerland",
    localName: "Schweiz",
    phoneExtension: "+41",
    countrySuffix: "ch",
    flagUrl: "https://flagcdn.com/w320/ch.png",
  ),
  Country(
    name: "Saudi Arabia",
    localName: "المملكة العربية السعودية",
    phoneExtension: "+966",
    countrySuffix: "sa",
    flagUrl: "https://flagcdn.com/w320/sa.png",
  ),
  Country(
    name: "Egypt",
    localName: "مصر",
    phoneExtension: "+20",
    countrySuffix: "eg",
    flagUrl: "https://flagcdn.com/w320/eg.png",
  ),
  Country(
    name: "Portugal",
    localName: "Portugal",
    phoneExtension: "+351",
    countrySuffix: "pt",
    flagUrl: "https://flagcdn.com/w320/pt.png",
  ),
  Country(
    name: "Greece",
    localName: "Ελλάδα",
    phoneExtension: "+30",
    countrySuffix: "gr",
    flagUrl: "https://flagcdn.com/w320/gr.png",
  ),
  Country(
    name: "Norway",
    localName: "Norge",
    phoneExtension: "+47",
    countrySuffix: "no",
    flagUrl: "https://flagcdn.com/w320/no.png",
  ),
  Country(
    name: "Denmark",
    localName: "Danmark",
    phoneExtension: "+45",
    countrySuffix: "dk",
    flagUrl: "https://flagcdn.com/w320/dk.png",
  ),
  Country(
    name: "Finland",
    localName: "Suomi",
    phoneExtension: "+358",
    countrySuffix: "fi",
    flagUrl: "https://flagcdn.com/w320/fi.png",
  ),
  Country(
    name: "Austria",
    localName: "Österreich",
    phoneExtension: "+43",
    countrySuffix: "at",
    flagUrl: "https://flagcdn.com/w320/at.png",
  ),
  Country(
    name: "Ireland",
    localName: "Éire",
    phoneExtension: "+353",
    countrySuffix: "ie",
    flagUrl: "https://flagcdn.com/w320/ie.png",
  ),
  Country(
    name: "New Zealand",
    localName: "Aotearoa",
    phoneExtension: "+64",
    countrySuffix: "nz",
    flagUrl: "https://flagcdn.com/w320/nz.png",
  ),
  Country(
    name: "Czech Republic",
    localName: "Česká republika",
    phoneExtension: "+420",
    countrySuffix: "cz",
    flagUrl: "https://flagcdn.com/w320/cz.png",
  ),
  Country(
    name: "Hungary",
    localName: "Magyarország",
    phoneExtension: "+36",
    countrySuffix: "hu",
    flagUrl: "https://flagcdn.com/w320/hu.png",
  ),
  Country(
    name: "Romania",
    localName: "România",
    phoneExtension: "+40",
    countrySuffix: "ro",
    flagUrl: "https://flagcdn.com/w320/ro.png",
  ),
  Country(
    name: "Slovakia",
    localName: "Slovensko",
    phoneExtension: "+421",
    countrySuffix: "sk",
    flagUrl: "https://flagcdn.com/w320/sk.png",
  ),
  Country(
    name: "Bulgaria",
    localName: "България",
    phoneExtension: "+359",
    countrySuffix: "bg",
    flagUrl: "https://flagcdn.com/w320/bg.png",
  ),
  Country(
    name: "Serbia",
    localName: "Србија",
    phoneExtension: "+381",
    countrySuffix: "rs",
    flagUrl: "https://flagcdn.com/w320/rs.png",
  ),
  Country(
    name: "Slovenia",
    localName: "Slovenija",
    phoneExtension: "+386",
    countrySuffix: "si",
    flagUrl: "https://flagcdn.com/w320/si.png",
  ),
  Country(
    name: "Croatia",
    localName: "Hrvatska",
    phoneExtension: "+385",
    countrySuffix: "hr",
    flagUrl: "https://flagcdn.com/w320/hr.png",
  ),
  Country(
    name: "Lithuania",
    localName: "Lietuva",
    phoneExtension: "+370",
    countrySuffix: "lt",
    flagUrl: "https://flagcdn.com/w320/lt.png",
  ),
  Country(
    name: "Latvia",
    localName: "Latvija",
    phoneExtension: "+371",
    countrySuffix: "lv",
    flagUrl: "https://flagcdn.com/w320/lv.png",
  ),
  Country(
    name: "Estonia",
    localName: "Eesti",
    phoneExtension: "+372",
    countrySuffix: "ee",
    flagUrl: "https://flagcdn.com/w320/ee.png",
  ),
  Country(
    name: "Iceland",
    localName: "Ísland",
    phoneExtension: "+354",
    countrySuffix: "is",
    flagUrl: "https://flagcdn.com/w320/is.png",
  ),
  Country(
    name: "Luxembourg",
    localName: "Lëtzebuerg",
    phoneExtension: "+352",
    countrySuffix: "lu",
    flagUrl: "https://flagcdn.com/w320/lu.png",
  ),
  Country(
    name: "Malta",
    localName: "Malta",
    phoneExtension: "+356",
    countrySuffix: "mt",
    flagUrl: "https://flagcdn.com/w320/mt.png",
  ),
  Country(
    name: "Cyprus",
    localName: "Κύπρος",
    phoneExtension: "+357",
    countrySuffix: "cy",
    flagUrl: "https://flagcdn.com/w320/cy.png",
  ),
  Country(
    name: "Lebanon",
    localName: "لبنان",
    phoneExtension: "+961",
    countrySuffix: "lb",
    flagUrl: "https://flagcdn.com/w320/lb.png",
  ),
  Country(
    name: "United Arab Emirates",
    localName: "الإمارات العربية المتحدة",
    phoneExtension: "+971",
    countrySuffix: "ae",
    flagUrl: "https://flagcdn.com/w320/ae.png",
  ),
  Country(
    name: "Qatar",
    localName: "قطر",
    phoneExtension: "+974",
    countrySuffix: "qa",
    flagUrl: "https://flagcdn.com/w320/qa.png",
  ),
  Country(
    name: "Kuwait",
    localName: "الكويت",
    phoneExtension: "+965",
    countrySuffix: "kw",
    flagUrl: "https://flagcdn.com/w320/kw.png",
  ),
  Country(
    name: "Bahrain",
    localName: "البحرين",
    phoneExtension: "+973",
    countrySuffix: "bh",
    flagUrl: "https://flagcdn.com/w320/bh.png",
  ),
  Country(
    name: "Jordan",
    localName: "الأردن",
    phoneExtension: "+962",
    countrySuffix: "jo",
    flagUrl: "https://flagcdn.com/w320/jo.png",
  ),
  Country(
    name: "Pakistan",
    localName: "پاکستان",
    phoneExtension: "+92",
    countrySuffix: "pk",
    flagUrl: "https://flagcdn.com/w320/pk.png",
  ),
  Country(
    name: "Bangladesh",
    localName: "বাংলাদেশ",
    phoneExtension: "+880",
    countrySuffix: "bd",
    flagUrl: "https://flagcdn.com/w320/bd.png",
  ),
  Country(
    name: "Nigeria",
    localName: "Nigeria",
    phoneExtension: "+234",
    countrySuffix: "ng",
    flagUrl: "https://flagcdn.com/w320/ng.png",
  ),
  Country(
    name: "Kenya",
    localName: "Kenya",
    phoneExtension: "+254",
    countrySuffix: "ke",
    flagUrl: "https://flagcdn.com/w320/ke.png",
  ),
];
