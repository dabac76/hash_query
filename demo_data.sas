DATA WORK.CARS;
    LENGTH
        Make             $ 13
        Model            $ 40
        Type             $ 6
        Origin           $ 6
        DriveTrain       $ 5
        MSRP               8
        Invoice            8
        EngineSize         8
        Cylinders          8
        Horsepower         8
        MPG_City           8
        MPG_Highway        8
        Weight             8
        Wheelbase          8
        Length             8 ;
    FORMAT
        Make             $CHAR13.
        Model            $CHAR40.
        Type             $CHAR6.
        Origin           $CHAR6.
        DriveTrain       $CHAR5.
        MSRP             DOLLAR17.
        Invoice          DOLLAR17.
        EngineSize       BEST12.
        Cylinders        BEST12.
        Horsepower       BEST12.
        MPG_City         BEST12.
        MPG_Highway      BEST12.
        Weight           BEST12.
        Wheelbase        BEST12.
        Length           BEST12. ;
    INFORMAT
        Make             $CHAR13.
        Model            $CHAR40.
        Type             $CHAR6.
        Origin           $CHAR6.
        DriveTrain       $CHAR5.
        MSRP             DOLLAR17.
        Invoice          DOLLAR17.
        EngineSize       BEST12.
        Cylinders        BEST12.
        Horsepower       BEST12.
        MPG_City         BEST12.
        MPG_Highway      BEST12.
        Weight           BEST12.
        Wheelbase        BEST12.
        Length           BEST12. ;
    INFILE DATALINES4
        DLM='7F'x
        MISSOVER
        DSD ;
    INPUT
        Make             : $CHAR13.
        Model            : $CHAR40.
        Type             : $CHAR6.
        Origin           : $CHAR6.
        DriveTrain       : $CHAR5.
        MSRP             : BEST32.
        Invoice          : BEST32.
        EngineSize       : BEST32.
        Cylinders        : BEST32.
        Horsepower       : BEST32.
        MPG_City         : BEST32.
        MPG_Highway      : BEST32.
        Weight           : BEST32.
        Wheelbase        : BEST32.
        Length           : BEST32. ;
DATALINES4;
Acura MDXSUVAsiaAll36945333373.5626517234451106189
Acura RSX Type S 2drSedanAsiaFront23820217612420024312778101172
Acura TSX 4drSedanAsiaFront26990246472.4420022293230105183
Acura TL 4drSedanAsiaFront33195302993.2627020283575108186
Acura 3.5 RL 4drSedanAsiaFront43755390143.5622518243880115197
Acura 3.5 RL w/Navigation 4drSedanAsiaFront46100411003.5622518243893115197
Acura NSX coupe 2dr manual SSportsAsiaRear89765799783.2629017243153100174
Audi A4 1.8T 4drSedanEuropeFront25940235081.8417022313252104179
Audi A41.8T convertible 2drSedanEuropeFront35940325061.8417023303638105180
Audi A4 3.0 4drSedanEuropeFront31840288463622020283462104179
Audi A4 3.0 Quattro 4dr manualSedanEuropeAll33430303663622017263583104179
Audi A4 3.0 Quattro 4dr autoSedanEuropeAll34480313883622018253627104179
Audi A6 3.0 4drSedanEuropeFront36640331293622020273561109192
Audi A6 3.0 Quattro 4drSedanEuropeAll39640359923622018253880109192
Audi A4 3.0 convertible 2drSedanEuropeFront42490383253622020273814105180
Audi A4 3.0 Quattro convertible 2drSedanEuropeAll44240400753622018254013105180
Audi A6 2.7 Turbo Quattro 4drSedanEuropeAll42840388402.7625018253836109192
Audi A6 4.2 Quattro 4drSedanEuropeAll49690449364.2830017244024109193
Audi A8 L Quattro 4drSedanEuropeAll69190647404.2833017244399121204
Audi S4 Quattro 4drSedanEuropeAll48040435564.2834014203825104179
Audi RS 6 4drSportsEuropeFront84600764174.2845015224024109191
Audi TT 1.8 convertible 2dr (coupe)SportsEuropeFront35940325121.841802028313195159
Audi TT 1.8 Quattro 2dr (convertible)SportsEuropeAll37390338911.842252028292196159
Audi TT 3.2 coupe 2dr (convertible)SportsEuropeAll40590367393.262502129335196159
Audi A6 3.0 Avant QuattroWagonEuropeAll40840370603622018254035109192
Audi S4 Avant QuattroWagonEuropeAll49090444464.2834015213936104179
BMW X3 3.0iSUVEuropeAll37000338733622516234023110180
BMW X5 4.4iSUVEuropeAll52195477204.4832516224824111184
BMW 325i 4drSedanEuropeRear28495261552.5618420293219107176
BMW 325Ci 2drSedanEuropeRear30795282452.5618420293197107177
BMW 325Ci convertible 2drSedanEuropeRear37995348002.5618419273560107177
BMW 325xi 4drSedanEuropeAll30245277452.5618419273461107176
BMW 330i 4drSedanEuropeRear35495325253622520303285107176
BMW 330Ci 2drSedanEuropeRear36995338903622520303285107176
BMW 330xi 4drSedanEuropeAll37245341153622520293483107176
BMW 525i 4drSedanEuropeRear39995366202.5618419283428114191
BMW 330Ci convertible 2drSedanEuropeRear44295405303622519283616107177
BMW 530i 4drSedanEuropeRear44995411703622520303472114191
BMW 545iA 4drSedanEuropeRear54995502704.4832518263814114191
BMW 745i 4drSedanEuropeRear69195631904.4832518264376118198
BMW 745Li 4drSedanEuropeRear73195668304.4832518264464123204
BMW M3 coupe 2drSportsEuropeRear48195441703.2633316243415108177
BMW M3 convertible 2drSportsEuropeRear56595518153.2633316233781108177
BMW Z4 convertible 2.5i 2drSportsEuropeRear33895310652.561842028293298161
BMW Z4 convertible 3.0i 2drSportsEuropeRear4104537575362252129299898161
BMW 325xi SportWagonEuropeAll32845301102.5618419263594107176
Buick RainierSUVUSAAll37895343574.2627515214600113193
Buick Rendezvous CXSUVUSAFront26545240853.4618519264024112187
Buick Century Custom 4drSedanUSAFront22180203513.1617520303353109195
Buick LeSabre Custom 4drSedanUSAFront26470242823.8620520293567112200
Buick Regal LS 4drSedanUSAFront24895228353.8620020303461109196
Buick Regal GS 4drSedanUSAFront28345260473.8624018283536109196
Buick LeSabre Limited 4drSedanUSAFront32245295663.8620520293591112200
Buick Park Avenue 4drSedanUSAFront35545322443.8620520293778114207
Buick Park Avenue Ultra 4drSedanUSAFront40720369273.8624018283909114207
Cadillac EscaladeSUVUSAFront52795483775.3829514185367116199
Cadillac SRX V8SUVUSAFront46995435234.6832016214302116195
Cadillac CTS VVT 4drSedanUSARear30835285753.6625518253694113190
Cadillac Deville 4drSedanUSAFront45445416504.6827518263984115207
Cadillac Deville DTS 4drSedanUSAFront50595463624.6830018264044115207
Cadillac Seville SLS 4drSedanUSAFront47955438414.6827518263992112201
Cadillac XLR convertible 2drSportsUSARear76200705464.6832017253647106178
Cadillac Escalade EXTTruckUSAAll52975485416834513175879130221
Chevrolet Suburban 1500 LTSUVUSAFront42735374225.3829514184947130219
Chevrolet Tahoe LTSUVUSAAll41465362875.3829514185050116197
Chevrolet TrailBlazer LTSUVUSAFront30295274794.2627516214425113192
Chevrolet TrackerSUVUSAFront20255191082.561651922286698163
Chevrolet Aveo 4drSedanUSAFront11690109651.641032834237098167
Chevrolet Aveo LS 4dr hatchSedanUSAFront12585118021.641032834234898153
Chevrolet Cavalier 2drSedanUSAFront14610136972.2414026372617104183
Chevrolet Cavalier 4drSedanUSAFront14810138842.2414026372676104183
Chevrolet Cavalier LS 2drSedanUSAFront16385153572.2414026372617104183
Chevrolet Impala 4drSedanUSAFront21900200953.4618021323465111200
Chevrolet Malibu 4drSedanUSAFront18995174342.2414524343174106188
Chevrolet Malibu LS 4drSedanUSAFront20370186393.5620022303297106188
Chevrolet Monte Carlo LS 2drSedanUSAFront21825200263.4618021323340111198
Chevrolet Impala LS 4drSedanUSAFront25000229313.8620020303476111200
Chevrolet Impala SS 4drSedanUSAFront27995256723.8624018283606111200
Chevrolet Malibu LT 4drSedanUSAFront23495215513.5620023323315106188
Chevrolet Monte Carlo SS 2drSedanUSAFront24225222223.8620018283434111198
Chevrolet AstroSedanUSAAll26395239544.3619014174605111190
Chevrolet Venture LSSedanUSAFront27020245183.4618519263699112187
Chevrolet Corvette 2drSportsUSARear44535390685.7835018253246105180
Chevrolet Corvette convertible 2drSportsUSARear51535451935.7835018253248105180
Chevrolet Avalanche 1500TruckUSAAll36100316895.3829514185678130222
Chevrolet Colorado Z85TruckUSAAll18760170702.8417518233623111192
Chevrolet Silverado 1500 Regular CabTruckUSARear20310184804.3620015214142119206
Chevrolet Silverado SSTruckUSAAll40340353996830013174804144238
Chevrolet SSRTruckUSARear41995393065.3830016194760116191
Chevrolet Malibu Maxx LSWagonUSAFront22225203943.5620022303458112188
Chrysler PT Cruiser 4drSedanUSAFront17985169192.4415022293101103169
Chrysler PT Cruiser Limited 4drSedanUSAFront22000205732.4415022293105103169
Chrysler Sebring 4drSedanUSAFront19090178052.4415022303173108191
Chrysler Sebring Touring 4drSedanUSAFront21840202842.7620021283222108191
Chrysler 300M 4drSedanUSAFront29865277973.5625018273581113198
Chrysler Concorde LX 4drSedanUSAFront24130224522.7620021293479113208
Chrysler Concorde LXi 4drSedanUSAFront26860249093.5623219273548113208
Chrysler PT Cruiser GT 4drSedanUSAFront25955241722.4422021273217103169
Chrysler Sebring convertible 2drSedanUSAFront25215234512.4415022303357106194
Chrysler 300M Special Edition 4drSedanUSAFront33295308843.5625518273650113198
Chrysler Sebring Limited convertible 2drSedanUSAFront30950286132.7620021283448106194
Chrysler Town and Country LXSedanUSAFront27490253713.3618019264068119201
Chrysler Town and Country LimitedSedanUSAFront38380350633.8621518254331119201
Chrysler Crossfire 2drSportsUSARear34495320333.262151725306095160
Chrysler PacificaWagonUSARear31230287253.5625017234675116199
Dodge Durango SLTSUVUSAAll32235294724.7823015214987119201
Dodge Neon SE 4drSedanUSAFront13670128492413229362581105174
Dodge Neon SXT 4drSedanUSAFront15040140862413229362626105174
Dodge Intrepid SE 4drSedanUSAFront22035205022.7620021293469113204
Dodge Stratus SXT 4drSedanUSAFront18820175122.4415021283182108191
Dodge Stratus SE 4drSedanUSAFront20220188212.4415021283175108191
Dodge Intrepid ES 4drSedanUSAFront24885230583.5623218273487113204
Dodge Caravan SESedanUSAFront21795205082.4415020263862113189
Dodge Grand Caravan SXTSedanUSAAll32660298123.8621518254440119201
Dodge Viper SRT-10 convertible 2drSportsUSARear81795744518.3105001220341099176
Dodge Dakota Regular CabTruckUSARear17630162643.7621016223714112193
Dodge Dakota Club CabTruckUSARear20300186703.7621016223829131219
Dodge Ram 1500 Regular Cab STTruckUSARear20215180763.7621516214542121208
Ford Excursion 6.8 XLTSUVUSAAll41475364946.81031010137190137227
Ford Expedition 4.6 XLTSUVUSAFront34560304684.6823215195000119206
Ford Explorer XLT V6SUVUSAAll29670269834621015204463114190
Ford Escape XLSSUVUSAAll22515209073620118233346103173
Ford Focus ZX3 2dr hatchSedanUSAFront13270124822413026332612103168
Ford Focus LX 4drSedanUSAFront13730129062411027362606103168
Ford Focus SE 4drSedanUSAFront15460144962413026332606103168
Ford Focus ZX5 5drSedanUSAFront15580146072413026332691103168
Ford Focus SVT 2drSedanUSAFront19135178782417021282750103168
Ford Taurus LX 4drSedanUSAFront20320188813615520273306109198
Ford Taurus SES Duratec 4drSedanUSAFront22735208573620119263313109198
Ford Crown Victoria 4drSedanUSARear24345228564.6822417254057115212
Ford Crown Victoria LX 4drSedanUSARear27370251054.6822417254057115212
Ford Crown Victoria LX Sport 4drSedanUSARear30315277564.6823917254057115212
Ford Freestar SESedanUSAFront26930244983.9619317234275121201
Ford Mustang 2dr (convertible)SportsUSARear18345169433.8619320293290101183
Ford Mustang GT Premium convertible 2drSportsUSARear29380268754.6826017253347101183
Ford Thunderbird Deluxe convert w/hardtop 2dSportsUSAFront37530344833.9828017243780107186
Ford F-150 Regular Cab XLTruckUSARear22010194904.6823115194788126211
Ford F-150 Supercab LariatTruckUSAAll33540294055.4830014185464133218
Ford Ranger 2.3 XL Regular CabTruckUSARear14385137172.3414324293028111188
Ford Focus ZTWWagonUSAFront17475163752413026332702103178
Ford Taurus SEWagonUSAFront22290204573615519263497109198
GMC Envoy XUV SLESUVUSAFront31890289224.2627515194945129208
GMC Yukon 1500 SLESUVUSAFront35725313614.8828516195042116199
GMC Yukon XL 2500 SLTSUVUSAAll46265405346832513176133130219
GMC Safari SLESedanUSARear25640232154.3619016204309111190
GMC Canyon Z85 SL Regular CabTruckUSARear16530148772.8417518253351111192
GMC Sierra Extended Cab 1500TruckUSARear25717226044.8828517204548144230
GMC Sierra HD 2500TruckUSAAll29322257596830013185440133222
GMC Sonoma Crew CabTruckUSAAll25395230434.3619015194083123208
Honda Civic Hybrid 4dr manual (gas/electric)HybridAsiaFront20140184511.449346512732103175
Honda Insight 2dr (gas/electric)HybridAsiaFront191101791123736066185095155
Honda Pilot LXSUVAsiaAll27560248433.5624017224387106188
Honda CR-V LXSUVAsiaAll19860184192.4416021253258103179
Honda Element LXSUVAsiaAll18690173342.4416021243468101167
Honda Civic DX 2drSedanAsiaFront13270121751.7411532382432103175
Honda Civic HX 2drSedanAsiaFront14170129961.7411736442500103175
Honda Civic LX 4drSedanAsiaFront15850145311.7411532382513103175
Honda Accord LX 2drSedanAsiaFront19860179242.4416026342994105188
Honda Accord EX 2drSedanAsiaFront22260200802.4416026343047105188
Honda Civic EX 4drSedanAsiaFront17750162651.7412732372601103175
Honda Civic Si 2dr hatchSedanAsiaFront19490178492416026302782101166
Honda Accord LX V6 4drSedanAsiaFront23760214283624021303349108190
Honda Accord EX V6 2drSedanAsiaFront26960243043624021303294105188
Honda Odyssey LXSedanAsiaFront24950224983.5624018254310118201
Honda Odyssey EXSedanAsiaFront27450247443.5624018254365118201
Honda S2000 convertible 2drSportsAsiaRear33260299652.242402025283595162
Hummer H2SUVUSAAll49995458156831610126400123190
Hyundai Santa Fe GLSSUVAsiaFront21589202012.7617320263549103177
Hyundai Accent 2dr hatchSedanAsiaFront10539101071.641032933225596167
Hyundai Accent GL 4drSedanAsiaFront11839111161.641032933229096167
Hyundai Accent GT 2dr hatchSedanAsiaFront11939112091.641032933233996167
Hyundai Elantra GLS 4drSedanAsiaFront13839127812413826342635103178
Hyundai Elantra GT 4drSedanAsiaFront15389142072413826342635103178
Hyundai Elantra GT 4dr hatchSedanAsiaFront15389142072413826342698103178
Hyundai Sonata GLS 4drSedanAsiaFront19339175742.7617019273217106187
Hyundai Sonata LX 4drSedanAsiaFront20339183802.7617019273217106187
Hyundai XG350 4drSedanAsiaFront24589220553.5619417263651108192
Hyundai XG350 L 4drSedanAsiaFront26189234863.5619417263651108192
Hyundai Tiburon GT V6 2drSportsAsiaFront18739171012.7617219263023100173
Infiniti G35 4drSedanAsiaRear28495261573.5626018263336112187
Infiniti G35 Sport Coupe 2drSedanAsiaRear29795275363.5628018263416112182
Infiniti G35 4drSedanAsiaAll32445297833.5626018263677112187
Infiniti I35 4drSedanAsiaFront31145283203.5625519263306108194
Infiniti M45 4drSedanAsiaRear42845387924.5834017233851110197
Infiniti Q45 Luxury 4drSedanAsiaRear52545475754.5834017233977113200
Infiniti FX35WagonAsiaRear34895317563.5628016224056112189
Infiniti FX45WagonAsiaAll36395331214.5831515194309112189
Isuzu Ascender SSUVAsiaAll31849299774.2627515204967129208
Isuzu Rodeo SSUVAsiaFront20449192613.2619317213836106178
Jaguar X-Type 2.5 4drSedanEuropeAll29995273552.5619218263428107184
Jaguar X-Type 3.0 4drSedanEuropeAll33995309953622718253516107184
Jaguar S-Type 3.0 4drSedanEuropeRear43895400043623518263777115192
Jaguar S-Type 4.2 4drSedanEuropeRear49995455564.2829418283874115192
Jaguar S-Type R 4drSedanEuropeRear63120574994.2839017244046115192
Jaguar Vanden Plas 4drSedanEuropeRear68995628464.2829418283803119200
Jaguar XJ8 4drSedanEuropeRear59995546564.2829418283803119200
Jaguar XJR 4drSedanEuropeRear74995683064.2839017243948119200
Jaguar XK8 coupe 2drSportsEuropeRear69995637564.2829418263779102187
Jaguar XK8 convertible 2drSportsEuropeRear74995683064.2829418263980102187
Jaguar XKR coupe 2drSportsEuropeRear81995746764.2839016233865102187
Jaguar XKR convertible 2drSportsEuropeRear86995792264.2839016234042102187
Jeep Grand Cherokee LaredoSUVUSAFront27905256864619516213790106181
Jeep Liberty SportSUVUSAAll20130189732.4415020243826104174
Jeep Wrangler Sahara convertible 2drSUVUSAAll2552023275461901619357593150
Kia Sorento LXSUVAsiaFront19635186303.5619216194112107180
Kia Optima LX 4drSedanAsiaFront16040149102.4413823303281106186
Kia Rio 4dr manualSedanAsiaFront1028098751.641042633240395167
Kia Rio 4dr autoSedanAsiaFront11155107051.641042532245895167
Kia Spectra 4drSedanAsiaFront12360116301.8412424322661101178
Kia Spectra GS 4dr hatchSedanAsiaFront13580128301.8412424322686101178
Kia Spectra GSX 4dr hatchSedanAsiaFront14630137901.8412424322697101178
Kia Optima LX V6 4drSedanAsiaFront18435168502.7617020273279106186
Kia Amanti 4drSedanAsiaFront26000237643.5619517254021110196
Kia Sedona LXSedanAsiaFront20615194003.5619516224802115194
Kia Rio CincoWagonAsiaFront11905114101.641042633244795167
Land Rover Range Rover HSESUVEuropeAll72250658074.4828212165379113195
Land Rover Discovery SESUVEuropeAll39250357774.6821712164576100185
Land Rover Freelander SESUVEuropeAll25995239692.5617418213577101175
Lexus GX 470SUVAsiaAll45700398384.7823515194740110188
Lexus LX 470SUVAsiaAll64800564554.7823513175590112193
Lexus RX 330SUVAsiaAll39195345763.3623018244065107186
Lexus ES 330 4drSedanAsiaFront32350287553.3622520293460107191
Lexus IS 300 4dr manualSedanAsiaRear31045274043621518253255105177
Lexus IS 300 4dr autoSedanAsiaRear32415286113621518243285105177
Lexus GS 300 4drSedanAsiaRear41010361963622018253649110189
Lexus GS 430 4drSedanAsiaRear48450422324.3830018233715110189
Lexus LS 430 4drSedanAsiaRear55750485834.3829018253990115197
Lexus SC 430 convertible 2drSportsAsiaRear63200550634.3830018233840103178
Lexus IS 300 SportCrossWagonAsiaRear32455286473621518243410105177
Lincoln Navigator LuxurySUVUSAAll52775463605.4830013185969119206
Lincoln Aviator UltimateSUVUSAFront42915394434.6830213184834114193
Lincoln LS V6 Luxury 4drSedanUSARear32495299693623220263681115194
Lincoln LS V6 Premium 4drSedanUSARear36895339293623220263681115194
Lincoln LS V8 Sport 4drSedanUSARear40095368093.9828017243768115194
Lincoln LS V8 Ultimate 4drSedanUSARear43495398693.9828017243768115194
Lincoln Town Car Signature 4drSedanUSARear41815384184.6823917254369118215
Lincoln Town Car Ultimate 4drSedanUSARear44925412174.6823917254369118215
Lincoln Town Car Ultimate L 4drSedanUSARear50470462084.6823917254474124221
MINI CooperSedanEuropeFront16999154371.641152837252497143
MINI Cooper SSedanEuropeFront19999181371.641632534267897144
Mazda Tribute DX 2.0SUVAsiaAll21087197422413022253091103173
Mazda Mazda3 i 4drSedanAsiaFront15500145252414826342696104178
Mazda Mazda3 s 4drSedanAsiaFront17200159222.3416025312762104179
Mazda Mazda6 i 4drSedanAsiaFront19270178172.3416024323042105187
Mazda MPV ESSedanAsiaFront28750266003620018253812112188
Mazda MX-5 Miata convertible 2drSportsAsiaRear22388207011.841422328238789156
Mazda MX-5 Miata LS convertible 2drSportsAsiaRear25193232851.841422328238789156
Mazda RX-8 4dr automaticSportsAsiaRear25700237941.3.19718253053106174
Mazda RX-8 4dr manualSportsAsiaRear27200251791.3.23818243029106174
Mazda B2300 SX Regular CabTruckAsiaRear14840140702.3414324292960112188
Mazda B4000 SE Cab PlusTruckAsiaAll22350204824620715193571126203
Mercedes-Benz G500SUVEuropeAll76870715405829213145423112186
Mercedes-Benz ML500SUVEuropeAll46470432685828814174874111183
Mercedes-Benz C230 Sport 2drSedanEuropeRear26060242491.8418922303250107178
Mercedes-Benz C320 Sport 2drSedanEuropeRear28370264353.2621519263430107178
Mercedes-Benz C240 4drSedanEuropeRear32280300712.6616820253360107178
Mercedes-Benz C240 4drSedanEuropeAll33480311872.6616819253360107178
Mercedes-Benz C320 Sport 4drSedanEuropeRear35920334563.2621519263430107178
Mercedes-Benz C320 4drSedanEuropeRear37630350463.2621520263450107178
Mercedes-Benz C320 4drSedanEuropeAll38830361623.2621519273450107178
Mercedes-Benz C32 AMG 4drSedanEuropeRear52120485223.2634916213540107178
Mercedes-Benz CL500 2drSedanEuropeRear94820883245830216244085114196
Mercedes-Benz CL600 2drSedanEuropeRear1284201196005.51249313194473114196
Mercedes-Benz CLK320 coupe 2dr (convertible)SedanEuropeRear45707419663.2621520263770107183
Mercedes-Benz CLK500 coupe 2dr (convertible)SedanEuropeRear52800491045830217223585107183
Mercedes-Benz E320 4drSedanEuropeRear48170448493.2622119273635112190
Mercedes-Benz E500 4drSedanEuropeRear57270533825830216203815112190
Mercedes-Benz S430 4drSedanEuropeRear74320691684.3827518264160122203
Mercedes-Benz S500 4drSedanEuropeAll86970809395830216244390122203
Mercedes-Benz SL500 convertible 2drSportsEuropeRear90520843255830216234065101179
Mercedes-Benz SL55 AMG 2drSportsEuropeRear1217701133885.5849314214235101179
Mercedes-Benz SL600 convertible 2drSportsEuropeRear1266701178545.51249313194429101179
Mercedes-Benz SLK230 convertible 2drSportsEuropeRear40320375482.341922129305595158
Mercedes-Benz SLK32 AMG 2drSportsEuropeRear56170522893.263491722322095158
Mercedes-Benz C240WagonEuropeRear33780314662.6616819253470107179
Mercedes-Benz E320WagonEuropeRear50670471743.2622119273966112190
Mercedes-Benz E500WagonEuropeAll60670564745830216244230112190
Mercury MountaineerSUVUSAFront29995273174621016214374114190
Mercury Sable GS 4drSedanUSAFront21595198483615520273308109200
Mercury Grand Marquis GS 4drSedanUSARear24695232174.6822417254052115212
Mercury Grand Marquis LS Premium 4drSedanUSARear29595271484.6822417254052115212
Mercury Sable LS Premium 4drSedanUSAFront23895219183620119263315109200
Mercury Grand Marquis LS Ultimate 4drSedanUSARear30895283184.6822417254052115212
Mercury Marauder 4drSedanUSARear34495315584.6830217234195115212
Mercury Monterey LuxurySedanUSAFront33995308464.2620116234340121202
Mercury Sable GSWagonUSAFront22595207483615519263488109198
Mitsubishi Endeavor XLSSUVAsiaAll30492283303.8621517214134109190
Mitsubishi Montero XLSSUVAsiaAll33112307633.8621515194718110190
Mitsubishi Outlander LSSUVAsiaFront18892175692.4416021273240103179
Mitsubishi Lancer ES 4drSedanAsiaFront14622137512412025312656102181
Mitsubishi Lancer LS 4drSedanAsiaFront16722157182412025312795102181
Mitsubishi Galant ES 2.4L 4drSedanAsiaFront19312179572.4416023303351108191
Mitsubishi Lancer OZ Rally 4dr autoSedanAsiaFront17232161962412025312744102181
Mitsubishi Diamante LS 4drSedanAsiaFront29282272503.5620518253549107194
Mitsubishi Galant GTS 4drSedanAsiaFront25700238833.8623018263649108191
Mitsubishi Eclipse GTS 2drSportsAsiaFront25092234563621021283241101177
Mitsubishi Eclipse Spyder GT convertible 2drSportsAsiaFront26992252183621021283296101177
Mitsubishi Lancer Evolution 4drSportsAsiaFront29562274662427118263263103179
Mitsubishi Lancer Sportback LSWagonAsiaFront17495162952.4416025313020102181
Nissan Pathfinder Armada SESUVAsiaFront33840308155.6830513195013123207
Nissan Pathfinder SESUVAsiaFront27339259723.5624016213871106183
Nissan Xterra XE V6SUVAsiaFront20939195123.3618017203760104178
Nissan Sentra 1.8 4drSedanAsiaFront12740122051.8412628352513100178
Nissan Sentra 1.8 S 4drSedanAsiaFront14740137471.8412628352581100178
Nissan Altima S 4drSedanAsiaFront19240180302.5417521263039110192
Nissan Sentra SE-R 4drSedanAsiaFront17640164442.5416523282761100178
Nissan Altima SE 4drSedanAsiaFront23290215803.5624521263197110192
Nissan Maxima SE 4drSedanAsiaFront27490251823.5626520283473111194
Nissan Maxima SL 4drSedanAsiaFront29440269663.5626520283476111194
Nissan Quest SSedanAsiaFront24780229583.5624019264012124204
Nissan Quest SESedanAsiaFront32780300193.5624018254175124204
Nissan 350Z coupe 2drSportsAsiaRear26910252033.5628720263188104169
Nissan 350Z Enthusiast convertible 2drSportsAsiaRear34390318453.5628720263428104169
Nissan Frontier King Cab XE V6TruckAsiaAll19479182533.3618017203932116191
Nissan Titan King Cab XETruckAsiaAll26650249265.6830514185287140224
Nissan Murano SLWagonAsiaRear28739273003.5624520253801111188
Oldsmobile Alero GX 2drSedanUSAFront18825176422.2414024322946107187
Oldsmobile Alero GLS 2drSedanUSAFront23675214853.4617020293085107187
Oldsmobile Silhouette GLSedanUSAFront28790261203.4618519263948120201
Pontiac AztektSUVUSAFront21595198103.4618519263779108182
Pontiac Sunfire 1SA 2drSedanUSAFront15495143752.2414024332771104182
Pontiac Grand Am GT 2drSedanUSAFront22450205953.4617520293118107186
Pontiac Grand Prix GT1 4drSedanUSAFront22395205453.8620020303477111198
Pontiac Sunfire 1SC 2drSedanUSAFront17735163692.2414024332771104182
Pontiac Grand Prix GT2 4drSedanUSAFront24295222843.8620020303484111198
Pontiac Bonneville GXP 4drSedanUSAFront35995329974.6827517203790112203
Pontiac MontanaSedanUSAFront23845216443.4618519263803112187
Pontiac Montana EWBSedanUSAAll31370284543.4618518244431121201
Pontiac GTO 2drSportsUSARear33500307105.7834016203725110190
Pontiac VibeWagonUSARear17045159731.8413029362701102172
Porsche Cayenne SSUVEuropeAll56665498654.5834014184950112188
Porsche 911 Carrera convertible 2dr (coupe)SportsEuropeRear79165692293.663151826313593175
Porsche 911 Carrera 4S coupe 2dr (convert)SportsEuropeAll84165722063.663151724324093175
Porsche 911 Targa coupe 2drSportsEuropeRear76765671283.663151826311993175
Porsche 911 GT2 2drSportsEuropeRear1924651735603.664771724313193175
Porsche Boxster convertible 2drSportsEuropeRear43365378862.762282029281195170
Porsche Boxster S convertible 2drSportsEuropeRear52365457663.262581826291195170
Saab 9-3 Arc Sport 4drSedanEuropeFront30860292692421020283175105183
Saab 9-3 Aero 4drSedanEuropeFront33360315622421020283175105183
Saab 9-5 Arc 4drSedanEuropeFront35105330112.3422021293470106190
Saab 9-5 Aero 4drSedanEuropeFront39465377212.3425021293470106190
Saab 9-3 Arc convertible 2drSedanEuropeFront40670385202421021293480105182
Saab 9-3 Aero convertible 2drSedanEuropeFront43175408832421021303700105182
Saab 9-5 AeroWagonEuropeFront40845383762.3425019293620106190
Saturn VUESUVUSAAll20585192382.2414321263381107181
Saturn Ion1 4drSedanUSAFront10995103192.2414026352692103185
Saturn lon2 4drSedanUSAFront14300133932.2414026352692103185
Saturn lon3 4drSedanUSAFront15825148112.2414026352692103185
Saturn lon2 quad coupe 2drSedanUSAFront14850139042.2414026352751103185
Saturn lon3 quad coupe 2drSedanUSAFront16350152992.2414026352751103185
Saturn L300-2 4drSedanUSAFront21410198013618220283197107190
Saturn L300 2WagonUSAFront23560217792.2414024343109107190
Scion xA 4dr hatchSedanAsiaFront12965123401.541083238234093154
Scion xBWagonAsiaFront14165134801.541083135242598155
Subaru Impreza 2.5 RS 4drSedanAsiaAll19945183992.541652228296599174
Subaru Legacy L 4drSedanAsiaAll20445187132.5416521283285104184
Subaru Legacy GT 4drSedanAsiaAll25645233362.5416521283395104184
Subaru Outback Limited Sedan 4drSedanAsiaAll27145246872.5416520273495104184
Subaru Outback H6 4drSedanAsiaAll29345266603621219263610104184
Subaru Outback H-6 VDC 4drSedanAsiaAll31545286033621219263630104184
Subaru Impreza WRX 4drSportsAsiaAll2504523022242272027308599174
Subaru Impreza WRX STi 4drSportsAsiaAll31545291302.5430018243263100174
Subaru BajaTruckAsiaAll24520223042.5416521283485104193
Subaru Forester XWagonAsiaAll21445196462.541652128309099175
Subaru OutbackWagonAsiaAll23895217732.5416521283430104187
Suzuki XL-7 EXSUVAsiaFront23699223072.7618518223682110187
Suzuki Vitara LXSUVAsiaAll17163169492.561651922302098163
Suzuki Aeno S 4drSedanAsiaFront12884127192.341552531267698171
Suzuki Aerio LX 4drSedanAsiaFront14500143172.341552531267698171
Suzuki Forenza S 4drSedanAsiaFront12269121162411924312701102177
Suzuki Forenza EX 4drSedanAsiaFront15568153782411922302756102177
Suzuki Verona LX 4drSedanAsiaFront17262170532.5615520273380106188
Suzuki Aerio SXWagonAsiaAll16497162912.341552429293298167
Toyota Prius 4dr (gas/electric)HybridAsiaFront20510189261.5411059512890106175
Toyota Sequoia SR5SUVAsiaAll35695318274.7824014175270118204
Toyota 4Runner SR5 V6SUVAsiaFront27710248014624518214035110189
Toyota Highlander V6SUVAsiaAll27930249153.3623018243935107185
Toyota Land CruiserSUVAsiaAll54765479864.7832513175390112193
Toyota RAV4SUVAsiaAll20290185532.441612227311998167
Toyota Corolla CE 4drSedanAsiaFront14085130651.8413032402502102178
Toyota Corolla S 4drSedanAsiaFront15030136501.8413032402524102178
Toyota Corolla LE 4drSedanAsiaFront15295138891.8413032402524102178
Toyota Echo 2dr manualSedanAsiaFront10760101441.541083543203593163
Toyota Echo 2dr autoSedanAsiaFront11560108961.541083339208593163
Toyota Echo 4drSedanAsiaFront11290106421.541083543205593163
Toyota Camry LE 4drSedanAsiaFront19560175582.4415724333086107189
Toyota Camry LE V6 4drSedanAsiaFront22775203253621021293296107189
Toyota Camry Solara SE 2drSedanAsiaFront19635177222.4415724333175107193
Toyota Camry Solara SE V6 2drSedanAsiaFront21965198193.3622520293417107193
Toyota Avalon XL 4drSedanAsiaFront26560236933621021293417107192
Toyota Camry XLE V6 4drSedanAsiaFront25920231253621021293362107189
Toyota Camry Solara SLE V6 2drSedanAsiaFront26510239083.3622520293439107193
Toyota Avalon XLS 4drSedanAsiaFront30920272713621021293439107192
Toyota Sienna CESedanAsiaFront23495211983.3623019274120119200
Toyota Sienna XLE LimitedSedanAsiaFront28800256903.3623019274165119200
Toyota Celica GT-S 2drSportsAsiaFront22570203631.8418024332500102171
Toyota MR2 Spyder convertible 2drSportsAsiaRear25130227871.841382632219597153
Toyota TacomaTruckAsiaRear12800118792.4414222272750103191
Toyota Tundra Regular Cab V6TruckAsiaRear16495149783.4619016183925128218
Toyota Tundra Access Cab V6 SR5TruckAsiaAll25935235203.4619014174435128218
Toyota Matrix XRWagonAsiaFront16695151561.8413029362679102171
Volkswagen Touareg V6SUVEuropeAll35515322433.2622015205086112187
Volkswagen Golf GLS 4drSedanEuropeFront1871517478241152431289799165
Volkswagen GTI 1.8T 2dr hatchSedanEuropeFront19825181091.841802431293499168
Volkswagen Jetta GLS TDI 4drSedanEuropeFront21055196381.941003846300399172
Volkswagen New Beetle GLS 1.8T 2drSedanEuropeFront21055196381.841502431282099161
Volkswagen Jetta GLI VR6 4drSedanEuropeFront23785216862.862002130317999172
Volkswagen New Beetle GLS convertible 2drSedanEuropeFront2321521689241152430308299161
Volkswagen Passat GLS 4drSedanEuropeFront23955218981.8417022313241106185
Volkswagen Passat GLX V6 4MOTION 4drSedanEuropeFront33180305832.8619019263721106185
Volkswagen Passat W8 4MOTION 4drSedanEuropeFront39235360524827018253953106185
Volkswagen Phaeton 4drSedanEuropeFront65000599124.2833516225194118204
Volkswagen Phaeton W12 4drSedanEuropeFront750006913061242012195399118204
Volkswagen Jetta GLWagonEuropeFront1900517427241152430303499174
Volkswagen Passat GLS 1.8TWagonEuropeFront24955228011.8417022313338106184
Volkswagen Passat W8WagonEuropeFront40235369564827018254067106184
Volvo XC90 T6SUVEuropeAll41250388512.9626815204638113189
Volvo S40 4drSedanEuropeFront25135237011.9417022292767101178
Volvo S60 2.5 4drSedanEuropeAll31745299162.5520820273903107180
Volvo S60 T5 4drSedanEuropeFront34845329022.3524720283766107180
Volvo S60 R 4drSedanEuropeAll37560353822.5530018253571107181
Volvo S80 2.9 4drSedanEuropeFront37730355422.9620820283576110190
Volvo S80 2.5T 4drSedanEuropeAll37885356882.5519420273691110190
Volvo C70 LPT convertible 2drSedanEuropeFront40565382032.4519721283450105186
Volvo C70 HPT convertible 2drSedanEuropeFront42565400832.3524220263450105186
Volvo S80 T6 4drSedanEuropeFront45210425732.9626819263653110190
Volvo V40WagonEuropeFront26135246411.9417022292822101180
Volvo XC70WagonEuropeAll35145331122.5520820273823109186
;;;;

/* Sort main table */
proc sort data=work.cars;
    by Make Type; 
run;
/* Create lookup tables */
proc sql;
    create table work.carslkp1 as
    select  t1.Make,
            t1.Type,
            t1.Model,
            t1.Horsepower
    from work.cars t1
    order by t1.make, t1.type asc;

    create table work.carslkp2 as
    select  t1.Make,
            t1.Type,
            t1.Model, 
            t1.Weight,
            t1.Wheelbase,    
            t1.Length
    from work.cars t1
    order by t1.make, t1.type asc;

    create table work.carslkp3 as
    select  t1.Make,
            t1.type, 
            t1.Model,
            t1.Drivetrain
    from work.cars t1
    order by t1.make, t1.type  asc;
quit;
/* Quick Check */
proc contents data=work.cars;
/* Export to xls to fiddle with data outside of sas.
    Adapted to SAS Studio free edition
PROC EXPORT DATA=sashelp.cars
    OUTFILE="/folders/myfolders/.sasstudio/webwork/CARS"
    DBMS=XLS REPLACE;
    SHEET="CARS";
RUN;
*/