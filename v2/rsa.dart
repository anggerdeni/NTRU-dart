import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'dart:convert';
import 'library/helper.dart';

String benchmark_rsa_encrypt(int count) {
  var modulus = BigInt.parse(
      '22443295143425600461722474698191469351591112238271250240618162048372590408118849360235638311183656702795342539712097920294129707391076243292418086173762925940633330342991234168431726236564392337633458901893839971862201377078306690565723943414589709384727047052996408927798812969606479118470603225430109512490908062195599093046113591576611251445554649574149250124034642525679962731499323588628165238721104800538429054148631905768994812153137397821983467234665696648423558940497948988183482062875735867110735270734591642271746702266723376772198387838736674102061479722849754497923243061107079797894406223681583406044638917420139412040280413603581323082352497475574100772626242860143849222939860898477412105850188354083303429052856371946528632820155205182382948342629012348848356418506133132031304327829116482785154680534670791567737933233270536951035469068945556784699937125684138308484839976414166417542140018305617302914229314579705585811932348549071670728238329686190570992485226866752002928535946986394693120140098841208440759062681418412652181006181993350454239606428536660083030758835325849283606108711312543001884175772729338550330405855498098674011488596744708570450131545319286093537003237658549729276971841171847655385591103841011476552912862439844322281449482810486955427197757711047995567303424440492472277207010787752861442561463692571007416800901316363492844769172140880306860951058485659774027646091212970563435845037025429204788431755466798392927630329141401753652456718676440495925194142225964075042960415556849561977629331182977406463050067853730517236394776420608457907149324732448172408024726052263364824880970988196791461376300833269671385916493041316366749849292884151561213606737644844031442515289964104275608880337942917470416523533219286672514543638803356438793085216123388512458498267574242604655646179641887673292538984619147');
  var publicExponent = BigInt.parse('65537');
  var privateExponent = BigInt.parse(
      '20660146115978248559679522995283448219807006749392015609754699122302186235589211924607718682785449576264446273415488465009763114681838194574539315788991215984839233098748205706417535801942868757029259434384475418503236478312010660265653379101914905582809447315368011209150592588253336057758693449352251505082266252533080447433847032665775925045551551166645166241710941660043519715448589225963001187909795270099080288032515416864419442714783697920262791679011573291413908340025348466623578632731024381079247736140163781959114371236880255743575823402215291340424021112951854507525661136100067507010841623429664569429071606694798521879092991023453335086414180885627744626890782790675167060133387369045611980193506925886837906446111737179518019104322192481394681988965139005539181572676122066244237455146414962638332268438541417142707623357236545680393821031317964521124665559798649070767511417627701298050220597591862488133656620938415299662449223502980681835912797531410785522773658339235185437087057522718969503195686838142268100047961286978712346474258653745818437985495912617063818105213035979393375227455623450749442176721202317839832456678459718275139451610395711075325132083728230726783861342979168470873532424483001292478288739095780454029794766645364140637233982759348362771664955132553772439309307316273781241967793877686824381633114110964248936504720028732037979991597643595476327615737157200504854969819972274948803697409554656216384288735111079661125222052830089460362214793683129320466717640000733400253110512180510574386603357599395681009287196027473709465683272571721013164747059504364950819244499464193420025356205570814953028048482141192395586310459850153858211320552329599730507411063372087042860750902913480748360538641916343907617938722080206211549388590452092222186066235846524869698414649328394727113609820166978535149940230966273');
  var p = BigInt.parse(
      '3911069330794738773986932139673337250754223461622346393458193833667342210385270522816893047763922833134165348936092484169277488287944999045772997165440921854953741588647875824670309401582298507085024050172212740489709850392888100009239650070139750024527126090268452415408128548485950448531733097728952450020169476104820988873901139348952240626383043684758868398277963959930026647959936283120590547850858332780045119601501262601761002320840925517052088413098326874245476519641996311427849335082799772635196402627834040133562551468089918270768329953762717012169148665551607119050588190413607805492769640027485321910004082276284734421214743894806497267264628002878102224214258846274737492712413580441667542380550930903916605737469493841237178491106560482526139240849254062598648795396245126683822116564097211104669255298430386982093571357483236790068673025919187011190658403531432955030717347476394525678001227430792461034738571');
  var q = BigInt.parse(
      '5738403808573004369179828161164627301179338754475293528476046046801548875191105388530813175255781715291516871039178714820101253138680116175596145682089631730302667966623229368836350540264668797413377927694362302335947798964585881407416260829102943051136023511470016894793978438769007963811621039737387067669215706370973583865521346616210985691698462437733361579480785401717916357558185315606892555969184245063990081875086585813685517485112960613069158404256093494364249858087237575655386059505809084262101024201926803707925503183315587452090625378490458758474049385316016611906278448866931788378169703790856059712791830738560452975230855601424552164641926418235113269277719149076419559522763025420810484061076996367185977640349721228749783517563802527967691385305000035738755844036406770579819840896919566271923034189060358451599950092715113784068183392545705722245278117744403216021988090135208830649423135424695973310118657');

  var publicKey = RSAPublicKey(modulus, publicExponent);
  var privKey =
      RSAPrivateKey(modulus, privateExponent, p, q);

  final plainText = new String.fromCharCodes(
      base64.decode(generateRandomBytes(16)));
  final encrypter = Encrypter(
      RSA(publicKey: publicKey, privateKey: privKey));
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    encrypter.encrypt(plainText);
  }
  return 'RSA encryption executed in ${stopwatch.elapsed}';
}

String benchmark_rsa_decrypt(int count) {
  var modulus = BigInt.parse(
      '22443295143425600461722474698191469351591112238271250240618162048372590408118849360235638311183656702795342539712097920294129707391076243292418086173762925940633330342991234168431726236564392337633458901893839971862201377078306690565723943414589709384727047052996408927798812969606479118470603225430109512490908062195599093046113591576611251445554649574149250124034642525679962731499323588628165238721104800538429054148631905768994812153137397821983467234665696648423558940497948988183482062875735867110735270734591642271746702266723376772198387838736674102061479722849754497923243061107079797894406223681583406044638917420139412040280413603581323082352497475574100772626242860143849222939860898477412105850188354083303429052856371946528632820155205182382948342629012348848356418506133132031304327829116482785154680534670791567737933233270536951035469068945556784699937125684138308484839976414166417542140018305617302914229314579705585811932348549071670728238329686190570992485226866752002928535946986394693120140098841208440759062681418412652181006181993350454239606428536660083030758835325849283606108711312543001884175772729338550330405855498098674011488596744708570450131545319286093537003237658549729276971841171847655385591103841011476552912862439844322281449482810486955427197757711047995567303424440492472277207010787752861442561463692571007416800901316363492844769172140880306860951058485659774027646091212970563435845037025429204788431755466798392927630329141401753652456718676440495925194142225964075042960415556849561977629331182977406463050067853730517236394776420608457907149324732448172408024726052263364824880970988196791461376300833269671385916493041316366749849292884151561213606737644844031442515289964104275608880337942917470416523533219286672514543638803356438793085216123388512458498267574242604655646179641887673292538984619147');
  var publicExponent = BigInt.parse('65537');
  var privateExponent = BigInt.parse(
      '20660146115978248559679522995283448219807006749392015609754699122302186235589211924607718682785449576264446273415488465009763114681838194574539315788991215984839233098748205706417535801942868757029259434384475418503236478312010660265653379101914905582809447315368011209150592588253336057758693449352251505082266252533080447433847032665775925045551551166645166241710941660043519715448589225963001187909795270099080288032515416864419442714783697920262791679011573291413908340025348466623578632731024381079247736140163781959114371236880255743575823402215291340424021112951854507525661136100067507010841623429664569429071606694798521879092991023453335086414180885627744626890782790675167060133387369045611980193506925886837906446111737179518019104322192481394681988965139005539181572676122066244237455146414962638332268438541417142707623357236545680393821031317964521124665559798649070767511417627701298050220597591862488133656620938415299662449223502980681835912797531410785522773658339235185437087057522718969503195686838142268100047961286978712346474258653745818437985495912617063818105213035979393375227455623450749442176721202317839832456678459718275139451610395711075325132083728230726783861342979168470873532424483001292478288739095780454029794766645364140637233982759348362771664955132553772439309307316273781241967793877686824381633114110964248936504720028732037979991597643595476327615737157200504854969819972274948803697409554656216384288735111079661125222052830089460362214793683129320466717640000733400253110512180510574386603357599395681009287196027473709465683272571721013164747059504364950819244499464193420025356205570814953028048482141192395586310459850153858211320552329599730507411063372087042860750902913480748360538641916343907617938722080206211549388590452092222186066235846524869698414649328394727113609820166978535149940230966273');
  var p = BigInt.parse(
      '3911069330794738773986932139673337250754223461622346393458193833667342210385270522816893047763922833134165348936092484169277488287944999045772997165440921854953741588647875824670309401582298507085024050172212740489709850392888100009239650070139750024527126090268452415408128548485950448531733097728952450020169476104820988873901139348952240626383043684758868398277963959930026647959936283120590547850858332780045119601501262601761002320840925517052088413098326874245476519641996311427849335082799772635196402627834040133562551468089918270768329953762717012169148665551607119050588190413607805492769640027485321910004082276284734421214743894806497267264628002878102224214258846274737492712413580441667542380550930903916605737469493841237178491106560482526139240849254062598648795396245126683822116564097211104669255298430386982093571357483236790068673025919187011190658403531432955030717347476394525678001227430792461034738571');
  var q = BigInt.parse(
      '5738403808573004369179828161164627301179338754475293528476046046801548875191105388530813175255781715291516871039178714820101253138680116175596145682089631730302667966623229368836350540264668797413377927694362302335947798964585881407416260829102943051136023511470016894793978438769007963811621039737387067669215706370973583865521346616210985691698462437733361579480785401717916357558185315606892555969184245063990081875086585813685517485112960613069158404256093494364249858087237575655386059505809084262101024201926803707925503183315587452090625378490458758474049385316016611906278448866931788378169703790856059712791830738560452975230855601424552164641926418235113269277719149076419559522763025420810484061076996367185977640349721228749783517563802527967691385305000035738755844036406770579819840896919566271923034189060358451599950092715113784068183392545705722245278117744403216021988090135208830649423135424695973310118657');

  var publicKey = RSAPublicKey(modulus, publicExponent);
  var privKey =
      RSAPrivateKey(modulus, privateExponent, p, q);

  final plainText = new String.fromCharCodes(
      base64.decode(generateRandomBytes(16)));
  final encrypter = Encrypter(
      RSA(publicKey: publicKey, privateKey: privKey));

  final encrypted = encrypter.encrypt(plainText);
  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    encrypter.decrypt(encrypted);
  }
  return 'RSA decryption executed in ${stopwatch.elapsed}';
}

String benchmark_rsa_key_exchange(int count) {
  var modulus = BigInt.parse(
      '22443295143425600461722474698191469351591112238271250240618162048372590408118849360235638311183656702795342539712097920294129707391076243292418086173762925940633330342991234168431726236564392337633458901893839971862201377078306690565723943414589709384727047052996408927798812969606479118470603225430109512490908062195599093046113591576611251445554649574149250124034642525679962731499323588628165238721104800538429054148631905768994812153137397821983467234665696648423558940497948988183482062875735867110735270734591642271746702266723376772198387838736674102061479722849754497923243061107079797894406223681583406044638917420139412040280413603581323082352497475574100772626242860143849222939860898477412105850188354083303429052856371946528632820155205182382948342629012348848356418506133132031304327829116482785154680534670791567737933233270536951035469068945556784699937125684138308484839976414166417542140018305617302914229314579705585811932348549071670728238329686190570992485226866752002928535946986394693120140098841208440759062681418412652181006181993350454239606428536660083030758835325849283606108711312543001884175772729338550330405855498098674011488596744708570450131545319286093537003237658549729276971841171847655385591103841011476552912862439844322281449482810486955427197757711047995567303424440492472277207010787752861442561463692571007416800901316363492844769172140880306860951058485659774027646091212970563435845037025429204788431755466798392927630329141401753652456718676440495925194142225964075042960415556849561977629331182977406463050067853730517236394776420608457907149324732448172408024726052263364824880970988196791461376300833269671385916493041316366749849292884151561213606737644844031442515289964104275608880337942917470416523533219286672514543638803356438793085216123388512458498267574242604655646179641887673292538984619147');
  var publicExponent = BigInt.parse('65537');
  var privateExponent = BigInt.parse(
      '20660146115978248559679522995283448219807006749392015609754699122302186235589211924607718682785449576264446273415488465009763114681838194574539315788991215984839233098748205706417535801942868757029259434384475418503236478312010660265653379101914905582809447315368011209150592588253336057758693449352251505082266252533080447433847032665775925045551551166645166241710941660043519715448589225963001187909795270099080288032515416864419442714783697920262791679011573291413908340025348466623578632731024381079247736140163781959114371236880255743575823402215291340424021112951854507525661136100067507010841623429664569429071606694798521879092991023453335086414180885627744626890782790675167060133387369045611980193506925886837906446111737179518019104322192481394681988965139005539181572676122066244237455146414962638332268438541417142707623357236545680393821031317964521124665559798649070767511417627701298050220597591862488133656620938415299662449223502980681835912797531410785522773658339235185437087057522718969503195686838142268100047961286978712346474258653745818437985495912617063818105213035979393375227455623450749442176721202317839832456678459718275139451610395711075325132083728230726783861342979168470873532424483001292478288739095780454029794766645364140637233982759348362771664955132553772439309307316273781241967793877686824381633114110964248936504720028732037979991597643595476327615737157200504854969819972274948803697409554656216384288735111079661125222052830089460362214793683129320466717640000733400253110512180510574386603357599395681009287196027473709465683272571721013164747059504364950819244499464193420025356205570814953028048482141192395586310459850153858211320552329599730507411063372087042860750902913480748360538641916343907617938722080206211549388590452092222186066235846524869698414649328394727113609820166978535149940230966273');
  var p = BigInt.parse(
      '3911069330794738773986932139673337250754223461622346393458193833667342210385270522816893047763922833134165348936092484169277488287944999045772997165440921854953741588647875824670309401582298507085024050172212740489709850392888100009239650070139750024527126090268452415408128548485950448531733097728952450020169476104820988873901139348952240626383043684758868398277963959930026647959936283120590547850858332780045119601501262601761002320840925517052088413098326874245476519641996311427849335082799772635196402627834040133562551468089918270768329953762717012169148665551607119050588190413607805492769640027485321910004082276284734421214743894806497267264628002878102224214258846274737492712413580441667542380550930903916605737469493841237178491106560482526139240849254062598648795396245126683822116564097211104669255298430386982093571357483236790068673025919187011190658403531432955030717347476394525678001227430792461034738571');
  var q = BigInt.parse(
      '5738403808573004369179828161164627301179338754475293528476046046801548875191105388530813175255781715291516871039178714820101253138680116175596145682089631730302667966623229368836350540264668797413377927694362302335947798964585881407416260829102943051136023511470016894793978438769007963811621039737387067669215706370973583865521346616210985691698462437733361579480785401717916357558185315606892555969184245063990081875086585813685517485112960613069158404256093494364249858087237575655386059505809084262101024201926803707925503183315587452090625378490458758474049385316016611906278448866931788378169703790856059712791830738560452975230855601424552164641926418235113269277719149076419559522763025420810484061076996367185977640349721228749783517563802527967691385305000035738755844036406770579819840896919566271923034189060358451599950092715113784068183392545705722245278117744403216021988090135208830649423135424695973310118657');

  var publicKey = RSAPublicKey(modulus, publicExponent);
  var privKey =
      RSAPrivateKey(modulus, privateExponent, p, q);

  final msg = new String.fromCharCodes(
      base64.decode(generateRandomBytes(32)));
  final encrypter = Encrypter(
      RSA(publicKey: publicKey, privateKey: privKey));

  encrypter.encrypt(msg);
  var e = encrypter.encrypt(msg);
  var d;

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < count; i++) {
    List<int> final_key = [];
    encrypter.encrypt(msg);
    d = encrypter.decrypt(e);
    final_key
      ..addAll(utf8.encode(msg))
      ..addAll(utf8.encode(d));
  }
  return 'RSA key exchange executed in ${stopwatch.elapsed}';
}

void main() async {
  // final publicKey = await parseKeyFromFile<RSAPublicKey>('keypair/public.pem');
  // final privKey = await parseKeyFromFile<RSAPrivateKey>('keypair/private.pem');

  // print(benchmark_rsa_encrypt(1000));
  // print(benchmark_rsa_decrypt(1000));
  print(benchmark_rsa_key_exchange(1000));
}
