/**
 *  KCZman.m
 *  KosherCocoa 3
 *
 *  Created by Moshe Berman on 4/8/15.
 *
 *  Use of KosherCocoa 3 is governed by the LGPL 2.1 License.
 */

#import "KCZman.h"

NS_ASSUME_NONNULL_BEGIN

@interface KCZman ()

@end

@implementation KCZman

#pragma mark - Instantiating a Zman

/** ---
 *  @name Instantiating a Zman
 *  ---
 */

/**
 *  Takes a selector and converts it into a KCZman object.
 *
 *  @return A zman object for the supplied selector.
 */

+ (KCZman *)zmanForSelector:(SEL)selector
{
    return [[KCZman alloc] initWithSelector:selector];
}

/**
 *  Instantiates a zman for the supplied selector.
 *
 *  @return A zman with with the supplied selector.
 */

- (nonnull instancetype)initWithSelector:(nonnull SEL)selector
{
    self = [super init];
    
    if (self)
    {
        _selector = selector;
    }
    
    return self;
}

#pragma mark - Display Name

/** ---
 *  @name Display Name
 *  ---
 */

/**
 *  The hebrew name of the zman.
 *
 *  @return The name of the zman, in Hebrew.
 */

- (NSString *)hebrewName
{
    return [self _metadataForCurrentZman][@"koshercocoa.name.hebrew"];
}

/**
 *  The transliterated name of the zman, using the ashkenazic pronunciation.
 *
 *  @discussion Transliterations use the Ashkenazic pronunciation. (For example: "Alos" for sunrise.)
 *
 *  @return The name of the zman.
 */

- (NSString *)transliteratedNameAshkenazic
{
    return [self _metadataForCurrentZman][@"koshercocoa.name.transliterated.ashkenaz"];
}

/**
 *  The transliterated name of the zman, using the sephardic pronunciation.
 *
 *  @discussion Transliterations use the sephardic pronunciation. (For example: "Alot" for sunrise.)
 *
 *  @return The name of the zman.
 */

- (NSString *)transliteratedNameSephardic
{
    return [self _metadataForCurrentZman][@"koshercocoa.name.transliterated.sepharad"];
}

/**
 *  The name of the zman in English.
 *
 *  @return The name of the zman.
 */

- (NSString *)englishName
{
    return [self _metadataForCurrentZman][@"koshercocoa.name.english"];
}

#pragma mark - Explanation

/** ---
 *  @name Explanation
 *  ---
 */

/**
 *  The explanation for the zman.
 *
 *  @return An explanation of the halachic background behind the zman.
 */

- (NSString *)explanation
{
    return [self _metadataForCurrentZman][@"koshercocoa.explanation.english"];
}

#pragma mark - Related Zmanim

/** ---
 *  @name Related Zmanim
 *  ---
 */

/**
 *  Other zmanim that are related to this zman.
 *
 *  @discussion Related zmanim are other versions of the same zman. Related zmanim always contains self.
 *
 *  @return An NSArray of SEL objects that are related to this zman.
 */

- (NSArray *)relatedZmanim
{
    NSString *selectorAsString = NSStringFromSelector(self.selector);
    NSArray *related = @[selectorAsString]; //  By default, return the array of just this selector.
    
    NSArray* sets = [KCZman relatedZmanimMapping];
    
    for (NSArray *array in sets)
    {
        if ([array containsObject:selectorAsString])
        {
            related = array;
            break;
        }
    }
    
    return related;
}

/**
 * A mapping of related calculations.
 *
 *  @return A nested array of zmanim selectors, each group containing related selectors.
 */

+ (NSArray<NSArray<NSString* >* >*)relatedZmanimMapping
{
    /**
     *  All of the related sets
     */
    
    static NSArray* sets = nil;
    
    if (sets == nil)
    {
        
        sets = @[
                 /**
                  *    Sha'ah Zmanis
                  */
                 
                 @[
                     NSStringFromSelector(@selector(shaahZmanisMogenAvraham)),
                     NSStringFromSelector(@selector(shaahZmanisGra)),
                     NSStringFromSelector(@selector(shaahZmanis16Point1Degrees)),
                     NSStringFromSelector(@selector(shaahZmanis18Degrees)),
                     NSStringFromSelector(@selector(shaahZmanis19Point8Degrees)),
                     NSStringFromSelector(@selector(shaahZmanis26Degrees)),
                     NSStringFromSelector(@selector(shaahZmanis60Minutes)),
                     NSStringFromSelector(@selector(shaahZmanis72Minutes)),
                     NSStringFromSelector(@selector(shaahZmanis72MinutesZmanis)),
                     NSStringFromSelector(@selector(shaahZmanis90Minutes)),
                     NSStringFromSelector(@selector(shaahZmanis90MinutesZmanis)),
                     NSStringFromSelector(@selector(shaahZmanis96Minutes)),
                     NSStringFromSelector(@selector(shaahZmanis96MinutesZmanis)),
                     NSStringFromSelector(@selector(shaahZmanisAteretTorah)),
                     NSStringFromSelector(@selector(shaahZmanis120Minutes)),
                     NSStringFromSelector(@selector(shaahZmanis120MinutesZmanis))
                     ],
                 
                 /**
                  *    Alos
                  */
                 
                 @[
                     NSStringFromSelector(@selector(alosHashachar)),
                     NSStringFromSelector(@selector(alos72)),
                     NSStringFromSelector(@selector(alos60)),
                     NSStringFromSelector(@selector(alos72Zmanis)),
                     NSStringFromSelector(@selector(alos90)),
                     NSStringFromSelector(@selector(alos90Zmanis)),
                     NSStringFromSelector(@selector(alos96)),
                     NSStringFromSelector(@selector(alos96Zmanis)),
                     NSStringFromSelector(@selector(alos120)),
                     NSStringFromSelector(@selector(alos120Zmanis)),
                     NSStringFromSelector(@selector(alos26Degrees)),
                     NSStringFromSelector(@selector(alos18Degrees)),
                     NSStringFromSelector(@selector(alos19Point8Degrees)),
                     NSStringFromSelector(@selector(alos16Point1Degrees))
                     ],
                 
                 /**
                  *    Misheyakir
                  */
                 
                 @[
                     NSStringFromSelector(@selector(misheyakir10Point2Degrees)),
                     NSStringFromSelector(@selector(misheyakir11Degrees)),
                     NSStringFromSelector(@selector(misheyakir11Point5Degrees)),
                     NSStringFromSelector(@selector(misheyakirAteretTorahWithMinutes:))
                     ],
                 
                 /**
                  *    Sunrise
                  */
                 
                 @[
                     NSStringFromSelector(@selector(sunrise))
                     ],
                 
                 /**
                  *    Sof Zman Shma
                  */
                 
                 @[
                     NSStringFromSelector(@selector(sofZmanShmaGra)),
                     NSStringFromSelector(@selector(sofZmanShmaMogenAvraham)),
                     NSStringFromSelector(@selector(sofZmanShmaFixedLocal)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA19Point8Degrees)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA16Point1Degrees)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA72Minutes)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA72MinutesZmanis)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA90Minutes)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA90MinutesZmanis)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA96Minutes)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA96MinutesZmanis)),
                     NSStringFromSelector(@selector(sofZmanShma3HoursBeforeChatzos)),
                     NSStringFromSelector(@selector(sofZmanShmaMGA120Minutes)),
                     NSStringFromSelector(@selector(sofZmanShmaAlos16Point1ToSunset)),
                     NSStringFromSelector(@selector(sofZmanShmaAlos16Point1ToTzaisGeonim7Point083Degrees)),
                     ],
                 
                 /**
                  *    Sof Zman Tfila
                  */
                 
                 @[
                     NSStringFromSelector(@selector(sofZmanTfilaMogenAvraham)),
                     NSStringFromSelector(@selector(sofZmanTfilaGra)),
                     NSStringFromSelector(@selector(sofZmanTfilaFixedLocal)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA19Point8Degrees)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA16Point1Degrees)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA72Minutes)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA72MinutesZmanis)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA90Minutes)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA90MinutesZmanis)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA96Minutes)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA96MinutesZmanis)),
                     NSStringFromSelector(@selector(sofZmanTfilaMGA120Minutes)),
                     NSStringFromSelector(@selector(sofZmanTfila2HoursBeforeChatzos))
                     ],
                 
                 /**
                  *    Chatzos
                  */
                 
                 @[
                     NSStringFromSelector(@selector(chatzos)),
                     NSStringFromSelector(@selector(fixedLocalChatzos))
                     ],
                 
                 /**
                  *    Mincha Gedola
                  */
                 
                 @[
                     NSStringFromSelector(@selector(minchaGedola)),
                     NSStringFromSelector(@selector(minchaGedola72Minutes)),
                     NSStringFromSelector(@selector(minchaGedola30Minutes)),
                     NSStringFromSelector(@selector(minchaGedola16Point1Degrees)),
                     NSStringFromSelector(@selector(minchaGedolaGreaterThan30)),
                     NSStringFromSelector(@selector(minchaGedolaAteretTorah))
                     ],
                 
                 /**
                  *    Mincha Ketana
                  */
                 
                 @[
                     NSStringFromSelector(@selector(minchaKetana)),
                     NSStringFromSelector(@selector(minchaKetana16Point1Degrees)),
                     NSStringFromSelector(@selector(minchaKetana72Minutes)),
                     NSStringFromSelector(@selector(minchaKetanaAteretTorah))
                     ],
                 
                 /**
                  *    Plag Hamincha
                  */
                 
                 @[
                     NSStringFromSelector(@selector(plagHamincha)),
                     NSStringFromSelector(@selector(plagHamincha60Minutes)),
                     NSStringFromSelector(@selector(plagHamincha72Minutes)),
                     NSStringFromSelector(@selector(plagHamincha72MinutesZmanis)),
                     NSStringFromSelector(@selector(plagHamincha90Minutes)),
                     NSStringFromSelector(@selector(plagHamincha90MinutesZmanis)),
                     NSStringFromSelector(@selector(plagHamincha96Minutes)),
                     NSStringFromSelector(@selector(plagHamincha96MinutesZmanis)),
                     NSStringFromSelector(@selector(plagHamincha16Point1Degrees)),
                     NSStringFromSelector(@selector(plagHamincha18Degrees)),
                     NSStringFromSelector(@selector(plagHamincha19Point8Degrees)),
                     NSStringFromSelector(@selector(plagHamincha26Degrees)),
                     NSStringFromSelector(@selector(plagAlosToSunset)),
                     NSStringFromSelector(@selector(plagAlos16Point1ToTzaisGeonim7Point083Degrees))
                     ],
                 
                 /**
                  *    Sunset
                  */
                 
                 @[
                     NSStringFromSelector(@selector(sunset))
                     ],
                 
                 /**
                  *  Bain Hashmashos
                  */
                 
                 @[
                     NSStringFromSelector(@selector(bainHashmashosRT13Degrees)),
                     NSStringFromSelector(@selector(bainHashmashosRT58Point5Minutes)),
                     NSStringFromSelector(@selector(bainHashmashosRT13Point5MinutesBefore7Point083Degrees)),
                     NSStringFromSelector(@selector(bainHashmashosRT2Stars))
                     ],
                 
                 /**
                  *    Tzais
                  */
                 
                 @[
                     NSStringFromSelector(@selector(tzais)),
                     NSStringFromSelector(@selector(tzaisGeonim5Point95Degrees)),
                     NSStringFromSelector(@selector(tzaisGeonim5Point88Degrees)),
                     NSStringFromSelector(@selector(tzaisGeonim3Point65Degrees)),
                     NSStringFromSelector(@selector(tzaisGeonim4Point37Degrees)),
                     NSStringFromSelector(@selector(tzaisGeonim4Point61Degrees)),
                     NSStringFromSelector(@selector(tzaisGeonim4Point8Degrees)),
                     NSStringFromSelector(@selector(tzaisGeonim7Point083Degrees)),
                     NSStringFromSelector(@selector(tzaisGeonim8Point5Degrees)),
                     NSStringFromSelector(@selector(tzais50)),
                     NSStringFromSelector(@selector(tzais60)),
                     NSStringFromSelector(@selector(tzaisAteretTorah)),
                     NSStringFromSelector(@selector(tzais72)),
                     NSStringFromSelector(@selector(tzais72Zmanis)),
                     NSStringFromSelector(@selector(tzais90)),
                     NSStringFromSelector(@selector(tzais90Zmanis)),
                     NSStringFromSelector(@selector(tzais96)),
                     NSStringFromSelector(@selector(tzais96Zmanis)),
                     NSStringFromSelector(@selector(tzais120)),
                     NSStringFromSelector(@selector(tzais120Zmanis)),
                     NSStringFromSelector(@selector(tzais16Point1Degrees)),
                     NSStringFromSelector(@selector(tzais26Degrees)),
                     NSStringFromSelector(@selector(tzais18Degrees)),
                     NSStringFromSelector(@selector(tzais19Point8Degrees)),
                     ],
                 
                 /**
                  *    Achilas Chametz
                  */
                 
                 @[
                     NSStringFromSelector(@selector(sofZmanAchilasChametzGra)),
                     NSStringFromSelector(@selector(sofZmanAchilasChametzMGA72Minutes)),
                     NSStringFromSelector(@selector(sofZmanAchilasChametzMGA16Point1Degrees))
                     ],
                 
                 /**
                  *    Biur Chametz
                  */
                 
                 @[
                     NSStringFromSelector(@selector(sofZmanBiurChametzGra)),
                     NSStringFromSelector(@selector(sofZmanBiurChametzMGA72Minutes)),
                     NSStringFromSelector(@selector(sofZmanBiurChametzMGA16Point1Degrees))
                     ]
                 ];
    }
    
    return sets;
}

/**
 *  The list of zmanim metadata.
 *
 *  @return An NSDictionary containing data for all of the zmanim.
 */

+ (NSDictionary<NSString*,NSDictionary<NSString*, NSString*>*>*)metadata
{
    
    static NSDictionary *data = nil;
    
    if (data == nil)
    {
        data = @{
                 NSStringFromSelector(@selector(shaahZmanisMogenAvraham)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (מ״א)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (M'A)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (M'A)",
                         @"koshercocoa.name.english" : @"Temporal Hour (M'A)",
                         @"koshercocoa.explanation.english" : @"A temporal hour according to the opinion of the Mogen Avraham. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk (for Sof Zman Shema  and Sof Zman Tefila). Dawn for this calculation is 72 minutes before sunrise and dusk is 72 minutes after sunset. This day is split into 12 equal parts with each part being a temporal hour."
                         },
                 
                 NSStringFromSelector(@selector(shaahZmanisGra)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (גר״א)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (Gr'a)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (Gr'a)",
                         @"koshercocoa.name.english" : @"Temporal Hour (Gr'a)",
                         @"koshercocoa.explanation.english" : @"A temporal hour according to the opinion of the Gra and the Baal Hatanya. This calculation divides the day based on the opinion of the GRA and the Baal Hatanya that the day runs from sunrise to sunset. The calculations are based on a day from sea level sunrise to sea level sunset. The day is split into 12 equal parts with each one being a shaah zmanis. An explanation and detailed sources for not using elevation for anything besides sunrise and sunset can be found in Zmanim Kehilchasam (second edition published in 2007) by Rabbi Dovid Yehuda Bursztyn chapter 2. (pages 186-187)"
                         },
                 NSStringFromSelector(@selector(shaahZmanis16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (16.1 מעלות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (16.1 Maalos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (16.1 Maalot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (16.1 Degrees)",
                         @"koshercocoa.explanation.english" : @"A temporal hour calculated using a 16.1 degree dip. This calculation divides the day based on the opinion that the day runs from dawn to dusk. Dawn for this calculation is when the sun is 16.1 degrees below the eastern geometric horizon before sunrise. Dusk for this is when the sun is 16.1 degrees below the western geometric horizon after sunset. This day is split into 12 equal parts with each part being a temporal hour."
                         },
                 NSStringFromSelector(@selector(shaahZmanis18Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (18 מעלות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (18 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (18 Ma'alot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (18 Degrees)",
                         @"koshercocoa.explanation.english" : @"A temporal hour calculated using an 18 degree dip. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is when the sun is 18 degrees below the eastern geometric horizon before sunrise. Dusk for this is when the sun is 18 degrees below the western geometric horizon after sunset. This day is split into 12 equal parts with each part being a temporal hour."
                         },
                 NSStringFromSelector(@selector(shaahZmanis19Point8Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (19.8 מעלות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (19.8 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (19.8 Ma'alot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (19.8 Degrees)",
                         @"koshercocoa.explanation.english" : @"A temporal hour calculated using a 19.8 degree dip. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is when the sun is 19.8 degrees below the eastern geometric horizon before sunrise. Dusk for this is when the sun is 19.8 degrees below the western geometric horizon after sunset. This day is split into 12 equal parts with each part being a temporal hour."
                         },
                 NSStringFromSelector(@selector(shaahZmanis26Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (26 מעלות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (26 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (26 Ma'alot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (26 Degrees)",
                         @"koshercocoa.explanation.english" : @"Temporal hour calculated using a 26 degree dip. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is when the sun is 26 degrees below the eastern geometric horizon before sunrise. Dusk for this is when the sun is 26 degree below the western geometric horizon after sunset. This day is split into 12 equal parts with each part being a temporal hour."
                         },
                 NSStringFromSelector(@selector(shaahZmanis60Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (60 דקות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (60 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (60 Dakot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (60 Minutes)",
                         @"koshercocoa.explanation.english" : @"Temporal hour according to the opinion of the Mogen Avraham. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is 60 minutes before sunrise and dusk is 60 minutes after sunset. This day is split into 12 equal parts with each part being a temporal hour."
                         },
                 NSStringFromSelector(@selector(shaahZmanis72Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (72 דקות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (72 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (72 Dakot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (72 Minutes)",
                         @"koshercocoa.explanation.english" : @"Temporal hour according to the opinion of the Mogen Avraham. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is 72 minutes before sunrise and dusk is 72 minutes after sunset. This day is split into 12 equal parts with each part being a temporal hour."
                         },
                 NSStringFromSelector(@selector(shaahZmanis72MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (72 דקות זמנית)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (72 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (72 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (72 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"Temporal hour according to the opinion of the Mogen Avraham based on alos being 72 minutes zmaniyos before sunrise. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is 72 minutes zmaniyos before sunrise and dusk is 72 minutes zmaniyos after sunset. This day is split into 12 equal parts with each part being a shaah zmanis. This is identical to 1/10th of the day from sunrise to sunset."
                         },
                 NSStringFromSelector(@selector(shaahZmanis90Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (90 דקות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (90 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (90 Dakot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (90 Minutes)",
                         @"koshercocoa.explanation.english" : @"Temporal hour calculated using a dip of 90 minutes. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is 90 minutes before sunrise and dusk is 90 minutes after sunset. This day is split into 12 equal parts with each part being a shaah zmanis."
                         },
                 NSStringFromSelector(@selector(shaahZmanis90MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (90 דקות זמנית)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (90 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (90 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (90 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"Temporal hour according to the opinion of the Mogen Avraham based on alos being 90 minutes zmaniyos before sunrise. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is 90 minutes zmaniyos before sunrise and dusk is 90 minutes zmaniyos after sunset. This day is split into 12 equal parts with each part being a shaah zmanis. This is identical to 1/8th of the day from sunrise to sunset."
                         },
                 NSStringFromSelector(@selector(shaahZmanis96Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (96 דקות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (96 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (96 Dakot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (96 Minutes)",
                         @"koshercocoa.explanation.english" : @"Temporal hour calculated using a dip of 96 minutes. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is 96 minutes before sunrise and dusk is 96 minutes after sunset. This day is split into 12 equal parts with each part being a shaah zmanis."
                         },
                 NSStringFromSelector(@selector(shaahZmanis96MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (96 דקות זמנית)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (96 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (96 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (96 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"Temporal hour according to the opinion of the Mogen Avraham based on alos being 96 minutes zmaniyos before sunrise. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is 96 minutes zmaniyos before sunrise and dusk is 96 minutes zmaniyos after sunset. This day is split into 12 equal parts with each part being a shaah zmanis. This is identical to 1/7.5th of the day from sunrise to sunset."
                         },
                 NSStringFromSelector(@selector(shaahZmanisAteretTorah)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (עטרת תורה)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (Ateret Torah)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (Ateret Torah)",
                         @"koshercocoa.name.english" : @"Temporal Hour (Ateret Torah)",
                         @"koshercocoa.explanation.english" : @"Temporal hour according to the opinion of the Chacham Yosef Harari-Raful of Yeshivat Ateret Torah calculated with alos being 1/10th of sunrise to sunset day, or 72 minutes zmaniyos of such a day before sunrise, and tzais is usually calculated as 40 minutes (configurable to any offset by modifying AteretTorahSunsetOffset) after sunset. This day is split into 12 equal parts with each part being a shaah zmanis. Note that with this system, mid-day) will not be the point that the sun is halfway across the sky."
                         },
                 NSStringFromSelector(@selector(shaahZmanis120Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (120 דקות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (120 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (120 Dakot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (120 Minutes)",
                         @"koshercocoa.explanation.english" : @"A temporal hour calculated using a dip of 120 minutes. This calculation divides the day based on the opinion of the Mogen Avraham that the day runs from dawn to dusk. Dawn for this calculation is 120 minutes before sunrise and dusk is 120 minutes after sunset. This day is split into 12 equal parts with each part being a temporal-hour."
                         },
                 NSStringFromSelector(@selector(shaahZmanis120MinutesZmanis))  : @{
                         @"koshercocoa.name.hebrew" : @"שעה זמנית (120 דקות זמנית)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sha'ah Zmanis (120 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sha'ah Zmanit (120 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Temporal Hour (120 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha based on sunrise being 120 minutes zmaniyos (GRA and the Baal Hatanya) or 1/6th of the day before sea level sunrise. This is calculated as 10.75 hours after dawn."
                         },
                 /**
                  *    Alos
                  */
                 
                 
                 NSStringFromSelector(@selector(alosHashachar))  : @{
                         @"koshercocoa.name.hebrew" : @"עלות השחר",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos HaShachar",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot HaShachar",
                         @"koshercocoa.name.english" : @"Dawn",
                         @"koshercocoa.explanation.english" : @"Based on the time when the sun is 16.1º below the eastern geometric horizon before sunrise."
                         },
                 
                 NSStringFromSelector(@selector(alos72))  : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (72 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (72 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (72 Dakot)",
                         @"koshercocoa.name.english" : @"Dawn (72 minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated using 72 minutes before sunrise at sea level (no adjustment for elevation) based on the time to walk the distance of 4 Mil at 18 minutes a Mil. This is based on the opinion of most Rishonim who stated that the time of the Neshef (time between dawn and sunrise) does not vary by the time of year or location but purely depends on the time it takes to walk the istance of 4 Mil."
                         },
                 NSStringFromSelector(@selector(alos60)) : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (60 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (60 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (60 Dakot)",
                         @"koshercocoa.name.english" : @"Dawn (60 Minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated as 60 minutes before sea level sunrise.  This is the time to walk the distance of 4 Mil at 15 minutes a Mil (the opinion of the Chavas Yair. See the Divray Malkiel). Time based offset calculations for alos are based on the opinion of most Rishonim who stated that the time of the Neshef (time between dawn and sunrise) does not vary by the time of year or location but purely depends on the time it takes to walk the distance of 4 Mil."
                         },
                 NSStringFromSelector(@selector(alos72Zmanis))  : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (72 דקות זמניות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (72 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (72 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Dawn (72 Minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated using 72 minutes zmaniyos (GRA and the Baal Hatanya)  or 1/10th of the day before sea level sunrise. This is based on an 18 minute Mil so the time for 4 Mil is 72 minutes which is 1/10th of a day (12 * 60 = 720) based on the day starting at sea level sunrise and ending at sea level sunset. This calculation is used in the calendars published by Hisachdus Harabanim D'Artzos Habris Ve'Canada."
                         },
                 NSStringFromSelector(@selector(alos90)) : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (90 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (90 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (90 Dakot)",
                         @"koshercocoa.name.english" : @"Dawn (90 Minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated using 90 minutes before sea level sunrise based on the time to walk the distance of 4 Mil at 22.5 minutes a Mil. Time based offset calculations for alos are based on the opinion of most Rishonim who stated that the time of the Neshef (time between dawn and sunrise) does not vary by the time of year or location but purely depends on the time it takes to walk the distance of 4 Mil."
                         },
                 NSStringFromSelector(@selector(alos90Zmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (90 דקות זמניות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (90 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (90 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Dawn (90 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated using 90 minutes zmaniyos (GRA and the Baal Hatanya)  or 1/8th of the day before sea level sunrise. This is based on a 22.5 minute Mil so the time for 4 Mil is 90 minutes which is 1/8th of a day (12 * 60) / 8 = 90  based on the day starting at sunrise and ending at sunset."
                         },
                 NSStringFromSelector(@selector(alos96))  : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (96 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (96 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (96 Dakot)",
                         @"koshercocoa.name.english" : @"Dawn (96 Minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated using 96 minutes before sea level sunrise based on the time to walk the distance of 4 Mil at 24 minutes a Mil. Time based offset calculations for alos are based on the opinion of most Rishonim who stated that the time of the Neshef (time between dawn and sunrise) does not vary by the time of year or location but purely depends on the time it takes to walk the distance of 4 Mil."
                         },
                 NSStringFromSelector(@selector(alos96Zmanis))  : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (96 דקות זמניות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (96 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (96 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Dawn (96 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated using 96 minutes zmaniyos (GRA and the Baal Hatanya)  or 1/8th of the day before sea level sunrise. This is based on a 24 minute Mil so the time for 4 Mil is 96 minutes which is 1/7.5th of a day (12 * 60) / 7.5 = 96 based on the day starting at sunrise and ending at sunset."
                         },
                 NSStringFromSelector(@selector(alos120))  : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (120 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (120 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (120 Dakot)",
                         @"koshercocoa.name.english" : @"Dawn (120 Minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated using 120 minutes before sea level sunrise based on the time to walk the distance of 5 Mil at 24 minutes a Mil. (No adjustment for elevation is made.) Time based offset calculations for alos are based on the opinion of most Rishonim who stated that the time of the Neshef (time between dawn and sunrise) does not vary by the time of year or location but purely depends on the time it takes to walk the distance of 5 Mil."
                         },
                 NSStringFromSelector(@selector(alos120Zmanis))  : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (120 דקות זמניות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (120 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (120 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Dawn (120 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated using 120 minutes zmaniyos (GRA and the Baal Hatanya) or 1/6th of the day before sea level sunrise. This is based on a 24 minute Mil so the time for 5 Mil is 120 minutes which is 1/6th of a day (12 * 60) / 6 = 120 based on the day starting at sunrise and ending at sunset."
                         },
                 
                 NSStringFromSelector(@selector(alos26Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (96 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (26 Ma'alot)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (26 Ma'alot)",
                         @"koshercocoa.name.english" : @"Dawn (26 Degrees)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated when the sun is 26° below the eastern geometric horizon before sunrise. This calculation is based on the same calculation of 120 minutes but uses a degree based calculation instead of 120 exact minutes. This calculation is based on the position of the sun 120 minutes before sunrise in Jerusalem during the equinox which calculates to 26° below geometric zenith."
                         },
                 NSStringFromSelector(@selector(alos18Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (18 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (18 Ma'alot)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (18 Ma'alot)",
                         @"koshercocoa.name.english" : @"Dawn (18 Degrees)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated when the sun is 18° below the eastern geometric horizon before sunrise."
                         },
                 NSStringFromSelector(@selector(alos19Point8Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"(עלות (19.8 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (19.8 Ma'alot)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (19.8 Ma'alot)",
                         @"koshercocoa.name.english" : @"Dawn (19.8 Degrees)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated when the sun is 19.8° below the eastern geometric horizon before sunrise. This calculation is based on the same calculation of 90 minutes but uses a degree based calculation instead of 90 exact minutes. This calculation is based on the position of the sun 90 minutes before sunrise in Jerusalem during the equinox which calculates to 19.8° below geometric zenith"
                         },
                 NSStringFromSelector(@selector(alos16Point1Degrees))  : @{
                         @"koshercocoa.name.hebrew" : @"(עלותå (16.1 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Alos (16.1 Ma'alot)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Alot (16.1 Ma'alot)",
                         @"koshercocoa.name.english" : @"Dawn (16.1 Degrees)",
                         @"koshercocoa.explanation.english" : @"Dawn calculated when the sun is 16.1° below the eastern geometric horizon before sunrise. This calculation is based on the same calculation of 72 minutes but uses a degree based calculation instead of 72 exact minutes. This calculation is based on the position of the sun 72 minutes before sunrise in Jerusalem during the equinox which calculates to 16.1° below geometric zenith."
                         },
                 
                 /**
                  *    Misheyakir
                  */
                 
                 NSStringFromSelector(@selector(misheyakir10Point2Degrees))  : @{
                         @"koshercocoa.name.hebrew" : @"(משיכיר (10.2 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Misheyakir (10.2 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Misheyakir (10.2 Ma'alot)",
                         @"koshercocoa.name.english" : @"The misheyakir (10.2 Degrees)",
                         @"koshercocoa.explanation.english" : @"The misheyakir based on the position of the sun when it is 10.2° below geometric zenith (90°). This calculation is based on the position of the sun 45 minutes before sunrise in Jerusalem during the equinox which calculates to 10.2° below geometric zenith.\n\nThis can't be computed in some areas such as northern and southern locations even south of the Arctic Circle and north of the Antarctic Circle, because the sun may not reach low enough below the horizon."
                         },
                 NSStringFromSelector(@selector(misheyakir11Degrees))  : @{
                         @"koshercocoa.name.hebrew" : @"(משיכיר (11 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Misheyakir (11 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Misheyakir (11 Ma'alot)",
                         @"koshercocoa.name.english" : @"The misheyakir (11 Degrees)",
                         @"koshercocoa.explanation.english" : @"The misheyakir based on the position of the sun when it is 11° below geometric zenith (90°). This calculation is based on the position of the sun 48 minutes before sunrise in Jerusalem during the equinox which calculates to 11° below geometric zenith.\n\nThis can't be computed in some areas such as northern and southern locations even south of the Arctic Circle and north of the Antarctic Circle,because the sun may not reach low enough below the horizon."
                         },
                 NSStringFromSelector(@selector(misheyakir11Point5Degrees))  : @{
                         @"koshercocoa.name.hebrew" : @"(משיכיר (11.5 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Misheyakir (11.5 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Misheyakir (11.5 Ma'alot)",
                         @"koshercocoa.name.english" : @"The misheyakir (11.5 Degrees)",
                         @"koshercocoa.explanation.english" : @"The misheyakir based on the position of the sun when it is 11.5° below geometric zenith (90°). This calculation is based on the position of the sun 52 minutes before sunrise in Jerusalem during the equinox which calculates to 11.5° below geometric zenith.\n\nThis can't be computed in some areas such as northern and southern locations even south of the Arctic Circle and north of the Antarctic Circle, because the sun may not reach low enough below the horizon."
                         },
                 NSStringFromSelector(@selector(misheyakirAteretTorahWithMinutes:))  : @{
                         @"koshercocoa.name.hebrew" : @"משיכיר (עטרת תורה)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Misheyakir (Ateret Torah)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Misheyakir (Ateret Torah)",
                         @"koshercocoa.name.english" : @"First Sunlight (Ateret Torah)",
                         @"koshercocoa.explanation.english" : @"The misheyakir as an offset the Alos 72 minutes, zmanis calculation."
                         },
                 /**
                  *   Sunrise
                  */
                 
                 NSStringFromSelector(@selector(sunrise))  : @{
                         @"koshercocoa.name.hebrew" : @"נץ החמה",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Naitz Hachama",
                         @"koshercocoa.name.transliterated.sepharad" : @"Netz Hachama",
                         @"koshercocoa.name.english" : @"Sunrise",
                         @"koshercocoa.explanation.english" : @"Sunrise at the current location. The zenith used for the calculation uses geometric zenith of 90 degrees plus elevation. This is adjusted to add approximately 50/60 of a degree to account for 34 archminutes of refraction and 16 archminutes for the sun's radius for a total of 90.83333 degrees."
                         },
                 
                 /**
                  *    Sof Zman Shma
                  */
                 
                 NSStringFromSelector(@selector(sofZmanShmaGra))  : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (גר\"א",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (Gr'a)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (Gr'a",
                         @"koshercocoa.name.english" : @"Latest Shema (Gr'a)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning). This time is 3 shaos zmaniyos (solar hours) after sea level sunrise based on the opinion of the GRA and the Baal Hatanya that the day is calculated from sunrise to sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMogenAvraham)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (מ\"א",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kriyat Sh'ma (M'A)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite shema in the morning) in the opinion of the MGA based on alos being 72 minutes before sunrise. This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the Mogen Avraham that the day is calculated from a dawn of 72 minutes before sunrise to nightfall of 72 minutes after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaFixedLocal)) : @{
                         @"koshercocoa.name.hebrew" : @"סוף זמן קריאת שמע (קבוע)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (Kavua)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (Kavua)",
                         @"koshercocoa.name.english" : @"Latest Shema (Fixed Local)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) calculated as 3 hours before fixed local chatzos."
                         },
                 
                 NSStringFromSelector(@selector(sofZmanShmaMGA19Point8Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע  (מ\"א 19.8 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 19.8 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 19.8 Ma'alot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 19.8 Degrees)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) according to the opinion of the MGA based on alos being 19.8° before sunrise. This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the MGA that the day is calculated from dawn to nightfall with both being 19.8° below sunrise or sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMGA16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע  (מ\"א 16.1 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 16.1 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 16.1 Ma'alot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 16.1 Degrees)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) according to the opinion of the MGA based on alos being 16.1° before sunrise. This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the MGA that the day is calculated from dawn to nightfall with both being 16.1° below sunrise or sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMGA72Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (מ\"א 72 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 72 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 72 Dakot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 72 Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) according to the opinion of the MGA based on alos being 72 minutes before sunrise.  This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 72 minutes before sunrise to nightfall of 72 minutes after sunset. This is an identical time to the MGA."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMGA72MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (מ\"א 72 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 72 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 72 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 72 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) according to the opinion of the MGA based on alos being 72 minutes zmaniyos , or 1/10th of the day before sunrise. This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 72 minutes zmaniyos,  or 1/10th of the day before sea level sunrise to nightfall of 72 minutes zmaniyos after sea  level sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMGA90Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (מ\"א 90 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 90 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 90 Dakot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 90 Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning)  according to the opinion of the Magen Avraham based on alos being 90 minutes before sunrise.  This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 90 minutes before sunrise to nightfall of 90 minutes after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMGA90MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (מ\"א 90 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 90 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 90 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 90 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) according to the opinion of the MGA based on alos being 90 minutes zmaniyos before sunrise.  This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 90 minutes zmaniyos before sunrise to nightfall of 90 minutes zmaniyos after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMGA96Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (מ\"א 96 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 96 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 96 Dakot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 96 Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) according to the opinion of the MGA based on alos being 96 minutes before sunrise.  This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 96 minutes before sunrise to nightfall of 96 minutes after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMGA96MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (מ\"א 96 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 96 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 96 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 96 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) according to the opinion of the MGA based on alos being 96 minutes zmaniyos before sunrise.  This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 96 minutes zmaniyos before sunrise to nightfall of 96 minutes zmaniyos after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanShma3HoursBeforeChatzos)) : @{
                         @"koshercocoa.name.hebrew" : @"סוף זמן קריאת שמע (3 שעות לפני חצות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (3 Shaos Lifnei Chatzos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (3 Shaot L'fnei Chatzot)",
                         @"koshercocoa.name.english" : @"Latest Shema (3 Hours before Chatzot)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) calculated as 3 hours (regular and not zmaniyos) before chatzos. This is the opinion of the Shach in the Nekudas Hakesef (Yora Deah 184), Shevus Yaakov, Chasam Sofer and others."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaMGA120Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן קריאת שמע (מ\"א 9120 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (M'A 120 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (M'A 120 Dakot)",
                         @"koshercocoa.name.english" : @"Latest Shema (M'A 120 Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) according to the opinion of the Magen Avraham based on alos being 120 minutes or 1/6th of the day before sunrise. This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 120 minutes before sunrise to nightfall of 120 minutes after sunset. "
                         },
                 NSStringFromSelector(@selector(sofZmanShmaAlos16Point1ToSunset)) : @{
                         @"koshercocoa.name.hebrew" : @"סוף זמן קריאת שמע (16.1 לפני שקיעה)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (16.1 Lifnei Shkiya)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (16.1 L'fnei Shki'a)",
                         @"koshercocoa.name.english" : @"Latest Shema (16.1 Degrees before Sunset)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) based on the opinion that the day starts at alos 16.1° and ends at sea level sunset. 3 shaos zmaniyos are calculated based on this day and added to alosto reach this time.  This time is 3 shaos zmaniyos (solar hours) after dawn based on the opinion that the day is calculated from a alos 16.1° to sea level sunset. Note: Based on this calculation chatzos will not be at midday."
                         },
                 NSStringFromSelector(@selector(sofZmanShmaAlos16Point1ToTzaisGeonim7Point083Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"סוף זמן קריאת שמע (16.1 עד צאת גאונים)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Kriyas Sh'ma (16.1 Ad Tzais Geonim)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Kri'at Sh'ma (16.1 Ad Tzait Ge'onim)",
                         @"koshercocoa.name.english" : @"Latest Shema (16.1 Until Gaonic Nightfall)",
                         @"koshercocoa.explanation.english" : @"The latest zman krias shema (time to recite Shema in the morning) based on the opinion that the day starts at alos 16.1° and ends at tzais 7.083°. 3 shaos zmaniyos are calculated based on this day and added to alos to reach this time. This time is 3 shaos zmaniyos (temporal hours) after alos 16.1° based on the opinion that the day is calculated from a alos 16.1° to tzais 7.083°. Note: Based on this calculation chatzos will not be at midday."
                         },
                 /**
                  *    Sof Zman Tfila
                  */
                 
                 NSStringFromSelector(@selector(sofZmanTfilaMogenAvraham))  : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tefila (M'A)",
                         @"koshercocoa.name.english" : @"Latest Tefila (M'A)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) in the opinion of the MGA based on alos being 72 minutes before sunrise. This time is 4 shaos zmaniyos (temporal hours) after dawn based on the opinion of the MGA that the day is calculated from a dawn} of 72 minutes before sunrise to nightfall} of 72 minutes after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaGra)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (גר\"א",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (Gr'a)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tefila (Gr'a",
                         @"koshercocoa.name.english" : @"Latest Tefila (Gr'a)",
                         @"koshercocoa.explanation.english" : @"The latest zman tefilah (time to recite the morning prayers). This time is 4 hours into the day based on the opinion of the GRA and the Baal Hatanya that the day is calculated from sunrise to sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaFixedLocal)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (קבוע",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (Kavua)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tefila (Kavua)",
                         @"koshercocoa.name.english" : @"The latest Morning Prayers (Fixed Local)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) calculated as 2 hours before fixed local midday."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA19Point8Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א 19.8 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 19.8 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A 19.8 Ma'alot)",
                         @"koshercocoa.name.english" : @"The latest ime to recite the morning prayers (M'A 19.8 Degrees)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) according to the opinion of the Magen Avraham based on alos being 19.8° before sunrise.  This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from dawn to nightfall with both being 19.8° below sunrise or sunset. This returns the time of 4 * ShaahZmanis19Point8Degrees() after dawn."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה  (מ\"א 16.1 מעלות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 16.1 Ma'alos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A 16.1 Ma'alot)",
                         @"koshercocoa.name.english" : @"Latest Tefila (M'A 16.1 Degrees)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) according to the opinion of the Magen Avraham based on alos being 16.1° before sunrise. This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from dawn to nightfall with both being 16.1° below sunrise or sunset. This returns the time of 4 * ShaahZmanis16Point1Degrees() after dawn."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA72Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א 72 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 72 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A72 Dakot)",
                         @"koshercocoa.name.english" : @"Latest Tefila M'A 72 Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) according to the opinion of the Magen Avraham based on alos being 72 minutes before sunrise.  This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 72 minutes before sunrise to nightfall of 72 minutes after sunset. This returns the time of 4 * ShaahZmanis72Minutes() after dawn."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA72MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א 72 דקות זמניות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 72 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A72 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Latest Tefila (M'A 72 Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to the morning prayers) according to the opinion of the Magen Avraham based on alos being 72 minutes zmaniyos before sunrise.  This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 72 minutes zmaniyos before sunrise to nightfall of 72 minutes zmaniyos after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA90Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א 90 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 90 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A90 Dakot)",
                         @"koshercocoa.name.english" : @"Latest Tefila M'A 90 Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) according to the opinion of the Magen Avraham based on alos being 90 minutes before sunrise. This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 90 minutes before sunrise to nightfall of 90 minutes after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA90MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א 90 דקות זמניות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 90 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A 90 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Latest Tefila (M'A 90  Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to the morning prayers) according to the opinion of the Magen Avraham based on alos being 90 minutes zmaniyos before sunrise.  This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 90 minutes zmaniyos before sunrise to nightfall of 90 minutes zmaniyos after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA96Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א 96 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 96 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A96 Dakot)",
                         @"koshercocoa.name.english" : @"Latest Tefila M'A 90 Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) according to the opinion of the Magen Avraham based on alos being 96 minutes before sunrise. This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 96 minutes before sunrise to nightfall of 96 minutes after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA96MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א 96 דקות זמניות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 96 Dakos Zmaniyos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A96 Dakot Zmaniyot)",
                         @"koshercocoa.name.english" : @"Latest Tefila (M'A 96  Temporal Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to the morning prayers) according to the opinion of the Magen Avraham based on alos being 96 minutes zmaniyos before sunrise.  This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 96 minutes zmaniyos before sunrise to nightfall of 96 minutes zmaniyos after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanTfilaMGA120Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(סוף זמן תפילה (מ\"א 120 דקות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (M'A 120 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (M'A 120 Dakot)",
                         @"koshercocoa.name.english" : @"Latest Tefila M'A 120 Minutes)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) according to the opinion of the Magen Avraham based on alos being 120 minutes before sunrise. This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 120 minutes before sunrise to nightfall of 120 minutes after sunset."
                         },
                 NSStringFromSelector(@selector(sofZmanTfila2HoursBeforeChatzos))  : @{
                         @"koshercocoa.name.hebrew" : @"סוף זמן תפילה (2 שעות לפני חצות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Sof Zman Tefila (2 Shaos Lifnei Chatzos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Sof Zman Tfila (2 Sha'ot Lifnei Chatzot)",
                         @"koshercocoa.name.english" : @"Latest Tefila (2 Hours before Midday)",
                         @"koshercocoa.explanation.english" : @"The latest zman tfila (time to recite the morning prayers) calculated as 2 hours before ZmanimCalendar.getChatzos(). This is based on the opinions that calculate sof zman krias shema as SofZmanShma3HoursBeforeChatzos(). This returns the time of 2 hours before KCZmanimCalendar.Chatzos()."
                         },
                 
                 /** 
                  * Chatzos
                  */
                 NSStringFromSelector(@selector(chatzos))  : @{
                         @"koshercocoa.name.hebrew" : @"חצות",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Chatzos",
                         @"koshercocoa.name.transliterated.sepharad" : @"Chatzot",
                         @"koshercocoa.name.english" : @"Midday",
                         @"koshercocoa.explanation.english" : @"Midday following the opinion of the GRA that the day for Jewish halachic times start at sea level sunrise and ends at sea level sunset."
                         },
                 
                 NSStringFromSelector(@selector(fixedLocalChatzos))  : @{
                         @"koshercocoa.name.hebrew" : @"(חצות (קבוע",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Chatzos (Kavua)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Chatzot (Kavu'a)",
                         @"koshercocoa.name.english" : @"Midday (Fixed Local)",
                         @"koshercocoa.explanation.english" : @"This time is noon and midnight adjusted from standard time to account for the local latitude. The 360° of the globe divided by 24 calculates to 15° per hour with 4 minutes per degree, so at a longitude of 0 , 15, 30 etc... Chatzos is 12:00 noon. Lakewood, N.J., whose longitude is -74.2094, is 0.7906 away from the closest multiple of 15 at -75°. This is multiplied by 4 to yield 3 minutes and 10 seconds for a chatzos of 11:56:50. This calculation is not tied to the theoretical 15° timezones, but will adjust to the actual timezone and Daylight saving time."
                         },
                 
                 
                 /**
                  *    Mincha Gedola
                  */
                 
                 NSStringFromSelector(@selector(minchaGedola)) : @{
                         @"koshercocoa.name.hebrew" : @"מנחה גדולה",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Mincha Gedola",
                         @"koshercocoa.name.transliterated.sepharad" : @"Mincha Gedola",
                         @"koshercocoa.name.english" : @"Earliest Mincha",
                         @"koshercocoa.explanation.english" : @"The time of mincha ketana. This is the preferred earliest time to pray mincha in the opinion of the Rambam and others. This is calculated as 9.5 sea level solar hours after sea level sunrise. This calculation is calculated based on the opinion of the Vilna Ga'on and the Baal Hatanya that the day is calculated from sunrise to sunset."
                         },
                 NSStringFromSelector(@selector(minchaGedola30Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"מנחה גדולה (30 דקות)",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Mincha Gedolah (30 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Mincha G'dola (30 Dakot)",
                         @"koshercocoa.name.english" : @"Earliest Mincha",
                         @"koshercocoa.explanation.english" : @"This method returns mincha gedola calculated as 30 minutes after chatzos and not 1/2 of a shaah zmanis after chatzos as calculated according to the Mincha Gedola calculation. Some use this time to delay the start of mincha in the winter when 1/2 of a shaah zmanis is less than 30 minutes. One should not use this time to start mincha before the standard mincha gedola. See Shulchan Aruch Orach Chayim סימן רל״ג סעיף א׳ and the Shaar Hatziyon סעיף קטן ח."
                         },
                 NSStringFromSelector(@selector(minchaGedola72Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(72 דקות) מנחה גדולה",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of mincha gedola according to the Magen Avraham with the day starting 72 minutes before sunrise and ending 72 minutes after sunset. This is the earliest time to pray mincha. For more information on this see the documentation on mincha gedola.x This is calculated as 6.5 solar hours after alos.  The calculation used is 6.5 * ShaahZmanis72Minutes() after alos."
                         },
                 NSStringFromSelector(@selector(minchaGedola30Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"(30 דקות) מנחה גדולה",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"Mincha G'dola (<##>)",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of mincha gedola calculated as 30 minutes after chatzos and not 1/2 of a shaah zmanis after chatzos as calculated by KCZmanimCalendar.MinchaGedola(). Some use this time to delay the start of mincha in the winter when 1/2 of a shaah zmanis is less than 30 minutes. See MinchaGedolaGreaterThan30()for a convenience method that returns the later of the 2 calculations. One should not use this time to start mincha before the standard mincha gedola. See Shulchan Aruch Orach Chayim Siman Raish Lamed Gimel seif alef and the Shaar Hatziyon seif katan ches."
                         },
                 NSStringFromSelector(@selector(minchaGedola16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"(16.1 מעלות) מנחה גדולה",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"Mincha G'dola (16.1 Ma'alot)",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of mincha gedola according to the Magen Avraham with the day starting and ending 16.1° below the horizon. This is the earliest time to pray mincha.  For more information on this see the documentation on mincha gedola. This is calculated as 6.5 solar hours after alos. The calculation used is 6.5 * ShaahZmanis16Point1Degrees() after alos."
                         },
                 NSStringFromSelector(@selector(minchaGedolaGreaterThan30)) : @{
                         @"koshercocoa.name.hebrew" : @"(לפחות 30) מנחה גדולה",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"Mincha G'dola (<##>)",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"This is a conveniance methd that returns the later of KCZmanimCalendar.MinchaGedola() and KCMinchaGedola30Minutes(). In the winter when a shaah zmanis is less than 30 minutes MinchaGedola30Minutes() will be returned, otherwise KCZmanimCalendar.MinchaGedola() will be returned."
                         },
                 NSStringFromSelector(@selector(minchaGedolaAteretTorah))  : @{
                         @"koshercocoa.name.hebrew" : @"(עטרת תורה) מנחה גדולה",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Mincha Gedolah (Ateret Torah)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Mincha G'dola (Ateret Torah)",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of mincha ketana based on the calculation of Chacham Yosef Harari-Raful of Yeshivat Ateret Torah, that the day starts 1/10th of the day before sunrise and is usually calculated as ending 40 minutes after sunset. This is the preferred earliest time to pray mincha according to the opinion of the Rambam and others."
                         },
                 
                 /**
                  *    Mincha Ketana
                  */
                 
                 NSStringFromSelector(@selector(minchaKetana))  : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"<#explanation#>"
                         },
                 NSStringFromSelector(@selector(minchaKetana16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"Mincha K'tana (16.1 Ma'alot)",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of mincha ketana according to the Magen Avraham with the day starting and ending 16.1° below the horizon. This is the perfered earliest time to pray mincha according to the opinion of the Rambam and others. For more information on this see the documentation on mincha gedola. This is calculated as 9.5 solar hours after alos.  The calculation used is 9.5 * ShaahZmanis16Point1Degrees() after alos."
                         },
                 NSStringFromSelector(@selector(minchaKetana72Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Mincha Ketanah (<##>)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Mincha K'tana (<##>)",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of mincha ketana according to the Magen Avraham with the day starting 72 minutes before sunrise and ending 72 minutes after sunset. This is the perfered earliest time to pray mincha according to the opinion of the Rambam and others. For more information on this see the documentation on mincha gedola. This is calculated as 9.5 ShaahZmanis72Minutes() after alos. The calculation used is 9.5 * getShaahZmanis72Minutes() after alos."
                         },
                 NSStringFromSelector(@selector(minchaKetanaAteretTorah))  : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"<#explanation#>"
                         },
                 
                 /**
                  *    Plag Hamincha
                  */
                 
                 NSStringFromSelector(@selector(plagHamincha)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"Plag Hamincha",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"This is calculated as 10.75 hours after sunrise. This calculation is based on the opinion of the GRA and the Baal Hatanya that the day is calculated from sunrise to sunset."
                         },
                 NSStringFromSelector(@selector(plagHamincha60Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha according to the Magen Avraham with the day starting 60 minutes before sunrise and ending 60 minutes after sunset. This is calculated as 10.75 hours after dawn.  The formula used is: 10.75 ShaahZmanis60Minutes() after Alos60()."
                         },
                 NSStringFromSelector(@selector(plagHamincha72Minutes))  : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha according to the Magen Avraham with the day starting 72 minutes before sunrise and ending 72 minutes after sunset. This is calculated as 10.75 hours after dawn.  The formula used is: 10.75 ShaahZmanis72Minutes() after KCZmanimCalendar.Alos72()."
                         },
                 NSStringFromSelector(@selector(plagHamincha72MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha. This is calculated as 10.75 hours after dawn.  The formula used is: 10.75 * ShaahZmanis72MinutesZmanis() after dawn."
                         },
                 NSStringFromSelector(@selector(plagHamincha90Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha according to the Magen Avraham with the day starting 90 minutes before sunrise and ending 90 minutes after sunset. This is calculated as 10.75 hours after dawn.  The formula used is: 10.75 ShaahZmanis90Minutes() after Alos90()."
                         },
                 NSStringFromSelector(@selector(plagHamincha90MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha. This is calculated as 10.75 hours after dawn.  The formula used is: 10.75 * ShaahZmanis90MinutesZmanis() after dawn."
                         
                         
                         
                         },
                 NSStringFromSelector(@selector(plagHamincha96Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha according to the Magen Avraham with the day starting 96 minutes before sunrise and ending 96 minutes after sunset. This is calculated as 10.75 hours after dawn.  The formula used is: 10.75 ShaahZmanis96Minutes() after Alos96()."
                         },
                 NSStringFromSelector(@selector(plagHamincha96MinutesZmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha. This is calculated as 10.75 hours after dawn.  The formula used is: 10.75 * ShaahZmanis96MinutesZmanis() after dawn."
                         },
                 NSStringFromSelector(@selector(plagHamincha16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha based on the opinion that the day starts at alos 16.1° and ends at tzais 16.1°. This is calculated as 10.75 hours zmaniyos after dawn.  The formula is 10.75 * ShaahZmanis16Point1Degrees() after Alos16Point1Degrees()."
                         },
                 NSStringFromSelector(@selector(plagHamincha18Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"<#explanation#>"
                         },
                 NSStringFromSelector(@selector(plagHamincha19Point8Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha based on the opinion that the day starts at alos 19.8° and ends at tzais 19.8°. This is calculated as 10.75 hours zmaniyos after dawn.  The formula is 10.75 * ShaahZmanis19Point8Degrees() after Alos19Point8Degrees()."
                         },
                 NSStringFromSelector(@selector(plagHamincha26Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha based on the opinion that the day starts at alos 26° and ends at tzais 26° . This is calculated as 10.75 hours zmaniyos after dawn.  The formula is 10.75 * ShaahZmanis26Degrees() after Alos26Degrees()."
                         },
                 NSStringFromSelector(@selector(plagAlosToSunset)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha based on the opinion that the day starts at alos 16.1° and ends at sunset. 10.75 shaos zmaniyos are calculated based on this day and added to alos to reach this time. This time is 10.75 shaos zmaniyos (temporal hours) after dawn based on the opinion that the day is calculated from a dawn of 16.1 degrees before sunrise to sea level sunset.  This returns the time of 10.75 * the calculated shaah zmanis after dawn."
                         },
                 NSStringFromSelector(@selector(plagAlos16Point1ToTzaisGeonim7Point083Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The time of plag hamincha based on the opinion that the day starts at alos 16.1° and ends at tzais. 10.75 shaos zmaniyos are calculated based on this day and added to alos to reach this time. This time is 10.75 shaos zmaniyos (temporal hours) after dawn based on the opinion that the day is calculated from a dawn of 16.1 degrees before sunrise to tzais . This returns the time of 10.75 * the calculated shaah zmanis after dawn."
                         },
                 
                 /**
                  *   Sunset
                  */
                 
                 NSStringFromSelector(@selector(sunset)) : @{
                         @"koshercocoa.name.hebrew" : @"שקיעת החמה",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Shkiyas Hachamah",
                         @"koshercocoa.name.transliterated.sepharad" : @"Shki'at Hachama",
                         @"koshercocoa.name.english" : @"Sunset",
                         @"koshercocoa.explanation.english" : @"Sea level sunset according to the National Oceanic and Atmospheric Association, using a 90º zenith."
                         },
                 
                 /**
                  *  Bain Hashmashos
                  */
                 
                 NSStringFromSelector(@selector(bainHashmashosRT13Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" Method to return Bain Hashmasho of Rabainu Tam calculated when the sun is 13.24° below the western geometric horizon (90°) after sunset. This calculation is based on the same calculation of Bain Hasmashos Rabainu Tam 58.5 minutes but uses a degree based calculation instead of 58.5 exact minutes. This calculation is based on the position of the sun 58.5 minutes after sunset in Jerusalem during the equinox which calculates to 13.24° below geometric zenith."
                         },
                 NSStringFromSelector(@selector(bainHashmashosRT58Point5Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"<#explanation#>"
                         },
                 NSStringFromSelector(@selector(bainHashmashosRT13Point5MinutesBefore7Point083Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"<#explanation#>"
                         },
                 NSStringFromSelector(@selector(bainHashmashosRT2Stars)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"<#explanation#>"
                         },
                 
                 /**
                  *    Tzais
                  */
                 
                 NSStringFromSelector(@selector(tzais))  : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Tzais Hakochavim (8.5 Maalos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Tzait Hakochavim (8.5 Ma'alot)",
                         @"koshercocoa.name.english" : @"First Starlight",
                         @"koshercocoa.explanation.english" : @"This calculation is based on the position of the sun 36 minutes after sunset in Jerusalem on March 16, about 4 days before the equinox, the day that a solar hour is 60 minutes, which is 8.5degrees below geometric zenith. The Ohr Meir considers this the time that 3 small stars are visible, which is later than the required 3 medium stars."
                         },
                 NSStringFromSelector(@selector(tzaisGeonim5Point95Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Geonim calculated at the sun's position at 5.95° below the western horizon."
                         },
                 NSStringFromSelector(@selector(tzaisGeonim5Point88Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Geonim calculated as 3/4 of a 24 minute Mil, (Baal Hatanya) based on a Mil being 24 minutes, and is calculated as 18 + 2 + 4 for a total of 24 minutes (FIXME: additional documentation details needed).  It is the sun's position at 5.88° below the western horizon.  This is a very early zman and should not be relied on without Rabbinical guidance."
                         },
                 NSStringFromSelector(@selector(tzaisGeonim3Point65Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Geonim calculated as 3/4 of a Mil based on an 18 minute Mil, or 13.5 minutes.  It is the sun's position at 3.65° below the western horizon.  This is a very early zman and should not be relied on without Rabbinical guidance."
                         },
                 NSStringFromSelector(@selector(tzaisGeonim4Point37Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Geonim calculated as 3/4 of a Mil, based on a 22.5 minute Mil, or 16 7/8 minutes. It is the sun's position at 4.37° below the western horizon.  This is a very early zman and should not be relied on without Rabbinical guidance."
                         },
                 NSStringFromSelector(@selector(tzaisGeonim4Point61Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Geonim calculated as 3/4 of a Mil based on an 24 minute Mil, or 18 minutes. It is the sun's position at 4.61° below the western horizon. This is a very early zman and should not be relied on without Rabbinical guidance."
                         },
                 NSStringFromSelector(@selector(tzaisGeonim4Point8Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Geonim calculated as 3/4 of a Mil based on the sun's position at 4.8° below the western horizon.  This is based on Rabbi Leo Levi's calculations. FIXME: additional documentation needed.  This is the This is a very early zman and should not be relied on without Rabbinical guidance."
                         },
                 NSStringFromSelector(@selector(tzaisGeonim7Point083Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Geonim calculated as 30 minutes after sunset during the equinox in Yerushalayim. The sun's position at this time computes to 7.083° (or 7° 5? below the western horizon. Note that this is a common and rounded number. Computation shows the accurate number is 7.2°"
                         },
                 NSStringFromSelector(@selector(tzaisGeonim8Point5Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Geonim calculated at the sun's position at 8.5° below the western horizon."
                         },
                 NSStringFromSelector(@selector(tzais50)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on R' Moshe Feinstein's opinion that the time to walk the distance of a Mil is 12.5 minutes for a total of 50 minutes for 4 Mil after sea level sunset."
                         },
                 NSStringFromSelector(@selector(tzais60)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The tzais (nightfall) based on the opinion of the Chavas Yair and Divray Malkiel that the time to walk the distance of a Mil is 15 minutes for a total of 60 minutes for 4 Mil after sea level sunset."
                         },
                 NSStringFromSelector(@selector(tzaisAteretTorah)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"This method returns tzais usually calculated as 40 minutes (configurable to any offset by modifying AteretTorahSunsetOffset) after sunset. Please note that Chacham Yosef Harari-Raful of Yeshivat Ateret Torah who uses this time,  does so only for calculating various other zmanai hayom such as Sof Zman Krias Shema  and Plag Hamincha. His calendars do not publish a zman for Tzais.  It should also be noted that Chacham Harari-Raful provided a 25 minute zman for Israel.  This API uses 40 minutes year round in any place on the globe by default.  This offset can be changed by modifying AteretTorahSunsetOffset."
                         },
                 NSStringFromSelector(@selector(tzais72)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"Tzais Hakochavim (72 Dakos)",
                         @"koshercocoa.name.transliterated.sepharad" : @"Tzait Hakochavim (72 Dakot)",
                         @"koshercocoa.name.english" : @"First Starlight (72 Minutes)",
                         @"koshercocoa.explanation.english" : @"Calculated as 72 minutes after sunset, not taking elevation into account."
                         },
                 NSStringFromSelector(@selector(tzais72Zmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" Method to return tzais (dusk) calculated as 72 minutes zmaniyos, or 1/10th of the day after sea level sunset."
                         },
                 NSStringFromSelector(@selector(tzais90)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" Method to return tzais (dusk) calculated as 90 minutes after sea level sunset.  This method returns tzais (nightfall) based on the opinion of the Magen Avraham that the time to walk the distance of a Mil according to the Rambam's opinion is 18 minutes for a total of 90 minutes based on the opinion of Ula who calculated tzais as 5 Mil after sea  level shkiah (sunset).  A similar calculation Tzais19Point8Degrees()uses solar position calculations based on this time."
                         },
                 NSStringFromSelector(@selector(tzais90Zmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" Method to return tzais (dusk) calculated using 90 minutes zmaniyos (GRA and the Baal Hatanya)  after sea level sunset."
                         },
                 NSStringFromSelector(@selector(tzais96)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" A method to return tzais (dusk) calculated as 96 minutes after sea level sunset.  For information on how this is calculated see the comments on Alos96()."
                         },
                 NSStringFromSelector(@selector(tzais96Zmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" Method to return tzais (dusk) calculated using 96 minutes zmaniyos (GRA and the Baal Hatanya) after sea level sunset."
                         },
                 NSStringFromSelector(@selector(tzais120)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"This method returns tzais (nightfall) based on the opinion of the Magen Avraham that the time to walk the distance of a Mil according to the Rambam's opinion is 2/5 of an hour (24 minutes)  for a total of 120 minutes based on the opinion of Ula who calculated tzais as 5 Mil after sea level shkiah (sunset).  A similar calculation Tzais26Degrees() uses temporal calculations based on this time."
                         },
                 NSStringFromSelector(@selector(tzais120Zmanis)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" Method to return tzais (dusk) calculated using 120 minutes zmaniyos (GRA and the Baal Hatanya) after sea level sunset."
                         },
                 NSStringFromSelector(@selector(tzais16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" For information on how this is calculated see the comments on Alos16Point1Degrees()"
                         },
                 NSStringFromSelector(@selector(tzais26Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"  For information on how this is calculated see the comments on Alos26Degrees()"
                         },
                 NSStringFromSelector(@selector(tzais18Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" For information on how this is calculated see the comments on Alos18Degrees()"
                         },
                 NSStringFromSelector(@selector(tzais19Point8Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @" For information on how this is calculated see the comments on Alos19Point8Degrees()"
                         },
                 
                 /**
                  *    Achilas Chametz
                  */
                 
                 NSStringFromSelector(@selector(sofZmanAchilasChametzGra)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The latest time one is allowed eating chametz on Erev Pesach according to the opinion of the GRA and the Baal Hatanya. This time is identical to the Sof zman tefilah GRA. This time is 4 hours into the day based on the opinion of the GRA and the Baal Hatanya  that the day is calculated from sunrise to sunset.  This returns the time 4 * KCZmanimCalendar.ShaahZmanisGra() after sea level sunrise."
                         },
                 NSStringFromSelector(@selector(sofZmanAchilasChametzMGA72Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The latest time one is allowed eating chametz on Erev Pesach according to the opinion of the MGA based on alos being 72 minutes before sunrise. This time is identical to the Sof zman tefilah MGA 72 minutes. This time is 4 shaos zmaniyos (temporal hours) after dawn based on the opinion of the MGA that the day is calculated from a dawn of 72 minutes before sunrise to nightfall of 72 minutes after sunset.  This returns the time of 4 * KCZmanimCalendar.ShaahZmanisMGA() after dawn."
                         },
                 NSStringFromSelector(@selector(sofZmanAchilasChametzMGA16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The latest time one is allowed eating chametz on Erev Pesach according to the opinion of the MGA based on alos being 16.1° before sunrise. This time is 4 shaos zmaniyos (solar hours) after dawn based on the opinion of the MGA that the day is calculated from dawn to nightfall with both being 16.1° below sunrise or sunset.  This returns the time of 4 ShaahZmanis16Point1Degrees() after dawn."
                         },
                 
                 /**
                  *    Biur Chametz
                  */
                 
                 NSStringFromSelector(@selector(sofZmanBiurChametzGra)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The latest time for burning chametz on Erev Pesach according to the opinion of the GRA and the Baal Hatanya. This time is 5 hours into the day based on the opinion of the GRA and the Baal Hatanya that the day is calculated from sunrise to sunset.  This returns the time 5 * KCZmanimCalendar.ShaahZmanisGra() after sea level sunrise."
                         },
                 NSStringFromSelector(@selector(sofZmanBiurChametzMGA72Minutes)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The latest time for burning chametz on Erev Pesach according to the opinion of the Magen Avraham based on alos being 72 minutes before sunrise.  This time is 5 shaos zmaniyos (temporal hours) after dawn based on the opinion of the Magen Avraham that the day is calculated from a dawn of 72 minutes before sunrise to nightfall of 72 minutes after sunset. This returns the time of 5 * KCZmanimCalendar.ShaahZmanisMGA() after dawn."
                         },
                 NSStringFromSelector(@selector(sofZmanBiurChametzMGA16Point1Degrees)) : @{
                         @"koshercocoa.name.hebrew" : @"",
                         @"koshercocoa.name.transliterated.ashkenaz" : @"",
                         @"koshercocoa.name.transliterated.sepharad" : @"",
                         @"koshercocoa.name.english" : @"",
                         @"koshercocoa.explanation.english" : @"The latest time for burning chametz on Erev Pesach according to the opinion of the MGA based on alos being 16.1° before sunrise. This time is 5 shaos zmaniyos (solar hours)  after dawn based on the opinion of the MGA that the day is calculated from dawn to nightfall with both being 16.1° below sunrise or sunset.  This returns the time of 5 ShaahZmanis16Point1Degrees() after dawn."
                         }
                 };
        
        
    }
    
    return data;
    
}

- (NSDictionary *)_metadataForCurrentZman
{
    NSDictionary * metadata = KCZman.metadata[NSStringFromSelector(self.selector)];
    
    return metadata;
}

/**
 *  Comparisons
 */

- (BOOL)isEqual:(id)object
{
    BOOL isOtherAlsoZman = [object isKindOfClass:[KCZman class]];
    BOOL equal = [super isEqual:object] && isOtherAlsoZman && [self isEqualToZman:(KCZman *)object];
    
    return equal;
}

- (BOOL)isEqualToZman:(KCZman *)anotherZman
{
    NSString *mySelector = NSStringFromSelector(self.selector);
    NSString *otherZmanSelector = NSStringFromSelector(anotherZman.selector);
    
    return [mySelector isEqualToString:otherZmanSelector];
}

@end

NS_ASSUME_NONNULL_END
