//
//  NHAlbumsView.m
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import "NHAlbumsView.h"
#import "NHAlbumsTableViewCell.h"
@interface NHAlbumsView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;

@end

static NSString * const NHAlbumsTableViewCellIdentifier = @"NHAlbumsTableViewCell";
@implementation NHAlbumsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainTableView];
    }
    return self;
}
-(void)setCollectionArr:(NSArray<PHAssetCollection *> *)collectionArr{
    _collectionArr = collectionArr;
    
    [self.mainTableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectionArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NHAlbumsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NHAlbumsTableViewCellIdentifier];
    cell.collection = self.collectionArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectAlbumBlock) {
        self.selectAlbumBlock((int)indexPath.row);
    }
}
-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.rowHeight = 100;
        [_mainTableView registerClass:[NHAlbumsTableViewCell class] forCellReuseIdentifier:NHAlbumsTableViewCellIdentifier];
    }
    return _mainTableView;
}
@end
