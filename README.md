IVEngine
========

If you are or were a JAVA programmer, you should hear of "Spring" library, which is a very popular framework for managing components. It can make the whole enterprise application more scalable and of better hierarchy by making full use of XML language. To quote the official description of Spring : "Spring helps development teams everywhere build simple, portable,  fast and flexible JVM-based systems and applications".

As once an IOS developer, out of inspiration from Spring,  I decided to make a Spring-like framework in Objective-C for fun. Honestly, I don't think this kit can make any difference in practical IOS development since it seems inefficient and    unnecessary to embed it to a view-based application. However if someday Objective-C will be an option for server side development, which I think impossible as there are already so many options for such as php, python and java, I think IVEngine would offer a favor.

Anyway, all I want to convey by IVEngine is primarily a principle for software development which is suitable for all kinds of platforms. So if you think the whole idea is useless or even idiotic, you could just skip over the rest part of this page.

##Deployment
Add the IVEngine Kit to your project.
As this kit is based on XML syntax parser, so before using this kit, you should add libxml2.2.dylib to your "Link Binary With Libraries" and "$SDKROOT/usr/include/libxml2" to your "Header Search Path". 
New a file named "context.xml" or anything else.

##Introduction
###XML
Here is the sample context.xml. The entities configured here includes superman1, superman2, superman3 and army1, army2, army3, army4, which follow the intentions bellow:

1. Entity "superman1" is instance of Class "SuperMan" which is singleton. It has a property "name" with string value "Bill Gate" and property "age" with integer value "20".
```XML
<entity id="superman1" class="SuperMan" singleton="true">
    <property name="name" stringValue="Bill Gate"></property>
    <property name="age" numberValue="20"></property>
</entity>
```

2. Entity "army1" is instance of Class "Army" which is not singleton. It has a property "name" with string value "Microsoft" and a property "captain" refer to the entity "superman1".
```XML
<entity id="army1" class="Army">
    <property name="name" stringValue="Microsoft"></property>
    <property name="captain" ref="superman1"></property>
</entity>
```
Here comes the aspect configuration by the following example.

The container tag definition:
```XML
<?xml version="1.0" encoding="UTF-8"?>
<contanier>
<!-- To Define Entities Here -->

<aop:config>
<!-- To Configure Aspects Here -->
</aop:config>

</contanier>
```

1. An interceptor named "weaponAspect" as an instance of Class "WeaponInterceptor" should have its methods "deBefore: " and "doAfter:" implemented as an implementation of protocol "IVAspect". It want to intercept the "attack" method in all the instances of "SuperMan", which means that the "doBefore: " method will be called before "attack" called while "doAfter: " will be called right after "attack" called. It also want to intercept the "goToPlace:" method in all instances of "Army".
```XML
<aspect id="weaponAspect" class="WeaponInterceptor">
    <joinpoint expression="class||SuperMan||(attack)"></joinpoint>
    <joinpoint expression="class||Army||(goToPlace:)"></joinpoint>
</aspect>
```

2.  An interceptor named "clothesAspect" as an instance of Class "ClothesInterceptor" is defined to intercept the "walk" method in all entities defined before.
```XML
<aspect id="clothesAspect" class="ClothesInterceptor">
    <joinpoint expression="object||*||(walk)"></joinpoint>
</aspect>
```

3. An interceptor named "shoesAspect" as an instance of Class "ShoesInterceptor" is defined to intercept the "walk" method in entities "superman2" and "superman3".
```XML
<aspect id="shoesAspect" class="ShoesInterceptor">
<joinpoint expression="object||superman2,superman3||(walk)"></joinpoint>
</aspect>
```

4. An interceptor named "logAspect" as an instance of Class "LogInterceptor" is defined to intercept all methods in all entities. This way is actually not be recommended as it will intercept all the methods including getter and setter.
```XML
<!-- All methods in all class will be intercepted by LogInterceptor -->
<aspect id="logAspect" class="LogInterceptor">
    <joinpoint expression="class||*||(*)"></joinpoint>
</aspect>
```
###Objective-C
Assume that AppDelegate is the place to test the IVEngineKit. AppDelegate should firstly implement the "IVEntityContainerBuilderDelegate" with selectors:
```ObjectiveC
// called when container builded successfully
- (void) containerBuildingFinished:(IVEntityContainer*) container;
// called when container builded failed
- (void) containerBuildingError;
```
Then start to build the IVEngine container by using: 
```ObjectiveC
NSString *path =[[NSBundle mainBundle] pathForResource:@"context" ofType:@"xml"];
if (path) {
    IVEntityContainerBuilder *builder = [[IVEntityContainerBuilder alloc] init];
    [builder buildContainer:[NSURL fileURLWithPath:path] withDelegate:self];
    [builder release];
} else {
    NSLog(@"Configuration XML file does not exist...");
}
```
Once the container builded successfully, you can do anything you want based on the configuration you made in "context.xml".
```ObjectiveC
- (void) containerBuildingFinished:(IVEntityContainer*) container {
    // superman1
    SuperMan * s1 = [container getEntity:@"superman1"];
    [s1 walk];
    [s1 attack];
    [s1 defense];
    [s1 fly];
    // army1
    Army * a1 = [container getEntity:@"army1"];
	[a1 walk];
    [a1 attack];
    [a1 goToPlace:@"NewYork"];
    // superman2
    SuperMan * s2 = [container getEntity:@"superman2"];
    [s2 walk];
    [s2 attack];
    [s2 defense];
    [s2 fly];
    // army2
    Army * a2 = [container getEntity:@"army2"];
    [a2 walk];
    [a2 attack];
    [a2 goToPlace:@"Paris"];
    // army3
    Army * a3 = [container getEntity:@"army3"];
    [a3 walk];
    [a3 attack];
    [a3 goToPlace:@"London"];
    // superman3
    SuperMan * s3 = [container getEntity:@"superman3"];
    [s3 walk];
    [s3 attack];
    [s3 defense];
    [s3 fly];
    // army4
    Army * a4 = [container getEntity:@"army4"];
    [a4 walk];
    [a4 attack];
    [a4 goToPlace:@"Australia"];
}
```

##SumUp
The project is designed to implement a Spring-like framework in Objective-C on purpose to provide a solution to manage components in enterprise application, especially huge application with so much business logic. It makes good use of the powerful capability of XML and somehow it's not designed for view-based application actually. If you are interested enough to have a test. Please refer to the IVEngineDemo Project and enjoy the beauty of coding.
