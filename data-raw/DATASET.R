## code to prepare `DATASET` dataset goes here
topo_to_icd10 <- read.csv("~/website/db/data/topo.csv")
topo <- topo_to_icd10$topo
topo_dict <- gsub("\\.", "", topo, perl = TRUE)

library(dplyr)
data <- read.csv("~/website/db/data/morp.csv")
morp2 <- read.csv("~/website/db/data/morp2.csv")

morp1 <- data %>%
  mutate(morp = paste0("M", substr(morp, 1, 6))) %>%
  select(morp, morp_desen, comments)

morp_o3_2 <- morp1 %>%
  full_join(morp2, by = ("morp")) %>%
  arrange(morp) %>%
  filter(mark == 0) %>%
  filter(!comments == "Not listed in ICD-O-3.2")
morp_beha_dict <- morp_o3_2$morp

# 提取ICDO3-2的形态学词典
morp_dict <- unique(substr(data$morp, 1, 4))


## ICCC3-2005 recodes
topo <- list()
# III
topo[[12]] <- gen_topo(723)
topo[[15]] <- c(gen_topo(700:729))
topo[[16]] <- gen_topo(c(700:722, 724:729, 751, 753))
topo[[19]] <- gen_topo(c(700:729, 751:753))
# IV
topo[[22]] <- gen_topo(c(0:699, 739:768, 809))
# VI
topo[c(25, 26, 28)] <- gen_topo(649)
# VII
topo[[30]] <- gen_topo(c(220, 221))
topo[[32]] <- gen_topo(c(220, 221))
# VIII
topo[[33]] <- gen_topo(c(400:419, 760:768, 809))
topo[[34]] <- gen_topo(c(400:419, 760:768, 809))
topo[[36]] <- gen_topo(c(400:419, 760:768, 809))
topo[[37]] <- gen_topo(c(400:419))
topo[[38]] <- gen_topo(c(400:419))
topo[[40]] <- gen_topo(c(400:419))
# IX
topo[[42]] <- gen_topo(c(0:399, 440:768, 809))
topo[[46]] <- gen_topo(c(0:399, 440:768, 809))
topo[[47]] <- gen_topo(c(0:639, 659:699, 739:768, 809))
topo[[48]] <- gen_topo(c(490:499))
topo[[49]] <- gen_topo(c(0:399, 470:759))
topo[[50]] <- gen_topo(c(0:399, 470:639, 659:699, 739:768, 809))
topo[[51]] <- gen_topo(c(0:399, 470:639, 659:768, 809))
topo[[52]] <- gen_topo(c(0:399, 440:768, 809))
# X
topo[[53]] <- gen_topo(c(700:729, 751:753))
topo[[54]] <- gen_topo(c(0:559, 570:619, 630:699, 739:750, 754:768, 809))
topo[[55]] <- gen_topo(c(569, 620:629))
topo[[56]] <- gen_topo(c(569, 620:629))
topo[[59]] <- gen_topo(c(569, 620:629))
# XI
topo[[60]] <- gen_topo(c(739))
topo[[63]] <- gen_topo(c(110:119))
topo[[65]] <- gen_topo(c(440:449))
topo[[66]] <- gen_topo(
  c(
    0:109,
    129:218,
    239:399,
    480:488,
    500:559,
    570:619,
    630:639,
    659:699,
    739:750,
    754:809
  )
)
# XII
topo[[68]] <- gen_topo(c(0:399, 470:759))
topo[[69]] <- gen_topo(c(
  0:218,
  239:399,
  420:559,
  570:619,
  630:639,
  659:699,
  739:750,
  754:809
))
morp <- list(
  "011" = c(9820, 9823, 9826, 9827, gen_morp(9831:9837), 9940, 9948),
  "012" = c(
    9840,
    9861,
    9866,
    9867,
    gen_morp(9870:9874),
    9891,
    gen_morp(9895:9897),
    9910,
    9920,
    9931
  ),
  "013" = c(9863, 9875, 9876, 9950, gen_morp(9960:9964)),
  "014" = c(9945, 9946, 9975, 9980, gen_morp(9982:9987), 9989),
  "015" = c(9800, 9801, 9805, 9860, 9930),
  "021" = c(9650:9655, 9659, gen_morp(9661:9665), 9667),
  "022" = c(
    9591,
    9670,
    9671,
    9673,
    9674,
    9675,
    gen_morp(9678:9680),
    9684,
    gen_morp(9689:9691),
    9695,
    gen_morp(9698:9702),
    9705,
    9708,
    9709,
    9714,
    gen_morp(9716:9719),
    gen_morp(9727:9729),
    gen_morp(9731:9734),
    gen_morp(9760:9762),
    gen_morp(9764:9769),
    9970
  ),
  "023" = c(9687),
  "024" = c(gen_morp(9740:9742), 9750, gen_morp(9754:9758)),
  "025" = c(9590, 9596),
  "031" = c(9383, gen_morp(9390:9394)),
  "032" = 9380,
  "032" = c(
    9384,
    gen_morp(9400:9411),
    9420,
    gen_morp(9421:9424),
    gen_morp(9440:9442)
  ),
  "033" = c(gen_morp(9470:9474), 9480, 9508),
  "033" = c(gen_morp(9501:9504)),
  "034" = c(9380),
  "034" = c(9381, 9382, 9430, 9444, 9450, 9451, 9460),
  "035" = c(
    gen_morp(8270:8281),
    8300,
    gen_morp(9350:9352),
    gen_morp(9360:9362),
    9412,
    9413,
    9492,
    9493,
    gen_morp(9505:9507),
    gen_morp(9530:9539),
    9582
  ),
  "036" = c(gen_morp(8000:8005)),
  "041" = c(9490, 9500),
  "042" = c(
    gen_morp(8680:8683),
    gen_morp(8690:8693),
    8700,
    gen_morp(9520:9523)
  ),
  "042" = c(gen_morp(9501:9504)),
  "050" = c(gen_morp(9510:9514)),
  "061" = c(8959, 8960, gen_morp(8964:8967)),
  "061" = c(8963, 9364),
  "062" = c(
    gen_morp(8010:8041),
    gen_morp(8050:8075),
    8082,
    gen_morp(8120:8122),
    gen_morp(8130:8141),
    8143,
    8155,
    gen_morp(8190:8201),
    8210,
    8211,
    gen_morp(8221:8231),
    8240,
    8241,
    gen_morp(8244:8246),
    gen_morp(8260:8263),
    8290,
    8310,
    8320,
    8323,
    8401,
    8430,
    8440,
    gen_morp(8480:8490),
    8504,
    8510,
    8550,
    gen_morp(8560:8576)
  ),
  "062" = c(8311, 8312, gen_morp(8316:8319), 8361),
  "063" = c(gen_morp(8000:8005)),
  "071" = 8970,
  "072" = c(
    gen_morp(8010:8041),
    gen_morp(8050:8075),
    8082,
    gen_morp(8120:8122),
    8140,
    8143,
    8155,
    gen_morp(8190:8201),
    8210,
    8211,
    8230,
    8231,
    8240,
    8241,
    gen_morp(8244:8246),
    gen_morp(8260:8264),
    8310,
    8320,
    8323,
    8401,
    8430,
    8440,
    gen_morp(8480:8490),
    8504,
    8510,
    gen_morp(8550:8576)
  ),
  "072" = c(gen_morp(8160:8180)),
  "073" = 8000:8005,
  "081" = c(gen_morp(9180:9187), gen_morp(9191:9195), 9200),
  "082" = c(9210, 9220, 9240),
  "082" = c(9221, 9230, gen_morp(9241:9243)),
  "083" = c(9260),
  "083" = c(gen_morp(9363:9365)),
  "084" = c(8810, 8811, 8823, 8830),
  "084" = c(
    8812,
    9250,
    9261,
    9262,
    gen_morp(9270:9275),
    gen_morp(9280:9282),
    9290,
    gen_morp(9300:9302),
    gen_morp(9310:9312),
    gen_morp(9320:9322),
    9330,
    gen_morp(9340:9342),
    gen_morp(9370:9372)
  ),
  "085" = c(gen_morp(8000:8005), 8800, 8801, gen_morp(8803:8805)),
  "091" = c(gen_morp(8900:8905), 8910, 8912, 8920, 8991),
  "092" = c(
    8810,
    8811,
    gen_morp(8813:8815),
    8821,
    8823,
    gen_morp(8834:8835)
  ),
  "092" = c(
    8820,
    8822,
    gen_morp(8824:8827),
    9150,
    9160,
    9491,
    gen_morp(9540:9571),
    9580
  ),
  "093" = c(9140),
  "094" = c(
    8587,
    gen_morp(8710:8713),
    8806,
    gen_morp(8831:8833),
    8836,
    gen_morp(8840:8842),
    gen_morp(8850:8858),
    gen_morp(8860:8862),
    8870,
    8880,
    8881,
    gen_morp(8890:8898),
    8921,
    8982,
    8990,
    gen_morp(9040:9044),
    gen_morp(9120:9125),
    gen_morp(9130:9133),
    9135,
    9136,
    9141,
    9142,
    9161,
    gen_morp(9170:9175),
    9231,
    9251,
    9252,
    9373,
    9581
  ),
  "094" = c(8830),
  "094" = c(8963),
  "094" = c(9180, 9210, 9220, 9240),
  "094" = c(9260),
  "094" = c(9364),
  "094" = c(9365),
  "095" = c(gen_morp(8800:8805)),
  "101" = c(
    gen_morp(9060:9065),
    gen_morp(9070:9072),
    gen_morp(9080:9085),
    9100,
    9101
  ),
  "102" = c(
    gen_morp(9060:9065),
    gen_morp(9070:9072),
    gen_morp(9080:9085),
    gen_morp(9100:9105)
  ),
  "103" = c(
    gen_morp(9060:9065),
    gen_morp(9070:9073),
    gen_morp(9080:9085),
    9090,
    9091,
    9100,
    9101
  ),
  "104" = c(
    gen_morp(8010:8041),
    gen_morp(8050:8075),
    8082,
    gen_morp(8120:8122),
    gen_morp(8130:8141),
    8143,
    gen_morp(8190:8201),
    8210,
    8211,
    gen_morp(8221:8241),
    gen_morp(8244:8246),
    gen_morp(8260:8263),
    8290,
    8310,
    8313,
    8320,
    8323,
    gen_morp(8380:8384),
    8430,
    8440,
    gen_morp(8480:8490),
    8504,
    8510,
    8550,
    gen_morp(8560:8573),
    9000,
    9014,
    9015
  ),
  "104" = c(gen_morp(8441:8444), 8450, 8451, gen_morp(8460:8473)),
  "105" = c(gen_morp(8590:8671)),
  "105" = c(gen_morp(8000:8005)),
  "111" = c(gen_morp(8370:8375)),
  "112" = c(
    gen_morp(8010:8041),
    gen_morp(8050:8075),
    8082,
    gen_morp(8120:8122),
    gen_morp(8130:8141),
    8190,
    8200,
    8201,
    8211,
    8230,
    8231,
    gen_morp(8244:8246),
    gen_morp(8260:8263),
    8290,
    8310,
    8320,
    8323,
    8430,
    8440,
    8480,
    8481,
    8510,
    gen_morp(8560:8573)
  ),
  "112" = c(gen_morp(8330:8337), gen_morp(8340:8347), 8350),
  "113" = c(
    gen_morp(8010:8041),
    gen_morp(8050:8075),
    8082,
    8083,
    gen_morp(8120:8122),
    gen_morp(8130:8141),
    8190,
    8200,
    8201,
    8211,
    8230,
    8231,
    gen_morp(8244:8246),
    gen_morp(8260:8263),
    8290,
    8310,
    8320,
    8323,
    8430,
    8440,
    8480,
    8481,
    gen_morp(8500:8576)
  ),
  "114" = c(gen_morp(8720:8780), 8790),
  "115" = c(
    gen_morp(8010:8041),
    gen_morp(8050:8075),
    8078,
    8082,
    gen_morp(8090:8110),
    8140,
    8143,
    8147,
    8190,
    8200,
    8240,
    8246,
    8247,
    8260,
    8310,
    8320,
    8323,
    gen_morp(8390:8420),
    8430,
    8480,
    8542,
    8560,
    gen_morp(8570:8573),
    8940,
    8941
  ),
  "116" = c(
    gen_morp(8010:8084),
    gen_morp(8120:8157),
    gen_morp(8190:8264),
    8290,
    8310,
    gen_morp(8313:8315),
    gen_morp(8320:8325),
    8360,
    gen_morp(8380:8384),
    gen_morp(8430:8440),
    gen_morp(8452:8454),
    gen_morp(8480:8586),
    gen_morp(8588:8589),
    8940,
    8941,
    8983,
    9000,
    gen_morp(9010:9016),
    9020,
    9030
  ),
  "121" = c(
    gen_morp(8930:8936),
    8950,
    8951,
    gen_morp(8971:8981),
    gen_morp(9050:9055),
    9110
  ),
  "121" = c(9363),
  "122" = gen_morp(8000:8005)
)

morp <- lapply(morp, as.integer)
iccc3_2005 <- list(morp = morp, topo = topo)



## Morp code family
topo_family <- list(
  gen_topo(0:809),
  gen_topo(70:89),
  gen_topo(160:169),
  gen_topo(170:179),
  gen_topo(c(
    180:209, 260:269, 762:763, 767:768, 800:809
  )),
  gen_topo(c(200:219)),
  gen_topo(c(
    150:209, 260:269, 762:763, 767:768, 800:809
  )),
  gen_topo(c(220:229)),
  gen_topo(c(220:249)),
  gen_topo(c(250:259)),
  gen_topo(c(300:319)),
  gen_topo(c(340:349, 398:399, 761, 767, 768, 800:809)),
  gen_topo(c(
    340:349, 384, 398:399, 480:489, 761:763, 767:768, 809
  )),
  gen_topo(c(370:389)),
  gen_topo(c(380)),
  gen_topo(c(390:419, 490:499, 761, 767, 768, 809)),
  gen_topo(c(400, 402, 408, 409)),
  gen_topo(c(400:419)),
  gen_topo(c(420:429)),
  gen_topo(c(
    0:9, 440:449, 510:519, 600:609, 632, 760:769, 809
  )),
  gen_topo(
    c(
      0:9,
      440:449,
      490:499,
      510:519,
      600:609,
      632,
      638,
      639,
      760:769,
      809
    )
  ),
  gen_topo(c(500:509, 761, 767, 768, 809)),
  gen_topo(c(510:529, 578, 579)),
  gen_topo(c(540:559, 578, 579)),
  gen_topo(c(560:579, 762, 763, 767, 768, 809)),
  gen_topo(c(580:589)),
  gen_topo(c(
    480:489, 494:499, 530:579, 762, 763, 767, 768, 809
  )),
  gen_topo(c(600:609)),
  gen_topo(c(620:639)),
  gen_topo(c(640:649, 688, 689)),
  gen_topo(c(692, 698, 699)),
  gen_topo(c(690:699)),
  gen_topo(c(700:729)),
  gen_topo(c(716, 718, 719, 728:729)),
  gen_topo(c(710:719, 728, 729)),
  gen_topo(c(700:729, 753)),
  gen_topo(c(730:739)),
  gen_topo(c(740:749)),
  gen_topo(c(750)),
  gen_topo(c(751:752)),
  gen_topo(c(753)),
  gen_topo(c(754)),
  gen_topo(c(755)),
  gen_topo(c(440:449, 530:539, 578, 579)),
  gen_topo(c(160:179, 250:269, 762, 767, 768, 809)),
  gen_topo(
    c(70:89, 640:649, 688, 689, 730:739, 758, 759, 760, 762, 767, 768, 809)
  ),
  gen_topo(c(250:269, 560:579)),
  gen_topo(c(480:4899, 560:569)),
  gen_topo(c(
    560:569, 578, 579, 620:629, 638, 639, 762, 763, 767, 768, 809
  )),
  gen_topo(c(
    200:219, 440:449, 510:519, 600:609, 632, 690:709, 760:769, 809
  )),
  gen_topo(c(510:579, 640:689, 762, 763, 767, 768, 809)),
  gen_topo(c(500:509, 530:579, 761:763, 767:768, 809)),
  gen_topo(c(400:419, 490:499, 760:769, 809)),
  gen_topo(c(
    300, 310:319, 323, 328:329, 339, 390:419, 490:499, 760:769, 809
  )),
  gen_topo(c(210:219, 510:539, 610:619)),
  gen_topo(
    c(
      110:119,
      140:149,
      200:219,
      260:269,
      300:319,
      390:399,
      530:539,
      610:619,
      640:689,
      760:763,
      767,
      768,
      809
    )
  ),
  gen_topo(
    c(
      150:269,
      340:349,
      370:379,
      381:383,
      398:399,
      560:569,
      578:579,
      730:739,
      760:763,
      767,
      768,
      809
    )
  ),
  gen_topo(
    c(
      69:89,
      210:259,
      268,
      269,
      500:509,
      610:619,
      638,
      639,
      758,
      759,
      760,
      762,
      763,
      767,
      768,
      809
    )
  ),
  gen_topo(c(
    380:389, 398:399, 470:499, 670:689, 710:769, 809
  )),
  gen_topo(
    c(
      380:389,
      398:399,
      480:499,
      560:579,
      620:639,
      710:729,
      750:759,
      760:763,
      767,
      768,
      809
    )
  ),
  gen_topo(c(
    380:389, 560:5589, 620:629, 761:763, 767, 768, 809
  )),
  gen_topo(
    c(
      110:119,
      140:149,
      300:319,
      390:419,
      490:499,
      710:729,
      750:769,
      809
    )
  ),
  gen_topo(
    c(
      380:389,
      398,
      399,
      470:499,
      690:729,
      740:749,
      758,
      759,
      760:769,
      809
    )
  ),
  gen_topo(c(
    380:389, 398, 399, 470:499, 690:729, 760:769, 809
  )),
  gen_topo(c(420:429)),
  gen_topo(c(400:429, 470:499, 700:729, 770:779)),
  gen_topo(c(420:421, 423, 424, 770:779)),
  gen_topo(c(400:419, 420, 421, 423, 424, 770:779)),
  gen_topo(c(420, 421, 423, 424, 700:729, 770:779)),
  gen_topo(
    c(
      70:89,
      220:259,
      400:429,
      470:489,
      500:589,
      610:629,
      640:689,
      700:759
    )
  ),
  gen_topo(c(400:419))
)

morp_family <- list(
  f1 = c(
    8000,
    8001,
    8002,
    8003,
    9590,
    9591,
    9596,
    9650,
    9651,
    9652,
    9653,
    9654,
    9655,
    9659,
    9661,
    9662,
    9663,
    9664,
    9665,
    9667,
    9670,
    9671,
    9673,
    9675,
    9678,
    9680,
    9684,
    9687,
    9690,
    9691,
    9695,
    9698,
    9699,
    9701,
    9702,
    9705,
    9714,
    9716,
    9719,
    9727,
    9728,
    9729,
    9731,
    9740,
    9741,
    9750,
    9751,
    9752,
    9753,
    9754,
    9755,
    9756,
    9757,
    9758,
    9760,
    9762,
    9766,
    9767,
    9768,
    9769,
    9930,
    9970,
    9975
  ),
  f2 = c(8561, 8974),
  f3 = c(8142, 8214),
  f4 = c(8683, 9764),
  f5 = c(8213, 8220, 8261),
  f6 = c(8124, 8215),
  f7 = c(8144, 8145, 8221, 8936, 9717),
  f8 = c(8170, 8171, 8172, 8173, 8174, 8175, 8970, 9124),
  f9 = c(8160, 8161, 8162, 8180, 8264),
  f10 = c(8150, 8151, 8152, 8154, 8155, 8202, 8452, 8453, 8971),
  f11 = c(9520, 9521, 9522, 9523),
  f12 = c(
    8012,
    8040,
    8041,
    8042,
    8043,
    8044,
    8045,
    8046,
    8250,
    8252,
    8253,
    8254,
    8255
  ),
  f13 = c(8973, 9050, 9051, 9052, 9053, 9055),
  f14 = c(8580, 8581, 8582, 8583, 8584, 8585, 8586, 8587, 8588, 8589),
  f15 = c(8454),
  f16 = c(9365),
  f17 = c(9261),
  f18 = c(
    8812,
    9180,
    9181,
    9182,
    9183,
    9184,
    9185,
    9186,
    9187,
    9191,
    9192,
    9193,
    9194,
    9195,
    9200,
    9210,
    9250
  ),
  f19 = c(
    9689,
    9732,
    9733,
    9742,
    9761,
    9765,
    9800,
    9801,
    9805,
    9820,
    9823,
    9826,
    9827
  ),
  f20 = c(
    8081,
    8090,
    8091,
    8092,
    8093,
    8094,
    8095,
    8096,
    8097,
    8100,
    8101,
    8102,
    8103,
    8110,
    8111
  ),
  f21 = c(8247, 8832, 8833, 9507, 9708),
  f22 = c(
    8204,
    8314,
    8315,
    8501,
    8502,
    8505,
    8506,
    8507,
    8508,
    8512,
    8513,
    8520,
    8521,
    8522,
    8523,
    8524,
    8530,
    8540,
    8541,
    8543,
    8983,
    9010:9012,
    9016,
    9020,
    9030
  ),
  f23 = c(8905),
  f24 = c(8930, 8931),
  f25 = c(
    8313,
    8441,
    8442,
    8443,
    8444,
    8451,
    8460,
    8462,
    8463,
    8470,
    8471,
    8472,
    8473,
    8593,
    8600,
    8601,
    8602,
    8610,
    8620,
    8621,
    8622,
    8623,
    8632,
    8641,
    8660,
    8670,
    9000,
    9013,
    9014,
    9015,
    9090,
    9091
  ),
  f26 = c(9103, 9104),
  f27 = c(8380, 8381, 8382, 8383, 8384, 8482, 8934, 8950, 8951),
  f28 = c(8080),
  f29 = c(9061, 9062, 9063, 9102),
  f30 = c(
    8312,
    8316,
    8317,
    8318,
    8319,
    8325,
    8361,
    8959,
    8960,
    8964,
    8965,
    8966,
    8967
  ),
  f31 = c(9510, 9511, 9512, 9513, 9514),
  f32 = c(8726, 8773, 8774),
  f33 = c(8728, 9530, 9531, 9532, 9533, 9534, 9535, 9537, 9538, 9539),
  f34 = c(9470, 9471, 9472, 9474, 9480, 9493),
  f35 = c(9381, 9390, 9444),
  f36 = c(
    9121,
    9122,
    9123,
    9131,
    9380,
    9381,
    9382,
    9383,
    9384,
    9391,
    9392,
    9393,
    9394,
    9400,
    9401,
    9410,
    9411,
    9412,
    9413,
    9420,
    9421,
    9423,
    9424,
    9430,
    9440,
    9441,
    9442,
    9450,
    9451,
    9460,
    9463,
    9473,
    9505,
    9506,
    9508,
    9509
  ),
  f37 = c(
    8330,
    8331,
    8332,
    8333,
    8334,
    8335,
    8336,
    8337,
    8340,
    8341,
    8342,
    8343,
    8344,
    8345,
    8346,
    8347
  ),
  f38 = c(8370, 8371, 8372, 8373, 8374, 8375, 8700),
  f39 = c(8321, 8322),
  f40 = c(8270, 8271, 8272, 8280, 8281, 8300, 9350, 9351, 9352, 9582),
  f41 = c(8370, 8371, 8372, 8373, 8374, 8375, 8700),
  f42 = c(8321, 8322),
  f43 = c(8270, 8271, 8272, 8280, 8281, 8300, 9350, 9351, 9352, 9582),
  f44 = c(9360, 9361, 9362),
  f45 = c(8692),
  f46 = c(8690, 8691),
  f47 = c(8098),
  f48 = c(8153, 8156, 8157),
  f49 = c(8450),
  f50 = c(8590, 8591, 8592, 8630, 8631, 8633, 8634, 8640, 8642, 8650, 9054),
  f51 = c(
    8720,
    8721,
    8722,
    8723,
    8725,
    8727,
    8730,
    8740,
    8741,
    8742,
    8743,
    8744,
    8745,
    8746,
    8750,
    8760,
    8761,
    8762,
    8770,
    8771,
    8772,
    8780,
    8781,
    8773,
    8774,
    8780,
    8781
  ),
  f52 = c(8932, 8933, 9110),
  f53 = c(9040, 9041, 9042, 9043, 9044, 9251, 9252, 9260),
  f54 = c(9220, 9221, 9230, 9231, 9240, 9241, 9242, 9243),
  f55 = c(8077, 8148),
  f56 = c(8120, 8121, 8122, 8130, 8131),
  f57 = c(8240, 8241, 8242, 8243, 8244, 8245, 8246, 8248, 8249),
  f58 = c(8500, 8503, 8504, 8514, 8525),
  f59 = c(8680, 8681, 8682, 8693, 8710, 8711, 8712, 8713),
  f60 = c(
    9060,
    9064,
    9065,
    9070,
    9071,
    9072,
    9073,
    9080,
    9081,
    9082,
    9083,
    9084,
    9085
  ),
  f61 = c(9100, 9101),
  f62 = c(9370, 9371, 9372, 9373),
  f63 = c(9490, 9491, 9492, 9500, 9501, 9502, 9503, 9504),
  f64 = c(9540, 9541, 9550, 9560, 9561, 9562, 9570, 9571),
  f65 = c(
    8004,
    8005,
    8831,
    8834,
    8835,
    8836,
    9170,
    9171,
    9172,
    9173,
    9174,
    9175,
    9176
  ),
  f66 = c(
    8010,
    8011,
    8013,
    8014,
    8015,
    8020,
    8021,
    8022,
    8030,
    8031,
    8032,
    8033,
    8034,
    8035,
    8050,
    8051,
    8052,
    8053,
    8060,
    8070,
    8071,
    8072,
    8073,
    8074,
    8075,
    8076,
    8077,
    8078,
    8082,
    8083,
    8084,
    8123,
    8140,
    8141,
    8143,
    8146,
    8147,
    8149,
    8190,
    8200,
    8201,
    8210,
    8211,
    8212,
    8230,
    8231,
    8251,
    8260,
    8261,
    8262,
    8263,
    8310,
    8311,
    8320,
    8323,
    8324,
    8360,
    8430,
    8440,
    8480,
    8481,
    8490,
    8510,
    8550,
    8551,
    8560,
    8562,
    8570,
    8571,
    8572,
    8573,
    8574,
    8575,
    8576,
    8940,
    8941,
    8980,
    8981,
    8982
  ),
  f67 = c(
    8671,
    8800,
    8801,
    8803,
    8804,
    8805,
    8806,
    8963,
    9120,
    9125,
    9130,
    9133,
    9135,
    9136,
    9141,
    9142,
    9150,
    9160,
    9161,
    9363,
    9364,
    9580,
    9581
  ),
  f68 = c(8802),
  f69 = c(
    8810,
    8811,
    8813,
    8814,
    8815,
    8820:8826,
    8830,
    8840,
    8841,
    8842,
    8850:8858,
    8860:8862,
    8870,
    8880,
    8881,
    8890:8898,
    8900:8904,
    8910,
    8912,
    8920,
    8921,
    8990,
    8991,
    9132
  ),
  f70 = c(9140),
  f71 = c(9734)
)
morp_family <- lapply(morp_family, as.integer)

check_site_morp <- list(morp_family = morp_family, topo_family = topo_family)


## not exist codes in icd10
not_icd10 <- list(
  C = c(
    7,
    25:27,
    32:38,
    42:47,
    53:57,
    63:67,
    71:79,
    82:87,
    92:97,
    105:107,
    114:117,
    121:129,
    133:137,
    141,
    143:147,
    149,
    156,
    157,
    167,
    174:177,
    191:199,
    201:209,
    213:217,
    219,
    225,
    226,
    228,
    231:239,
    242:247,
    255,
    256,
    262:267,
    302:309,
    314:317,
    324:327,
    331:339,
    344:347,
    371:379,
    385:387,
    389,
    391:397,
    404:407,
    415:417,
    453,
    456,
    458,
    464:466,
    477,
    483:487,
    489,
    497,
    507,
    513:517,
    521:529,
    532:539,
    543:547,
    551:559,
    561:569,
    575,
    576,
    581:589,
    590:599,
    603:607,
    611:619,
    622:628,
    633:636,
    641:649,
    651:659,
    661:669,
    682:687,
    697,
    702:708,
    726,
    727,
    731:739,
    742:748,
    756,
    757,
    766,
    769,
    776,
    789,
    799,
    801:809,
    814,
    815,
    816,
    818,
    823:826,
    828,
    846:849,
    903:909,
    916,
    918,
    926,
    928,
    852:856,
    858,
    860:879,
    884:886,
    888,
    890:899,
    933:936,
    938,
    946,
    948,
    949,
    953:956,
    958,
    964:966,
    968,
    971:979
  ),
  D = c(
    3:9,
    16,
    18,
    25:29,
    52:56,
    58,
    62:66,
    68,
    77:79,
    80:89,
    94:96,
    98,
    108,
    111:116,
    118,
    138,
    145:149,
    153:156,
    158,
    178,
    182:189,
    192:196,
    198,
    202:209,
    218,
    219,
    228,
    238,
    241:249,
    253:259,
    262:266,
    268,
    271:279,
    283:286,
    288,
    295,
    296,
    298,
    305,
    306,
    308,
    317,
    318,
    322:328,
    335,
    336,
    338,
    341:349,
    362:366,
    368,
    378,
    387,
    388,
    389,
    393:396,
    398,
    402:406,
    408,
    415,
    416,
    418,
    422:428,
    435,
    436,
    438,
    451:459,
    465,
    466,
    468,
    474:476,
    478,
    488
  )
)




usethis::use_data(
  check_site_morp,
  iccc3_2005,
  not_icd10,
  morp_dict,
  morp_beha_dict,
  topo_dict,
  overwrite = TRUE,
  internal = TRUE
)
