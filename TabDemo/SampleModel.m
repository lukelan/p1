//
//  SampleModel.m
//  Giga
//
//  Created by Hoang Ho on 11/19/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "SampleModel.h"

@implementation SampleModel

- (instancetype)initWithIndex:(int)randomIndex
{
    SampleModel *instance = [super init];
    
    instance.title = [SampleModel getTitleAtIndex:randomIndex];
    instance.des = [SampleModel getTitleAtIndex:randomIndex];
    instance.image = [SampleModel getImageAtIndex:randomIndex];
    instance.linkUrl = [SampleModel getLinkAtIndex:randomIndex];
    instance.companySource = [SampleModel getCompanyAtIndex:randomIndex];
    
    int comment = (rand() % 40) + 30;
    
//    if (comment < 5) {
//        comment = 0;
//    }
    instance.numberComment = @(comment);
    return instance;
}


+ (NSString*)getTitleAtIndex:(int)index
{
    switch (index) {
        case 0:
            return @"アイドル誌関係者に聞いた、「取材しづらいジャニーズ」と「全員が惚れるジャニーズ」 - サイゾーウーマン";
            
        case 1:
            return @"新作映画「インターステラー」がスゴすぎて全米のSFファンが大興奮";
            
        case 2:
            return @"福山雅治が石けんもボディソープも使わないその理由と正しい体の洗い方";
            
        default:
            return @"濃厚すぎる”悪魔のチョコケーキ”にハマる人続出 Ψ( ｀▽´ )Ψ - NAVER まとめ";
    }
}

+ (NSString*)getDesAtIndex:(int)index
{
    switch (index) {
        case 0:
            return @"あらあら、そんな威張りん坊の顔しないで！ 雑誌やテレビで見ない日がないジャニーズタレントたち。多忙を極めるスケジュールだけに、現場には多くのスタッフが関わって…";
            
        case 1:
            return @"11月22日（土）に日本公開が迫るSF超大作映画「インターステラー」。全米では11/5（現地時間）にIMAXシアターなどの限られた240館で先行上映され、平日にも拘わらずたった1日で1億7千万円以上の興行成績を記録！昨年の「ゼロ・グラビティ」以来の壮大なスペース・オデッセイということで、SFフ";
            
        case 2:
            return @"mayu1028さんが更新しました。";
            
        default:
            return @"ファミリーマートで話題になっているデビルズチョコケーキ。名前もパンチあるけど、味もスゴイんだとか(・o・)";
    }
}

+ (UIImage*)getImageAtIndex:(int)index
{
    NSString *imageName = [NSString stringWithFormat:@"img%d",index];
    return [UIImage imageNamed:imageName];
}

+ (NSString*)getLinkAtIndex:(int)index
{
    switch (index) {
        case 0:
            return @"http://acron.lion.co.jp/pro/kedama.htm?utm_source=FO_MTB&utm_medium=MTB&utm_content=SP&utm_campaign=A";
            
        case 1:
            return @"http://acron.lion.co.jp/pro/kedama.htm?utm_source=FO_MTB&utm_medium=MTB&utm_content=SP&utm_campaign=A";
        
        default:
            return nil;
    }
}

+ (NSString*)getCompanyAtIndex:(int)index
{
    switch (index) {
        case 0:
            return @"サイゾーウーマン";
            
        case 1:
            return @"ライブドアニュース";
            
        case 2:
            return @"Naverまとめ";
            
        default:
            return @"朝日新聞デジタル";
    }
}
@end
