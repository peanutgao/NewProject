//
//  WDDBDaoManager.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDDBDaoManager.h"
#import "LKDBHelper.h"

#define DB_MODEL_CHECK(model)  if (model == nil) {\
                                  NSAssert(model != nil, @"tableName不能为空");\
                                  NSLog(@"删除数据库失败: tableName == nil");\
                                  if (block) {\
                                      block(NO);\
                                  }\
                                  return;\
                                }

#define DB_RESULT_LOG(result)  NSLog(@"%@", [NSString stringWithFormat:@"删除数据库:%@ !", result == YES ? @"成功" : @"失败"]);

#define DB_RESULT(result)      DB_RESULT_LOG(result)\
                               if (block) {\
                                  block(result);\
                               }\

@interface WDDBDaoManager ()

@property (nonatomic, strong) LKDBHelper *dbHelper;

@end

@implementation WDDBDaoManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static WDDBDaoManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.dbHelper = [LKDBHelper getUsingLKDBHelper];
    });
    return instance;
}

@end


#pragma mark - 删除

@implementation WDDBDaoManager (Delete)

- (void)dropAllTable {
    [self.dbHelper dropAllTable];
}

- (BOOL)deleteToDB:(NSObject *)model {
    __block BOOL r = NO;
    [self deleteToDB:model callback:^(BOOL result) {
        r = result;
    }];
    return r;
}

- (void)deleteToDB:(NSObject *)model callback:(void (^)(BOOL result))block {
    DB_MODEL_CHECK(model);
    [self.dbHelper deleteToDB:model callback:^(BOOL result) {
        DB_RESULT(result);
    }];
}

- (BOOL)deleteWithClass:(Class)modelClass where:(nullable id)where {
    __block BOOL r = NO;
    [self deleteWithClass:modelClass where:where callback:^(BOOL result) {
        r = result;
    }];
    return r;
}

- (void)deleteWithClass:(Class)modelClass where:(nullable id)where callback:(void (^)(BOOL result))block {
    DB_MODEL_CHECK(modelClass);
    [self.dbHelper deleteWithClass:modelClass where:where callback:^(BOOL result) {
        DB_RESULT(result);
    }];
}

- (BOOL)deleteWithTableName:(NSString *)tableName where:(nullable id)where {
    __block BOOL r = NO;
    [self deleteWithTableName:tableName where:where callback:^(BOOL result) {
        r = result;
    }];
    return r;
}

- (void)deleteWithTableName:(NSString *_Nullable)tableName where:(nullable id)where callback:(void (^_Nullable)(BOOL result))block {
    DB_MODEL_CHECK(tableName);
    BOOL r = [self.dbHelper deleteWithTableName:tableName where:where];
    DB_RESULT(r);
}

@end



#pragma mark - 插入数据

@implementation WDDBDaoManager (Insert)

- (BOOL)insertToDB:(NSObject *_Nullable)model {
    __block BOOL r = NO;
    [self insertToDB:model callback:^(BOOL result) {
        r = result;
    }];
    return r;
}

- (void)insertToDB:(NSObject *_Nullable)model callback:(void (^_Nullable)(BOOL result))block {
    DB_MODEL_CHECK(model);
    [self.dbHelper insertToDB:model callback:^(BOOL result) {
        DB_RESULT(result);
    }];
}

- (BOOL)insertWhenNotExists:(NSObject *_Nullable)model {
    __block BOOL r = NO;
    [self insertWhenNotExists:model callback:^(BOOL result) {
        r = result;
    }];
    return r;
}

- (void)insertWhenNotExists:(NSObject *_Nullable)model callback:(void (^_Nullable)(BOOL result))block {
    DB_MODEL_CHECK(model);
    [self.dbHelper insertWhenNotExists:model callback:^(BOOL result) {
        DB_RESULT(result);
    }];
}

@end


#pragma mark - 更新数据

@implementation WDDBDaoManager (Update)

- (BOOL)updateToDB:(NSObject *_Nullable)model where:(nullable id)where {
    __block BOOL r = NO;
    [self updateToDB:model where:where callback:^(BOOL result) {
        r = result;
    }];
    return r;
}

- (void)updateToDB:(NSObject *_Nullable)model where:(nullable id)where callback:(void (^_Nullable)(BOOL result))block {
    DB_MODEL_CHECK(model);
    [self.dbHelper updateToDB:model where:where callback:^(BOOL result) {
        DB_RESULT(result);
    }];
}

- (BOOL)updateToDB:(Class _Nullable )modelClass set:(NSString *_Nullable)sets where:(nullable id)where {
    if (modelClass == nil) {
        NSLog(@"删除数据库失败: tableName == nil");
        return NO;
    }
    BOOL r = [self.dbHelper updateToDB:modelClass set:sets where:where];
    DB_RESULT_LOG(r)
    return r;
}

- (BOOL)updateToDBWithTableName:(NSString *_Nullable)tableName set:(NSString *_Nullable)sets where:(nullable id)where {
    if (tableName == nil || tableName.isEmpty) {
        NSLog(@"删除数据库失败: tableName == nil");
        return NO;
    }
    BOOL r = [self.dbHelper updateToDBWithTableName:tableName set:sets where:where];
    DB_RESULT_LOG(r)
    return r;
}

@end


#pragma mark - 查询数据

@implementation WDDBDaoManager (Search)

- (nullable NSMutableArray *)search:(Class _Nullable )modelClass
                              where:(nullable id)where
                            orderBy:(nullable NSString *)orderBy
                             offset:(NSInteger)offset
                              count:(NSInteger)count {
    NSAssert(modelClass != nil, @"modelClass 不能为空");
    if (modelClass == nil) return [NSMutableArray array];
    
    return [self.dbHelper search:modelClass
                           where:where
                         orderBy:orderBy
                          offset:offset
                           count:count];
}


- (nullable NSMutableArray *)searchWithSQL:(NSString *_Nullable)sql toClass:(nullable Class)modelClass {
    if (sql == nil || sql.isEmpty || modelClass == nil) {
        NSAssert(NO, @"参数不能为空!");
        return [NSMutableArray array];
    }
    
    return [self.dbHelper searchWithSQL:sql toClass:modelClass];
}


- (nullable NSMutableArray *)searchWithRAWSQL:(NSString *_Nullable)sql toClass:(nullable Class)modelClass {
    if (sql == nil || sql.isEmpty || modelClass == nil) {
        NSAssert(NO, @"参数不能为空!");
        return [NSMutableArray array];
    }
    
    return [self.dbHelper searchWithRAWSQL:sql toClass:modelClass];
}


- (nullable NSMutableArray *)search:(Class _Nullable )modelClass withSQL:(NSString *_Nullable)sql, ... {
    if (sql == nil || sql.isEmpty || modelClass == nil) {
        NSAssert(NO, @"参数不能为空!");
        return [NSMutableArray array];
    }
    
    return [self.dbHelper search:modelClass withSQL:sql];
}


- (nullable NSMutableArray *)search:(Class _Nullable )modelClass
                             column:(nullable id)columns
                              where:(nullable id)where
                            orderBy:(nullable NSString *)orderBy
                             offset:(NSInteger)offset
                              count:(NSInteger)count {
    NSAssert(modelClass != nil, @"modelClass 不能为空");
    if (modelClass == nil) return [NSMutableArray array];

    return [self search:modelClass
                 column:columns
                  where:where
                orderBy:orderBy
                 offset:offset
                  count:count];
 
}


- (void)search:(Class _Nullable )modelClass
         where:(nullable id)where
       orderBy:(nullable NSString *)orderBy
        offset:(NSInteger)offset
         count:(NSInteger)count
      callback:(void (^_Nullable)(NSMutableArray * _Nullable array))block {
    NSAssert(modelClass != nil, @"modelClass 不能为空");
    if (modelClass == nil) {
        NSLog(@"查询数据失败: modelClass为空");
        block([NSMutableArray array]);
        return;
    }
    
    [self.dbHelper search:modelClass
                    where:where
                  orderBy:orderBy
                   offset:offset
                    count:count
                 callback:block];
}

- (nullable id)searchSingle:(Class _Nullable )modelClass where:(nullable id)where orderBy:(nullable NSString *)orderBy {
    NSAssert(modelClass != nil, @"modelClass 不能为空");
    if (modelClass == nil) {
        NSLog(@"查询数据失败: modelClass为空");
        return nil;
    }
    
    return [self.dbHelper searchSingle:modelClass where:where orderBy:orderBy];
}


@end
