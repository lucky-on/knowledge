#!/usr/bin/env bash

Adam:

I found 00.x bug by processing ebooks corpora provided to me by Kayoko: 
/home/ivobuild/storage/japanese_recordings/yakayoko/ivona/ivona-core/lang_devel/japanese/corpora_devel/text_sources/ebooks

When processing this resource, I found 30 errors like this (all falling into the same pattern, mostly looking like dates):

-logbash-3.2$ for i in {01..50}; do n=$(printf "%02d" $i); grep -q VAL ebooks.all.txt.$n-50.log && (id=$(tail -n 1 ebooks.all.txt.$n-50 | cut -f 1); grep -A1 $id ../00_sharding/ebooks.all.txt.$n-50 | head -2 | tail -1) ; done
ELT024866.001216        （「源氏狂騒曲」00・３）
ENF000781.000326        （入院日記、00・８・19）
ENF000781.000377        （入院日記、00・10・22）
ENF002840.000288        （00・８・14）
ELT004626.001272        （00・６・８）
ENF000781.000334        （同、00・９・１）
ELT024866.001076        （「ふるさとの川の運命」00・１）
ELT004626.001228        （00・３・９）
ENF000781.000289        （00・８・14）
ENF002840.000252        （入院日記、00・７・29）
ELT021863.002993        （「刑政」'00・10）
ELT021863.001494        （「ワン・オン・ワン」'00・11）
ENF002840.000305        （入院日記、00・８・17）
ELT024866.001189        （「春へんろ」00・３）
ENF000781.000350        （同、00・10・６）
ENF000781.000253        （入院日記、00・７・29）
ELT002735.004392        ラリーの万歩計が四回つづけてかちかちと小さな音をたて、きょうの行程がセットされた──〇〇〇・〇。
ENF000781.000306        （入院日記、00・８・17）
ELT024866.001348        （「身のしまつ」00・９）
ELT021863.000710        （「週刊文春」特別号'00・12）
ELT024866.001302        （「源氏物語のフランス語訳を」00・６）
ENF002840.000325        （入院日記、00・８・19）
ENF002840.000376        （入院日記、00・10・22）
ELT024866.001258        （「早朝の訪問客」00・４）
ENF000188.002131        粒子が現在「左」に動いたことで、00.5がわかる。
ELT004626.002010        （00・12・14）
ELT024866.001411        （「ふるさとの風」00・10）
ELT021863.000921        （「通販生活」'00・10）
ENF002840.000333        （同、00・９・１）