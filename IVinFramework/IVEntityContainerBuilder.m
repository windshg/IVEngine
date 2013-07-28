//
//  IVEntityContainerBuilder.m
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import "IVEntityContainerBuilder.h"

#define CONTAINER_TAG "contanier"
#define OBJECT_TAG "entity"
#define OBJECT_NAME_PROPERTY "id"
#define OBJECT_CLASSNAME_PROPERTY "class"
#define OBJECT_LAZY_PROPERTY "lazy"
#define OBJECT_SINGLETON_PROPERTY "singleton"
#define PROPERTY_TAG "property"
#define PROPERTY_NAME_PROPERTY "name"
#define PROPERTY_REF_PROPERTY "ref"
#define PROPERTY_STRING_VALUE_PROPERTY "stringValue"
#define PROPERTY_NUMBER_VALUE_PROPERTY "numberValue"

#define CONFIG_TAG "config"

#define AOP_TAG "aop"
#define ASPECT_TAG "aspect"
#define ASPECT_NAME_PROPERTY "id"
#define ASPECT_CLASSNAME_PROPERTY "class"
#define JOINPOINT_TAG "joinpoint"
#define JOINPOINT_EXPRESSION "expression"

#define MAX_CHARS_TO_COMPARE_TAGS 100

// Forward reference. The structure is defined in full at the end of the file.
static xmlSAXHandler simpleSAXHandlerStruct;

@interface IVEntityContainerBuilder()
@property (nonatomic, retain) IVEntityContainer *container;
@property (nonatomic, retain) IVEntityDefinition *objectDefinition;
@property (nonatomic, retain) IVAspectWeaver *IVAspectWeaver;
@property (nonatomic, retain) IVAspectDefinition *aspectDefinition;
@property (nonatomic, retain) id<IVEntityContainerBuilderDelegate> delegate;
@end


@implementation IVEntityContainerBuilder

@synthesize container, objectDefinition, IVAspectWeaver, aspectDefinition, delegate;

#pragma mark Interface emthods
- (void) buildContainer: (NSURL*) xmlUrl withDelegate: (id<IVEntityContainerBuilderDelegate>) aDelegate {
	self.delegate = aDelegate;
	
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:xmlUrl
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];
	// create the connection with the request
	// and start loading the data
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (!theConnection) {
		[self.delegate containerBuildingError];
	}
}

#pragma mark init and dealloc
- (void) dealloc {
	self.container = nil;
	self.objectDefinition = nil;
	self.delegate = nil;
    self.IVAspectWeaver = nil;
	[super dealloc];
}


#pragma mark connection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    context = xmlCreatePushParserCtxt(&simpleSAXHandlerStruct, self, NULL, 0, NULL);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    xmlParseChunk(context, (const char *)[data bytes], [data length], 0);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];
    xmlFreeParserCtxt(context);
	xmlCleanupParser();
	
	[self.delegate containerBuildingFinished:self.container];
	[self.container release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [connection release];
    xmlFreeParserCtxt(context);
	xmlCleanupParser();

	[self.delegate containerBuildingError];
}

@end

#pragma mark Private C methods
static BOOL compareTag(const xmlChar *localname, const char *tagname) {
	return 0 == strncmp((const char *)localname, tagname, MAX_CHARS_TO_COMPARE_TAGS);
}

static CFStringRef createAttributeValue(const char *attributename, int nb_attributes, const xmlChar ** attributes) {
	unsigned int index = 0;
	for (int indexAttribute = 0; 
		 indexAttribute < nb_attributes; 
		 ++indexAttribute, index += 5 ) {
		const xmlChar *localname = attributes[index];
		
		if (compareTag(localname, attributename)) {
			const xmlChar *valueBegin = attributes[index+3];
			const xmlChar *valueEnd = attributes[index+4];
			
			return CFStringCreateWithBytes(NULL, valueBegin, valueEnd - valueBegin, kCFStringEncodingUTF8, NO);
		}
	}
	
	return NULL;
}

#pragma mark SAX methods
static void startElementSAX(void *ctx, const xmlChar *localname, const xmlChar *prefix, const xmlChar *URI, 
                            int nb_namespaces, const xmlChar **namespaces, int nb_attributes, int nb_defaulted, const xmlChar **attributes) {
    IVEntityContainerBuilder *builder = (IVEntityContainerBuilder *)ctx;
    
	if (compareTag(localname, CONTAINER_TAG)) {
		builder.container = [[IVEntityContainer alloc] init];
	} else if (compareTag(localname, OBJECT_TAG)) {
		builder.objectDefinition = [[IVEntityDefinition alloc] init];
		
		CFStringRef name = createAttributeValue(OBJECT_NAME_PROPERTY, nb_attributes, attributes);
		if (name) {
			builder.objectDefinition.name = (NSString*)name;
			CFRelease(name);
		}
		
		CFStringRef className = createAttributeValue(OBJECT_CLASSNAME_PROPERTY, nb_attributes, attributes);
		if (className) {
			builder.objectDefinition.className = (NSString*)className;
			CFRelease(className);
		}
		
		CFStringRef lazy = createAttributeValue(OBJECT_LAZY_PROPERTY, nb_attributes, attributes);
		if (lazy) {
			builder.objectDefinition.lazy = [(NSString*)lazy isEqualToString:@"true"];
			CFRelease(lazy);
		}
		
		CFStringRef singleton = createAttributeValue(OBJECT_SINGLETON_PROPERTY, nb_attributes, attributes);
		if (singleton) {
			builder.objectDefinition.singleton = [(NSString*)singleton isEqualToString:@"true"];
			CFRelease(singleton);
		}
		
	} else if (compareTag(localname, PROPERTY_TAG)) {
		CFStringRef name = createAttributeValue(PROPERTY_NAME_PROPERTY, nb_attributes, attributes);

		if (name) {
			CFStringRef ref = createAttributeValue(PROPERTY_REF_PROPERTY, nb_attributes, attributes);
			if (ref) {
				[builder.objectDefinition addPropertyReference:(NSString*)name toObjectName:(NSString*)ref];
				CFRelease(ref);
			}
            
            CFStringRef stringValue = createAttributeValue(PROPERTY_STRING_VALUE_PROPERTY, nb_attributes, attributes);
			if (stringValue) {
                [builder.objectDefinition addPropertyStringValue:(NSString*)name value:(NSString*)stringValue];
				CFRelease(stringValue);
			}
            
            CFStringRef numValue = createAttributeValue(PROPERTY_NUMBER_VALUE_PROPERTY, nb_attributes, attributes);
			if (numValue) {
                [builder.objectDefinition addPropertyNumberValue:(NSString*)name value:(NSString*)numValue];
				CFRelease(numValue);
			}
            
			CFRelease(name);
		}
	} else if (compareTag(localname, CONFIG_TAG) && compareTag(prefix, AOP_TAG)) {
        builder.IVAspectWeaver = [[IVAspectWeaver alloc] init];
    } else if (compareTag(localname, ASPECT_TAG)) {
        builder.aspectDefinition = [[IVAspectDefinition alloc] init];
        
        CFStringRef name = createAttributeValue(ASPECT_NAME_PROPERTY, nb_attributes, attributes);
		if (name) {
			builder.aspectDefinition.name = (NSString*)name;
			CFRelease(name);
		}
        
        CFStringRef className = createAttributeValue(ASPECT_CLASSNAME_PROPERTY, nb_attributes, attributes);
		if (className) {
			builder.aspectDefinition.className = (NSString*)className;
			CFRelease(className);
		}
    } else if (compareTag(localname, JOINPOINT_TAG)) {
        CFStringRef expression = createAttributeValue(JOINPOINT_EXPRESSION, nb_attributes, attributes);
        
		if (expression) {
            IVAspectJoinPoint * joinPoint = [[IVAspectJoinPoint alloc] initWithExpression:(NSString*)expression inContainer:builder.container];
            [builder.aspectDefinition addJoinPoint:joinPoint];
			CFRelease(expression);
		}
    }
	
}

static void	endElementSAX(void *ctx, const xmlChar *localname, const xmlChar *prefix, const xmlChar *URI) {    
    IVEntityContainerBuilder *builder = (IVEntityContainerBuilder *)ctx;
    
	if (compareTag(localname, OBJECT_TAG)) {
		[builder.container addDefinition:builder.objectDefinition];
		[builder.objectDefinition release];
	} else if (compareTag(localname, ASPECT_TAG)) {
        [builder.IVAspectWeaver addAspectDefinition:builder.aspectDefinition];
        [builder.aspectDefinition release];
    } else if (compareTag(localname, CONFIG_TAG)) {
        [builder.IVAspectWeaver configureInContainer:builder.container];
    }
	
}

static void errorEncounteredSAX(void *ctx, const char *msg, ...) {
    IVEntityContainerBuilder *builder = (IVEntityContainerBuilder *)ctx;
	[builder.delegate containerBuildingError];
}

static xmlSAXHandler simpleSAXHandlerStruct = {
    NULL,                       /* internalSubset */
    NULL,                       /* isStandalone   */
    NULL,                       /* hasInternalSubset */
    NULL,                       /* hasExternalSubset */
    NULL,                       /* resolveEntity */
    NULL,                       /* getEntity */
    NULL,                       /* entityDecl */
    NULL,                       /* notationDecl */
    NULL,                       /* attributeDecl */
    NULL,                       /* elementDecl */
    NULL,                       /* unparsedEntityDecl */
    NULL,                       /* setDocumentLocator */
    NULL,                       /* startDocument */
    NULL,                       /* endDocument */
    NULL,                       /* startElement*/
    NULL,                       /* endElement */
    NULL,                       /* reference */
    NULL,						/* characters */
    NULL,                       /* ignorableWhitespace */
    NULL,                       /* processingInstruction */
    NULL,                       /* comment */
    NULL,                       /* warning */
    errorEncounteredSAX,        /* error */
    NULL,                       /* fatalError //: unused error() get all the errors */
    NULL,                       /* getParameterEntity */
    NULL,                       /* cdataBlock */
    NULL,                       /* externalSubset */
    XML_SAX2_MAGIC,             //
    NULL,
    startElementSAX,            /* startElementNs */
    endElementSAX,              /* endElementNs */
    NULL,                       /* serror */
};
