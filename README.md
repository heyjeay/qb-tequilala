# qb-tequilala

This is a Tequi-la-la job script for QBCore that uses qb-target and nh-context, this was forked from https://github.com/DrBlackBeard095/Qb-Burgershot all credit goes to him. All I did was turn it into a Tequi-la-la job!


## REQUIREMENTS

PolyZone https://github.com/mkafrin/PolyZone

qb-target https://github.com/BerkieBb/qb-target

nh-context https://github.com/nerohiro/nh-context

## Add this to the shared.lua in qb-core

### Job

```
["tequilala"] = {
		label = "Tequi-la-la",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "DJ",
                payment = 50
            },
			['1'] = {
                name = "Bartender",
                payment = 75
            },
			['2'] = {
                name = "Bouncer",
                payment = 100
            },
			['3'] = {
                name = "Manager",
                payment = 125
            },
			['4'] = {
                name = "Owner",
				isboss = true,
                payment = 150
            },
        },
	},

``` 

## Add this to qb-bossmenu config.lua

```
['tequilala'] = vector3(-568.577, 291.09, 79.18)
```

#### Other than that it should be good to go!
