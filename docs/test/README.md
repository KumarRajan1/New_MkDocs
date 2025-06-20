# test
[![](https://about.mappls.com/images/mappls-b-logo.svg) ](https://www.mapmyindia.com/api)

# Mappls Annotation Plugin

The Mappls Annotation Plugin simplifies the way to set and adjust the visual properties of annotations on a Mappls map.

This Plugin is uses to plot Symbol (marker), Line, Fill(Polygon) and circle on a Map.

### Add the dependency
Add below dependency in your app-level build.gradle
~~~groovy 
implementation 'com.mappls.sdk:annotation-plugin:1.0.0'
~~~

### Add your API keys to the SDK

_Add your API keys to the SDK (in your application's onCreate() or before using map)_
##### Java
~~~java	
MapplsAccountManager.getInstance().setRestAPIKey(getRestAPIKey());  	
MapplsAccountManager.getInstance().setMapSDKKey(getMapSDKKey());  		
MapplsAccountManager.getInstance().setAtlasClientId(getAtlasClientId());  	
MapplsAccountManager.getInstance().setAtlasClientSecret(getAtlasClientSecret());  	
~~~	
##### Kotlin	
~~~kotlin	
MapplsAccountManager.getInstance().restAPIKey = getRestAPIKey()  	
MapplsAccountManager.getInstance().mapSDKKey = getMapSDKKey()  		
MapplsAccountManager.getInstance().atlasClientId = getAtlasClientId()  	
MapplsAccountManager.getInstance().atlasClientSecret = getAtlasClientSecret()	
~~~

## Initialize the Annotation plugin
To initialise the plugin there are Four Manager classes:
1. `SymbolManager`
2. `LineManager`
3. `FillManager`
4. `CircleManager`

### Initialize SymbolManager (Marker)
##### Java
~~~java
 symbolManager = new SymbolManager(mapView, mapplsMap, style); //For Marker
~~~
##### Kotlin
~~~kotlin
 symbolManager = SymbolManager(mapView, mapplsMap, style); //For Marker
~~~
### Initialize Linemanager (Polyline)
##### Java
~~~java
lineManager = new LineManager(mapView, mapplsMap, style); // For Polyline
~~~
##### Kotlin
~~~kotlin
 lineManager = LineManager(mapView, mapplsMap, style); // For Polyline
~~~
### Initialise FillManager (Polygon)
##### Java
~~~java
 fillManager = new FillManager(mapView, mapplsMap, style); // For Polygon
~~~
##### Kotlin
~~~kotlin
 fillManager = FillManager(mapView, mapplsMap, style); // For Polygon
~~~

### Initialize CircleManager (Circle)
##### Java
~~~java
 circleManager = new CircleManager(mapView, mapplsMap, style); //For Cirle
~~~
##### Kotlin
~~~kotlin
 circleManager = CircleManager(mapView, mapplsMap, style); //For Cirle
~~~

## Add Annotations
### Add a Marker (Symbol)
Use `SymbolOptions` to add the marker:
##### Java
~~~java
//Add Custom Image
style.addImage("map-marker-image", bitmap);
 
 // Create a symbol at the specified location.
SymbolOptions symbolOptions = new SymbolOptions()
	.position(latLng)
	.icon("map-marker-image")
 
// Use the manager to draw the symbol.
symbol = symbolManager.create(symbolOptions);
~~~
##### Kotlin
~~~kotlin
//Add Custom Image
style.addImage("map-marker-image", bitmap);
 
// Create a symbol at the specified location.
val symbolOptions = SymbolOptions()
	.position(latLng)
	.icon("map-marker-image")
 
// Use the manager to draw the symbol.
symbol = symbolManager?.create(symbolOptions)
~~~

### Add a Polyline (Line)
Use `LineOptions` to add the Polyline
##### Java
~~~java
// Use options to color it red.
LineOptions lineOptions = new LineOptions()
    .points(polyline)
    .lineColor("#D81B60")
    .lineWidth(1.0f);
 
// Use the manager to draw the annotation.
lineManager.create(lineOptions);
~~~
##### Kotlin
~~~kotlin
// Use options to color it red.
val lineOptions = LineOptions()
                .points(polyline)
                .lineColor("#D81B60")
                .lineWidth(1.0f)
                
// Use the manager to draw the annotation.
lineManager?.create(lineOptions)
~~~

### Add a Polygon (Fill)
Use `FillOptions` to add the Polygon

##### Java
~~~java
// Use options to color it red.
FillOptions fillOptions = new FillOptions()
    .points(polygon)
    .fillColor("#D81B60");
 
// Use the manager to draw the annotation.
fillManager.create(fillOptions);
~~~
##### Kotlin
~~~kotlin
// Use options to color it red.
val fillOptions = FillOptions()
                .points(polygon)
                .fillColor("#D81B60")

fillManager?.create(fillOptions)
~~~

### Add a Circle
Use `CircleOptions` to add the Circle
##### Java
~~~java
// Use options to color it red.
CirlceOptions circleOptions = new CircleOptions()
    .position(centerPoint)
    .radius(5.0f)
    .circleColor("#D81B60");
 
// Use the manager to draw the annotation.
cirlceManager.create(circleOptions);
~~~
##### Kotlin
~~~kotlin
// Use options to color it red.
val circleOptions = CircleOptions()
    .position(centerPoint)
    .radius(5.0f)
    .circleColor("#D81B60")

cirlceManager?.create(circleOptions)
~~~

For any queries and support, please contact:

[![](https://about.mappls.com/images/mappls-logo.svg) ](https://about.mappls.com/api/)
Email us at [apisupport@mappls.com](mailto:apisupport@mappls.com)

![](https://www.mapmyindia.com/api/img/icons/support.png)
[Support](https://about.mappls.com/contact/)
Need support? contact us!

[![](https://www.mapmyindia.com/api/img/icons/stack-overflow.png)](https://www.npmjs.com/org/mapmyindia)

[![](https://www.mapmyindia.com/june-newsletter/icon4.png)@ Copyright 2023 CE Info Systems Ltd. All Rights Reserved.

 Terms &amp; Conditions | Privacy Policy | Supplier Sustainability Policy | Health &amp; Safety Policy | Environmental Policy &amp; CSR Report

Customer Care: +91-9999333223