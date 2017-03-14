//
//  Macro_NetInterface.h
//  zichan
//
//  Created by Mike on 16/5/25.
//  Copyright © 2016年 Mike. All rights reserved.
//

#ifndef Macro_NetInterface_h
#define Macro_NetInterface_h

#define isNilOrNull(obj) (obj == nil || [obj isEqual:[NSNull null]])

#define setObjectForKey(object) \
do { \
    [dictionary setObject:object forKey:@#object]; \
} while (0)

#define setOptionalObjectForKey(object) \
do { \
    isNilOrNull(object) ?: [dictionary setObject:object forKey:@#object]; \
} while (0)

//// baseURL
#define ZC_BASE_URL ([NSString stringWithFormat:@"%@/services/V1", USERDEFAULT_OBJ4KEY(kServerURL)]) // http://192.168.50.143:8088 http://111.207.253.203:9085 http://192.168.130.74:8080  http://192.168.50.26:9085

// ----------------------------------------------------------------------------
#pragma mark - 1.登录
// 1.登录 --GET
#define LOGIN_URL ([NSString stringWithFormat:@"%@/login", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCLoginParameter(NSString *loginname, NSString *password) {
    return NSDictionaryOfVariableBindings(loginname, password);
}
// ----------------------------------------------------------------------------
#pragma mark - 2.获取角色列表
// 2.获取角色列表 --GET
#define GET_ROLE_LIST_URL ([NSString stringWithFormat:@"%@/getrolelist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetRoleListParameter(NSString *userid, NSString *areaid, NSString *token) {
    return NSDictionaryOfVariableBindings(userid, areaid, token);
}
#pragma mark - 3.用户信息修改
// 3.用户信息修改 --POST
// 3.1基本信息修改
#define BASE_INFO_MODIFY_URL ([NSString stringWithFormat:@"%@/updateinfo", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCBaseInfoModifyParameter(NSString *userid, NSString *areaid, NSString *token, NSString *loginname, NSString *name, NSString *tel, NSString *email, NSString *password) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, loginname, name, tel, email, password);
}
// 3.2用户头像修改 --POST
#define USER_AVATAR_MODIFY_URL ([NSString stringWithFormat:@"%@/updateuseimg", ZC_BASE_URL])
// 参数构造 另一个参数img为文件
NS_INLINE NSDictionary *ZCUserAvatarModifyParameter(NSString *userid, NSString *areaid, NSString *token, NSString *type) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, type);
}
// ----------------------------------------------------------------------------
#pragma mark - 4.单据
// 4.单据
// 4.1我的单据
// 4.1.1我的单据列表 --GET
#define MY_ORDER_LIST_URL ([NSString stringWithFormat:@"%@/myorderlist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCMyOrderListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid);
}

// 4.1.1我的单据列表确认领取 --POST
#define MY_ORDER_CONFIRM_GET_URL ([NSString stringWithFormat:@"%@/confirm", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCMyOrderListConfirmGetParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid,NSString *orderid,NSString *ordertype) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,orderid,ordertype);

}
// 4.1.2单据修改保存/提交 --POST
#define ORDER_MODIFY_URL ([NSString stringWithFormat:@"%@/updateorder", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCOrderModifyParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *orderid, NSString *code, NSString *applyuserid, NSString *applydepid, NSString *checkdepid, NSString *applytime, NSString *allprice, NSString *returntime, NSString *des, NSString *remark, NSString *type,NSString *ordertype) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          orderid, code, applyuserid, applydepid, checkdepid, applytime, allprice, returntime, des, remark, type ,ordertype);
}
// 4.2待审核单据
// 4.2.1待审核的单据列表 --GET
#define CHECKPENDING_ORDER_LIST_URL ([NSString stringWithFormat:@"%@/checkorderlist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCCheckPendingOrderListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid);
}

// 4.2.2审核单据 --POST
#define CHECK_ORDER_URL ([NSString stringWithFormat:@"%@/checkorder", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCCheckOrderParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *orderid, NSString *ordertype, NSString *idtypeid, NSString *lowidtypeid, NSString *result, NSString *status) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          orderid, ordertype, idtypeid, lowidtypeid, result, status);
}

// 4.3待处理单据
// 4.3.1待处理单据列表 --GET
#define DEAL_PENDING_ORDER_LIST_URL ([NSString stringWithFormat:@"%@/dealorderlist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCDealPendingOrderListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid);
}

// 4.3.2单据处理提交/保存 --POST
#define DEAL_ORDER_URL ([NSString stringWithFormat:@"%@/dealsave", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCDealOrderParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *orderid, NSString *assetsids, NSString *ordertype, NSString *type) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          orderid, assetsids, ordertype, type);
}

//单据详情 --GET

#define ORDER_DETAIL_URL ([NSString stringWithFormat:@"%@/lookorder", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCOrderDetailParameter(NSString *userid, NSString *areaid, NSString *token,NSString *orderid, NSString *ordertype) {
    return NSDictionaryOfVariableBindings(userid, areaid, token,
                                          orderid, ordertype);
}


// 4.5单据历史 --GET
#define HISTORY_ORDER_LIST_URL ([NSString stringWithFormat:@"%@/historyorderlist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCHistoryOrderListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *searchcode, NSString *pageNum, NSString *pageSize, NSString *typestatus) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid, searchcode, pageNum, pageSize, typestatus);
}
// ----------------------------------------------------------------------------
#pragma mark - 5.全局搜索
// 5.全局搜索 --GET
#define SEARCH_ALL_URL ([NSString stringWithFormat:@"%@/searchall", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCSearchAllParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *pageNum, NSString *pageSize, NSString *searchcode, NSString *type) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          pageNum, pageSize, searchcode, type);
}
// ----------------------------------------------------------------------------
#pragma mark - 6.资产详情
// 6.资产详情
// 6.1资产基础信息 --GET
#define QUERY_ASSETS_BASE_INFO_URL ([NSString stringWithFormat:@"%@/queryassetsbaseinfo", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCQueryAssetsBaseInfoParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *assetscode) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          assetscode);
}
// 6.2相关单据信息 --GET
#define QUERY_RELATIVE_ORDER_LIST_URL ([NSString stringWithFormat:@"%@/assetsorderlist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCQueryRelativeOrderListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *assetscode) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          assetscode);
}
// 6.3文件路径 --GET
#define QUERY_ASSETS_FILE_LIST_URL ([NSString stringWithFormat:@"%@/assetsfilelist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCQueryAssetsFileListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *assetscode) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          assetscode);
}
// ----------------------------------------------------------------------------
#pragma mark - 7.资产修改
// 7.资产修改
// 7.1资产位置信息 --POST
#define UPDATE_ASSETS_LOCATION_URL ([NSString stringWithFormat:@"%@/updateassetslocation", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCUpdateAssetsLocationParameter(NSString *userid, NSString *roleid, NSString *token, NSString *id, NSString *areaid, NSString *buildid, NSString *roomid, NSString *remark) {
    return NSDictionaryOfVariableBindings(userid, roleid, token,
                                          id, areaid, buildid, roomid, remark);
}
// 7.2资产图片信息 --POST 另外一个`img`参数为文件
#define UPDATE_ASSETS_IMG_URL ([NSString stringWithFormat:@"%@/updateassetsimg", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCUpdateAssetsImgParameter(NSString *userid, NSString *areaid, NSString *roleid, NSString *token, NSString *id, NSString *type) {
    return NSDictionaryOfVariableBindings(userid, areaid, roleid, token,
                                          id, type);
}
// ----------------------------------------------------------------------------
#pragma mark - 8.资产相关信息查询
// 8.资产相关信息查询
// 8.1获取资产列表 --GET
#define GET_ASSETS_LIST_URL ([NSString stringWithFormat:@"%@/getassetslist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetAssetsListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *pageSize, NSString *pageNum, NSString *searchcode) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          pageSize, pageNum, searchcode);
}

// 获取低值资产列表
#define GET_LOW_ASSETS_LIST_URL ([NSString stringWithFormat:@"%@/getLowAssetsList", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetLowAssetsListParameter(NSString *userid,NSString *token, NSString *roleid, NSString *pageSize, NSString *pageNum, NSString *name) {
    return NSDictionaryOfVariableBindings(userid,token, roleid,
                                          pageSize, pageNum, name);
}

// 8.2获取状态 --GET
#define GET_STATUS_URL ([NSString stringWithFormat:@"%@/getstatus", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetStatusParameter(NSString *userid,NSString *token, NSString *roleid,NSString *areaid) {
    return NSDictionaryOfVariableBindings(userid, token, roleid, areaid);
}

// 8.3获取低值类别 --GET
#define GET_LOW_TYPE_URL ([NSString stringWithFormat:@"%@/getlowtype", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetLowTypeParameter(NSString *userid, NSString *token, NSString *parenteid) {
    return NSDictionaryOfVariableBindings(userid, token, parenteid);
}

// 8.4获取资产类别 --GET
#define GET_ASSETS_TYPE_URL ([NSString stringWithFormat:@"%@/getassetstype", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetAssetsTypeParameter(NSString *userid, NSString *token, NSString *parenteid) {
    return NSDictionaryOfVariableBindings(userid, token, parenteid);
}

// 8.5获取厂商/供应商 --GET
#define GET_COMPANY_URL ([NSString stringWithFormat:@"%@/getcompany", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetCompanyParameter(NSString *userid, NSString *token, NSString *pageNum, NSString *pageSize) {
    return NSDictionaryOfVariableBindings(userid, token, pageNum, pageSize);
}

// 8.6获取型号 --GET
#define GET_MODEL_URL ([NSString stringWithFormat:@"%@/getmodel", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetModelParameter(NSString *userid, NSString *token, NSString *companyid, NSString *pageNum, NSString *pageSize) {
    return NSDictionaryOfVariableBindings(userid, token, companyid, pageNum, pageSize);
}

// 8.7获取人员 --GET
#define GET_USERS_URL ([NSString stringWithFormat:@"%@/getusers", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetUsersParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *pageNum, NSString *pageSize) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          pageNum, pageSize);
}
// ----------------------------------------------------------------------------
#pragma mark - 9.资产申请操作
// 9.1	资产（领用，借用，低值领用，低值借用）保存/提交 --POST
#define ASSETS_SUBMIT_URL ([NSString stringWithFormat:@"%@/assetsapplay", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCAssetsSubmitParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *code, NSString *applyuserid, NSString *applydepid, NSString *ordertype, NSString *applytime, NSString *returntime, NSString *des, NSString *remark, NSString *type) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          code, applyuserid, applydepid, ordertype, applytime, returntime, des, remark, type);
}
// ----------------------------------------------------------------------------
#pragma mark - 10.资产报废
// 10.资产报废
// 10.1获取已报废资产列表 --GET
#define ASSETS_SCRAP_LIST_URL ([NSString stringWithFormat:@"%@/assetsscraplist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCAssetsScrapListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *searchcode, NSString *pageNum, NSString *pageSize) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          searchcode, pageNum, pageSize);
}
// 10.2资产报废 --GET
#define ASSETS_SCRAP_SUBMIT_URL ([NSString stringWithFormat:@"%@/assetsscrap", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCAssetsScrapSubmitParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *assetsid) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          assetsid);
}
// 10.3资产还原 --GET
#define ASSETS_RESTORE_URL ([NSString stringWithFormat:@"%@/reduction", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCAssetsRestoreParameter(NSString *userid, NSString *areaid, NSString *token, NSString *assetsid) {
    return NSDictionaryOfVariableBindings(userid, areaid, token,
                                          assetsid);
}
// ----------------------------------------------------------------------------
#pragma mark - 11.资产盘点
// 11.资产盘点
// 11.1获取资产盘点计划列表 --GET
#define GET_MEASURE_PLAN_LIST_URL ([NSString stringWithFormat:@"%@/planlist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetMeasurePlanListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *searchcode, NSString *pageNum, NSString *pageSize) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          searchcode, pageNum, pageSize);
}
// 11.2保存要报废的资产 --POST
#define SCRAP_SAVE_SUBMIT_URL ([NSString stringWithFormat:@"%@/inventorysave", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCScrapSaveSubmitParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *planid, NSString *assetsidStr) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          planid, assetsidStr);
}

// 11.3根据盘点计划获取盘点资产 --GET
#define GET_MEASURE_ASSETS_LIST_URL ([NSString stringWithFormat:@"%@/inventorydatalist", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetMeasureAssetsListParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *planid, NSString *searchcode, NSString *pageNum, NSString *pageSize) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          planid, searchcode, pageNum, pageSize);
}
// 11.4扫描或是手动确认盘点资产 --POST
#define COMMIT_MEASURE_ASSETS_URL ([NSString stringWithFormat:@"%@/planassets", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCCommitMeasureAssetsParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *planid, NSString *idStr) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          planid, idStr);
}

// 11.5盘点完毕 --GET
#define MEASURE_FINISH_URL ([NSString stringWithFormat:@"%@/inventoryfinish", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCMeasureFinishParameter(NSString *userid, NSString *areaid, NSString *token, NSString *roleid, NSString *planid) {
    return NSDictionaryOfVariableBindings(userid, areaid, token, roleid,
                                          planid);
}
// ----------------------------------------------------------------------------
#pragma mark - 12.学校基本信息
// 12.1获取学校
#define GET_SCHOOL_URL ([NSString stringWithFormat:@"%@/getorg", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetSchoolParameter(NSString *userid, NSString *token) {
    return NSDictionaryOfVariableBindings(userid, token);
}
// 12.2获取部门
#define GET_DEPARTMENT_URL ([NSString stringWithFormat:@"%@/getdeps", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetDepartmentParameter(NSString *userid, NSString *token,NSString *roleid, NSString *areaid, NSString *parenteid) {
    return NSDictionaryOfVariableBindings(userid, token, roleid, areaid, parenteid);
}

// 12.3获取校区
#define GET_AREA_URL ([NSString stringWithFormat:@"%@/getarea", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetAreaParameter(NSString *userid, NSString *token) {
    return NSDictionaryOfVariableBindings(userid, token);
}

// 12.4获取楼宇
#define GET_BUILDING_URL ([NSString stringWithFormat:@"%@/getbuild", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetBuildingParameter(NSString *userid, NSString *areaid, NSString *roleid, NSString *token, NSString *orgid) {
    return NSDictionaryOfVariableBindings(userid, areaid, roleid, token, orgid);
}

// 12.5获取楼层/房间
#define GET_ROOM_URL ([NSString stringWithFormat:@"%@/getroom", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetRoomParameter(NSString *userid, NSString *areaid, NSString *roleid, NSString *token, NSString *orgid, NSString *buildid) {
    return NSDictionaryOfVariableBindings(userid, areaid, roleid, token, orgid, buildid);
}

// ----------------------------------------------------------------------------
#pragma mark - 13.获取token
// 13.获取token
#define GET_TOKEN_URL ([NSString stringWithFormat:@"%@/gettoken", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetTokenParameter(NSString *userid) {
    return NSDictionaryOfVariableBindings(userid);
}

// ---------------------------------增加接口--------------------------------------
// 14.扫描单据的时候 根据code获取单据详情 --GET
#define GET_TICKET_DETAIL_USE_CODE_URL ([NSString stringWithFormat:@"%@/scanCodeInfo", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetTicketDetailUseCodeParameter(NSString *userid, NSString *areaid, NSString *roleid, NSString *token, NSString *code) {
    return NSDictionaryOfVariableBindings(userid, areaid, roleid, token,
                                          code);
}

// 14.低值资产详情 --GET
#define GET_LOW_ASSET_DETAIL_URL ([NSString stringWithFormat:@"%@/querylowassetsinfo", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetLowAssetDetailParameter(NSString *userid, NSString *roleid, NSString *token, NSString *id) {
    return NSDictionaryOfVariableBindings(userid, roleid, token,
                                          id);
}

// 15.扫码录入 --POST
#define SCANNER_LOGGING_URL ([NSString stringWithFormat:@"%@/assetsssave", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCGetScannerLoggingParameter(NSString *userid, NSString *areaid, NSString *roleid, NSString *token, NSString *val) {
    return NSDictionaryOfVariableBindings(userid, areaid, roleid,
                                          token, val);
}

#endif /* Macro_NetInterface_h */
