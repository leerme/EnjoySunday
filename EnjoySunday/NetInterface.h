//
//  NetInterface.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//


//精选：
//http://api.guozhoumoapp.com/v1/channels/6/items?gender=1&generation=2&limit=20&offset=0
#define GLOBLE_COLOR [UIColor colorWithRed:0.045 green:0.681 blue:0.850 alpha:1.000]

#define LOOPVIEW_URL @"http://api.guozhoumoapp.com/v1/banners?channel=iOS"

#define SELECTION_URL @"http://api.guozhoumoapp.com/v1/channels/6/items?gender=1&generation=2&limit=20&offset=0"

#define SELECTION_REFRESH_URL @"http://api.guozhoumoapp.com/v1/channels/6/items?generation=2&gender=1&limit=20&offset=%d"

#define LOOPCLICK_URL @"http://api.guozhoumoapp.com/v1/collections/%@/posts?gender=1&generation=2&limit=20&offset=0"

#define OTHERCONTENT_URL @"http://api.guozhoumoapp.com/v1/channels/%@/items?limit=20&offset=0"


#define DETAIL_URL @"http://api.guozhoumoapp.com/v1/posts/%@"


#define SEARCH_URL @"http://api.guozhoumoapp.com/v1/search/hot_words"

#define SEARCHDETAIL_URL @"http://api.guozhoumoapp.com/v1/search/item?keyword=%@&limit=20&offset=0&sort="
//http://api.guozhoumoapp.com/v1/channels/6/items?generation=2&gender=1&limit=20&offset=20
//


//
#define SINGLE_MAIN_URL @"http://api.guozhoumoapp.com/v2/items?gender=1&generation=2&limit=20&offset=0"
#define SINGLE_MAIN_CLICK_URL @"http://api.guozhoumoapp.com/v2/items/%@"

//单品 ：http://api.guozhoumoapp.com/v2/items?gender=1&generation=2&limit=20&offset=0
//
//cell 点击：http://api.guozhoumoapp.com/v2/items/767（id）
//
//

#define CLASSIFY_CONLECTION_URL @"http://api.guozhoumoapp.com/v1/collections?limit=6&offset=0"
#define CLASSIFY_INANDOUT_URL @"http://api.guozhoumoapp.com/v1/channel_groups/all"

#define CLASSIFY_COLLECTION_CLICK_URL @"http://api.guozhoumoapp.com/v1/collections/%d/posts?gender=1&generation=2&limit=20&offset=0"

#define CLASSIFY_ALL_CLICK_URL @"http://api.guozhoumoapp.com/v1/channels/%d/items?limit=20&offset=0"

#define CLASSIFY_ALL_COLLEXTION_CLICK_URL @"http://api.guozhoumoapp.com/v1/collections?limit=20&offset=0"

//http://api.guozhoumoapp.com/v1/channels/6/items?generation=2&gender=1&limit=20&offset=40
//
//http://api.guozhoumoapp.com/v1/channels/6/items?generation=2&gender=1&limit=20&offset=60

//周末逛街：
//http://api.guozhoumoapp.com/v1/channels/12/items?limit=20&offset=0
//http://api.guozhoumoapp.com/v1/channels/12/items?limit=20&offset=20
//
//尝美食：
//http://api.guozhoumoapp.com/v1/channels/15/items?limit=20&offset=0
//http://api.guozhoumoapp.com/v1/channels/15/items?limit=20&offset=20
//
//体验课：
//http://api.guozhoumoapp.com/v1/channels/13/items?limit=20&offset=0
//周边游：
//http://api.guozhoumoapp.com/v1/channels/14/items?limit=20&offset=0
//
//滚动试图网址：http://api.guozhoumoapp.com/v1/banners?channel=iOS
//
//滚动试图点击：
//http://api.guozhoumoapp.com/v1/collections/3（target_id）/posts?gender=1&generation=2&limit=20&offset=0
//
//cell 点击：http://api.guozhoumoapp.com/v1/posts/1977 （id）
//http://api.guozhoumoapp.com/v1/posts/2295
//
//
//
//单品 ：http://api.guozhoumoapp.com/v2/items?gender=1&generation=2&limit=20&offset=0
//
//cell 点击：http://api.guozhoumoapp.com/v2/items/767（id）
//
//
//分类：专题合集 http://api.guozhoumoapp.com/v1/collections?limit=6&offset=0
//宅家 和 出门：http://api.guozhoumoapp.com/v1/channel_groups/all
//
//专题合集点击：http://api.guozhoumoapp.com/v1/collections/4/posts?gender=1&generation=2&limit=20&offset=0
//4 代表的是点击的 id
//
//点击全部专题：http://api.guozhoumoapp.com/v1/collections?limit=20&offset=0
//
//
//宅家点击： http://api.guozhoumoapp.com/v1/channels/16（id） /items?limit=20&offset=0
//
//出门点击：http://api.guozhoumoapp.com/v1/channels/12(id) /items?limit=20&offset=0

// 意见反馈
//http://api.guozhoumoapp.com/v1/feedbacks

