# Why?

Almost 1 million hotspots have been deployed but few use. One of the reason is the cost is too high.

It seems the cost of building an IoT solution is $1/year per sensor which is a low price, right?
But actually it's not cheap at all if you start to build an application on top of it.

Suppose you have 100k sensors which is a small number, how much will you spend every year?

## Basic Cost Use Helium IoT Network

### Cost

```
> $120,000
```

### Hotspots

Since hotspots are hosted and managed by anyone, you can't trust them because they can shutdown hotspots at any time.
It will be a big risk to use the network in such situation. So you have to have your own hotspots deployed to make sure your 
application works `24*7*365`.

In that case, suppose you need to deploy 1 hotspot every 1000 sensors, the cost of hotspots will be 
`$40` (onboarding) + `$20` (assert location 2 times average) + `$?` (hardware cost).

So the basic cost of hotspots will be:

```
100,000 / 1000 * ($40 + $20 + >$140) > $20,000
```

### Sensors

The cost of packet transfer is about $1 per year.
Onboarding sensors cost more.

```
100,000 * $1 = $100,000
```

### Softwares

Software cost not included such as Console, Router, ETL, etc.


## Basic Cost Use TTN

### Cost

```
$64,436
```

### Hotspots

The basic cost of hotspots will be:

```
100,000 / 1000 * (>$140) > $14,000
```

* No onboarding / location assertion fee.
* No ECC chip, etc. Price should be less than the number above.

### Sensors

All the cost included in the plan.
https://accounts.thethingsindustries.com/fee-calculator

```
$50,436 / year
```

### Softwares

All the cost included in the plan.


## How to reduce the cost?

### Reduce the light hotspot onboarding && location assertion fee.

`$20` / light gateway

`$5`  / location assertion

Reduce DC for data transfer


