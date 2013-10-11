

#pragma mark - Constant

#ifdef FREE //free version
#define kAPPID 550131099
#define kApplink @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=550131099&mt=8"
#else   // paid version
#define kAPPID 549019227
#define kApplink @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=549019227&mt=8"
#endif

#pragma mark - Parameter
#define kMaschineDuration 5
#define kOfenDuration 5
#define kMicrowelleDuration 5
#define kPotDuration 999
#define kPanDuration 999

#define kCORNERRADIUS 20



#define SSupportEmailTitle @"Feedback for Tiny Kitchen"
#define SRecommendEmailTitle @"Tiny Kitchen -- Amazing App for Kids"

#pragma mark - file




#define kFileAppSettingName @"AppSettingFile"
#define kFileSetting @"SettingFile"



#pragma mark - ViewTag


#define kTagCoverPhotoBarButtonItem 125
#define kTagMaschineWorkingView     126


#define kTagFigureTest0 200
#define kTagFigureTest1 201
#define kTagFigureTest2 202
#define kTagFigureTest3 203
#define kTagFigureTest4 204
#define kTagFigureTest5 205
#define kTagFigureTest6 206
#define kTagFigureTest7 207
#define kTagFigureTest8 208
#define kTagFigureTest9 209
#define kTagFigureTest10 210
#define kTagFigureTest11 211
#define kTagFigureTest12 212



#pragma mark - Notification

#define kNotifiRootDismiss @"dismiss"
#define kNotifiRootOpenTextLabelVC @"openTextLabel"  // object is string, font name, color?




#pragma mark - Universal UI

#define kUniversalFaktor isPad?1:2
#define kFrameUniversalHorizont isPad?CGRectMake(0,0,1024,768):CGRectMake(0,0,480,320)
#define kFrameUniHorizontWithNaviBar isPad?CGRectMake(0,0,1024,724):CGRectMake(0,0,480,288)


#define kUIContainerFrame isPad?CGRectMake(0,0,960,640):CGRectMake(0,0,480,320)




#pragma mark - Time
#define kActionHeadDuration 0.8
#define kActionEyesDuration 0.8



#pragma mark - Debug & Release

#ifdef DEBUG


#define kHost @"http://dev.thebootic.com/cgi-bin/search/"



#else

#define kHost @"http://www.thebootic.com/cgi-bin/search/"


#endif


#pragma mark - enum


typedef enum{
	PS_None,
	PS_Text,
	PS_TextLabel,
	PS_Image,
	PS_OneImage,
	PS_Zettel,
	PS_Sticker,
	PS_Love,
	PS_Setting,
	PS_Info
} PopOverStatus;


typedef enum{
	AppCityQuiz,
	AppMyeCard,
	AppKidsGames
} AppIndex;

typedef enum{
    FoodRaw,
    FoodOfen,
    FoodMicrowelle,
    FoodPot,
    FoodPan
}FoodState;

typedef enum{
	FigureNinja,
	FigureCat,
	FigureLion,
	FigurePinguin
}FigureIndex;

typedef enum {
	FoodPizza,
    FoodMeat,
    FoodVegetable,
    FoodSushi,
    FoodFast,
    FoodFruit,
    FoodStarch,
    FoodIce,
	FoodOutdoor
} FoodCategory;

typedef enum{
	SceneHome,
	SceneFigure,
	SceneKitchen,
	SceneOutdoor
}Scene;

typedef enum{
	MaschineOfen,
	MaschinePot,
	MaschinePan,
	MaschineMicrowelle,
	MaschineNone
}MaschineType;

typedef enum{
	FoodOutdoorFish,
	FoodOutdoorRadish,
	FoodOutdoorAubergine,
	FoodOutdoorCarrot,
	FoodOutdoorTomato
}FoodOutdoorIndex;

typedef enum {
	FigureSoundNormal,
	FigureSoundGood,
	FigureSoundBad,
	FigureSoundYummy,
	FigureSoundEating
}FigureSoundType;

typedef enum{
	FoodTasteWillNotEat,
	FoodTasteGood,
	FoodTasteNotGood,
	FoodTasteYummy
} FoodTasteType;


//其实是眼睛eyes的动作
typedef enum {
	AnimationDirectionUp,
    AnimationDirectionUpRight,
	AnimationDirectionRight,
    AnimationDirectionRightDown,
	AnimaitonDirectionDown,
    AnimationDirectionDownLeft,
	AnimationDirectionLeft,
    AnimationDirectionLeftUp
}AnimationDirection;

