//
//  Define.h
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#define _AFNETWORKING_PIN_SSL_CERTIFICATES_
#define TIMER_REQUEST_TIMEOUT                                                           5.0

#define DEFAULT_PAGE_SIZE                       20


typedef enum
{
    ENUM_API_REQUEST_TYPE_GET_ARTICLE
    
}ENUM_API_REQUEST_TYPE;

typedef enum
{
    ENUM_CAREER_CHANGE_COMPANY_INFO,
    ENUM_CAREER_CHANGE_NEW_TOPIC,
    ENUM_CAREER_CHANGE_BUSINESS,
    ENUM_CAREER_CHANGE_SERVICE,
    ENUM_CAREER_CHANGE_MEDICAL_LINE,
    ENUM_CAREER_CHANGE_NURSING,
    ENUM_CAREER_CHANGE_IT_CREATING,
    ENUM_CAREER_CHANGE_MANUAL_LABOR,
    ENUM_CAREER_CHANGE_EDUCATION,
    ENUM_CAREER_CHANGE_BOOK_MARK,
    ENUM_CAREER_CHANGE_SETTINGS,
    ENUM_CAREER_CHANGE_NOTIFICATION
    
}ENUM_CAREER_CHANGE_INDEX;

#define API_ROOT                                @"http://girlspicks.co/api"
#define STRING_API_REQUEST_GET_ARTICLE          [NSString stringWithFormat:@"%@/get_article_by_category", API_ROOT]


//bold font

#define FONT_BOLD                   @"HelveticaNeue-Bold"
#define FONT_NORMAL                 @"HelveticaNeue"