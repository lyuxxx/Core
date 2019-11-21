//
//  TestViewController.m
//  base
//
//  Created by lyx on 2019/9/4.
//  Copyright © 2019 csc. All rights reserved.
//

#import "TestViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface TestViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TestViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self setupMJ];
    [self loadData];
}

#pragma mark - private func

- (void)setupUI {
    
    self.navigationItem.title = @"标题测试";
    
    weakifySelf
    self.tableView.emptyView = [[EmptyView alloc] initWithImage:[UIImage imageNamed:@"contents_missing_pages"] verticalOffset:0 tapClosure:^{
        strongifySelf
        [self loadData];
    }];
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setupMJ {
    if (!self.tableView.mj_header) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    if (!self.tableView.mj_footer) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(appendData)];
    }
}

- (void)loadData {
    self.tableView.emptyView.allowShow = YES;
    [self.dataSource removeAllObjects];
    for (NSInteger i = 0; i < 0; i++) {
        [self.dataSource addObject:@"test"];
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

- (void)appendData {
    for (NSInteger i = 0; i < 10; i++) {
        [self.dataSource addObject:@"test"];
    }
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - action

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
