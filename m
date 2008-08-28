From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 21:38:55 +0000
Subject: Re: [RFC] minirtc conversion to rtc layer (cmos rtc)
Message-Id: <20080828.143855.15221732.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080828232251.e2c3ffed.krzysztof.h1@poczta.fm>
In-Reply-To: <20080828232251.e2c3ffed.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Thu, 28 Aug 2008 23:22:51 +0200

> Please test the patch. I don't know which sparc64 machines
> have the pc cmos compatible clocks (U60 certainly not).

I have a SunBlade 1000 which has this chip, so I'll do
some testing.  Thanks!

You can figure out what devices are in which systems by checking out a
copy of my prtconfs GIT repository which is constantly growing with
new entries :-)

	master.kernel.org:/pub/scm/linux/kernel/git/davem/prtconfs.git

For example:

davem@sunset:~/src/GIT/prtconfs$ egrep ds1287 *
280r:                compatible: 'ds1287'
280r:                model:  'ds1287'
sb1000:                compatible: 'ds1287'
sb1000:                model: 'ds1287'
v890:                compatible: 'ds1287'
v890:                model:  'ds1287'
davem@sunset:~/src/GIT/prtconfs$ 

So SunBlade 1000, Sun Fire 208R, and Sun Fire V890 all have this
ds1287 RTC chip.
