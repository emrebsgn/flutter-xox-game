import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xoxxox/model/model_xox.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XOXOX - BSGNSOFT',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr','TR'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'XOXOX - BSGNSOFT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listGame=<ModelXOX>[
    ModelXOX(index: 0, deger: "",sonuc: ""),
    ModelXOX(index: 1, deger: "",sonuc: ""),
    ModelXOX(index: 2, deger: "",sonuc: ""),
    ModelXOX(index: 3, deger: "",sonuc: ""),
    ModelXOX(index: 4, deger: "",sonuc: ""),
    ModelXOX(index: 5, deger: "",sonuc: ""),
    ModelXOX(index: 6, deger: "",sonuc: ""),
    ModelXOX(index: 7, deger: "",sonuc: ""),
    ModelXOX(index: 8, deger: "",sonuc: ""),
  ];


  late BannerAd staticAd;
  bool statisAdloaded=false;
  static const AdRequest request=AdRequest();
  void loadStaticBannerAd(){

    staticAd=BannerAd(
        adUnitId: "XXXX",
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(
            onAdLoaded: (ad){
              setState(() {
                statisAdloaded=true;
              });
            },
            onAdFailedToLoad: (ad,error){
              ad.dispose();
              print("failed ${error.message}");
            }
        )
    );
    staticAd.load();
  }



  var gamer1="X";
  var gamer2="O";
  bool boolIsFirstMoveGamer1=true; ///İlk hamle oyuncu 1 de mi?
  bool boolIsContinue=true;




  Widget getCard({required ModelXOX prmModelXOX}){
    return GestureDetector(
      onTap: (){
        hamleYap(prmModelXOX: prmModelXOX);
      },
      child: Container(
        padding:prmModelXOX.deger=="X"? EdgeInsets.all(6):EdgeInsets.zero,
        decoration: BoxDecoration(
          color:prmModelXOX.sonuc.isEmpty?Colors.grey[200]:Colors.purple.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1,color: Colors.grey)
        ),
        child: Center(
            child: prmModelXOX.deger=="X"?Image.asset("images/letter_x_red.png"):prmModelXOX.deger=="O"?Image.asset("images/letter_o_green.png"):Text(prmModelXOX.deger)
        ),
      ),
    );
  }


  Future<void>hamleYap({required ModelXOX prmModelXOX})async{
    if(boolIsContinue){ ///Oyun Devam Ediyor
      if(boolIsFirstMoveGamer1){ ///Sıra Oyuncu 1 de ise
        if(prmModelXOX.deger==""){ ///Kutu Boşsa
          setState(() {
            prmModelXOX.deger="X"; /// Değeri yaz
            //boolIsFirstMoveGamer1=boolIsFirstMoveGamer1==true?false:true;
          });
          checkWin();
        }
      }else{ ///Sıra Oyuncu 2 de ise
        if(prmModelXOX.deger==""){ ///Kutu Boşsa
          setState(() {
            prmModelXOX.deger="O"; /// Değeri yaz
            //boolIsFirstMoveGamer1=boolIsFirstMoveGamer1==true?false:true;
          });
          checkWin();
        }
      }
    }else{
      print("Oyun Bitti");
    }




  }


  Future<void>checkWin()async{
    ///0,1,2
    ///0,3,6
    ///0,4,8

    ///1,4,7
    ///2,5,8
    ///2,4,6

    ///3,4,5
    ///6,7,8

    if(listGame[0].deger==listGame[1].deger && listGame[1].deger==listGame[2].deger && listGame[2].deger.isNotEmpty){
      setState(() {
        listGame[0].sonuc=listGame[0].deger;
        listGame[1].sonuc=listGame[0].deger;
        listGame[2].sonuc=listGame[0].deger;
        kazananOyuncu=boolIsFirstMoveGamer1?"Oyuncu 1":"Oyuncu 2";
        boolIsContinue=false;
      });
    }else if(listGame[0].deger==listGame[3].deger && listGame[3].deger==listGame[6].deger && listGame[6].deger.isNotEmpty){
      setState(() {
        listGame[0].sonuc=listGame[0].deger;
        listGame[3].sonuc=listGame[0].deger;
        listGame[6].sonuc=listGame[0].deger;
        kazananOyuncu=boolIsFirstMoveGamer1?"Oyuncu 1":"Oyuncu 2";
        boolIsContinue=false;
      });
    }else if(listGame[0].deger==listGame[4].deger && listGame[4].deger==listGame[8].deger && listGame[8].deger.isNotEmpty){
      setState(() {
        listGame[0].sonuc=listGame[0].deger;
        listGame[4].sonuc=listGame[0].deger;
        listGame[8].sonuc=listGame[0].deger;
        kazananOyuncu=boolIsFirstMoveGamer1?"Oyuncu 1":"Oyuncu 2";
        boolIsContinue=false;
      });
    }else if(listGame[1].deger==listGame[4].deger && listGame[4].deger==listGame[7].deger && listGame[7].deger.isNotEmpty){
      setState(() {
        listGame[1].sonuc=listGame[1].deger;
        listGame[4].sonuc=listGame[1].deger;
        listGame[7].sonuc=listGame[1].deger;
        kazananOyuncu=boolIsFirstMoveGamer1?"Oyuncu 1":"Oyuncu 2";
        boolIsContinue=false;
      });
    }else if(listGame[2].deger==listGame[5].deger && listGame[5].deger==listGame[8].deger && listGame[8].deger.isNotEmpty){
      setState(() {
        listGame[2].sonuc=listGame[2].deger;
        listGame[5].sonuc=listGame[2].deger;
        listGame[8].sonuc=listGame[2].deger;
        kazananOyuncu=boolIsFirstMoveGamer1?"Oyuncu 1":"Oyuncu 2";
        boolIsContinue=false;
      });
    }else if(listGame[2].deger==listGame[4].deger && listGame[4].deger==listGame[6].deger && listGame[6].deger.isNotEmpty){
      setState(() {
        listGame[2].sonuc=listGame[2].deger;
        listGame[4].sonuc=listGame[2].deger;
        listGame[6].sonuc=listGame[2].deger;
        kazananOyuncu=boolIsFirstMoveGamer1?"Oyuncu 1":"Oyuncu 2";
        boolIsContinue=false;
      });
    }else if(listGame[3].deger==listGame[4].deger && listGame[4].deger==listGame[5].deger && listGame[5].deger.isNotEmpty){
      setState(() {
        listGame[3].sonuc=listGame[3].deger;
        listGame[4].sonuc=listGame[3].deger;
        listGame[5].sonuc=listGame[3].deger;
        kazananOyuncu=boolIsFirstMoveGamer1?"Oyuncu 1":"Oyuncu 2";
        boolIsContinue=false;
      });
    }else if(listGame[6].deger==listGame[7].deger && listGame[7].deger==listGame[8].deger && listGame[8].deger.isNotEmpty){
      setState(() {
        listGame[6].sonuc=listGame[6].deger;
        listGame[7].sonuc=listGame[6].deger;
        listGame[8].sonuc=listGame[6].deger;
        kazananOyuncu=boolIsFirstMoveGamer1?"Oyuncu 1":"Oyuncu 2";
        boolIsContinue=false;
      });
    }else{
      setState(() {
        boolIsFirstMoveGamer1=boolIsFirstMoveGamer1==true?false:true;
      });
    }


  }

  String kazananOyuncu="";


  @override
  void initState() {
    loadStaticBannerAd();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF265073),//Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Text("XOXXOX",style: TextStyle(color: Colors.white),),
            Spacer(),
            Text("BSGNSOFT",style: TextStyle(color: Colors.white,fontSize: 14),),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left:20,top: 8,right: 20,bottom: 8),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Oyuncu 1:  "),
                Image.asset("images/letter_x_red.png",width: 18,),
                Spacer(),
                Text("Oyuncu 2:  "),
                Image.asset("images/letter_o_green.png",width: 20,),
              ],
            ),
            SizedBox(height: 20,),
            Flexible(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width/3,
                    childAspectRatio: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 80
                  ),
                  itemCount: 9,
                  itemBuilder: (context,index){
                    return getCard(prmModelXOX: listGame[index]);
                  }
              ),
            ),
            ///Kazanan oyuncu
            kazananOyuncu.isEmpty? Center():Container(
                padding: EdgeInsets.only(left:6,top: 6,right: 6,bottom: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kazanan: ",style: TextStyle(color: Colors.black,fontSize: 18),),
                    /*
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset("images/kutlama1.png",width: 32,)),
                    */
                    SizedBox(width: 10,),
                    Text(kazananOyuncu,style: TextStyle(color: Colors.black,fontSize: 26),),
                    SizedBox(width: 10,),
                    Container(
                        decoration: BoxDecoration(
                            //color: Colors.indigo.shade100,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset("images/kutlama2.png",width: 32,)),
                  ],
                )),
            ///Sıradaki oyuncu
            kazananOyuncu.isNotEmpty? Center():Container(
                padding: EdgeInsets.only(left:6,top: 6,right: 6,bottom: 6),
                decoration: BoxDecoration(
                  color: boolIsFirstMoveGamer1?Colors.red:Colors.green,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(boolIsFirstMoveGamer1?"OYUNCU 1":"OYUNCU 2",style: TextStyle(color: Colors.white,fontSize: 16),)),
            SizedBox(height: 10,),
            ///Yeniden
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange
                    ),
                    onPressed: (){
                      setState(() {
                        boolIsFirstMoveGamer1=true;
                        boolIsContinue=true;
                        kazananOyuncu="";
                        listGame.clear();
                        listGame=<ModelXOX>[
                          ModelXOX(index: 0, deger: "",sonuc: ""),
                          ModelXOX(index: 1, deger: "",sonuc: ""),
                          ModelXOX(index: 2, deger: "",sonuc: ""),
                          ModelXOX(index: 3, deger: "",sonuc: ""),
                          ModelXOX(index: 4, deger: "",sonuc: ""),
                          ModelXOX(index: 5, deger: "",sonuc: ""),
                          ModelXOX(index: 6, deger: "",sonuc: ""),
                          ModelXOX(index: 7, deger: "",sonuc: ""),
                          ModelXOX(index: 8, deger: "",sonuc: ""),
                        ];
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Yeniden",style: TextStyle(color: Colors.white,),),
                        SizedBox(width: 6,),
                        Icon(Icons.restart_alt,color: Colors.white,)
                      ],
                    )),
              ],
            ),
            SizedBox(height: 10,),///Reklam
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: Center(child: AdWidget(ad: staticAd)),
            ),
          ],
        ),
      )
    );
  }
}
