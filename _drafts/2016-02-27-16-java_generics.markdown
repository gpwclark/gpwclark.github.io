---
title: Generics in Java pre/post Java 5
date: 2016-02-27 02:23:17
layout: post 
---

I found myself thinking... What is so great about generics in java, wouldn't you 
"essentially" be able to do the same thing with inheritance... everything is an 
`Object` after all, right? Well, no, that is not entirely true because of primitive 
types. Java primitives are not objects and therefore they are not subclasses of 
`Object`. However, that is not entirely the case because of the Java wrapper 
classes around primitives. An `int` is a primtive type but it has a somewhat
analgous (also immutable) big brother `Object` called `Integer` which
is a [pretty cool object](https://docs.oracle.com/javase/7/docs/api/java/lang/Integer.html)
with some pretty cool methods for interacting with the underlying `int` they 
represent. 

Now wrappers around the 8 Java primitives were around in JDK1.0 circa 1996. So
clearly there must be more to the story if Generics were introduced in Java 5.
So, pooling my knowledge of inheritance I realized the first big downfall of 
this approach, if one were to invoke a method on one of these `Objects` 
(be it a 
