# qb-tequilala

This is a Tequi-la-la job for QBCore, simple job with a shop/stash/vehicle garage

## Add this to your qb-core shared.lua

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

## Other than that it should be plug and play
