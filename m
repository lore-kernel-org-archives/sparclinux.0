From: andrew@walrond.org
Date: Mon, 06 Nov 2006 07:51:56 +0000
Subject: Re: Strange kernel messages bootinh 2.6.18.2 on an E4000
Message-Id: <20061106075156.GC11406@pelagius.h-e-r-e-s-y.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
In-Reply-To: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 05, 2006 at 04:40:45PM -0800, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Sun, 05 Nov 2006 13:27:49 -0800 (PST)
> 
> > From: andrew@walrond.org
> > Date: Sun, 5 Nov 2006 12:05:47 +0000
> > 
> > >  kobject_add failed for fhc with -EEXIST, don't try to register things
> > >  with the same name in the same directory.
> > >  Call Trace:
> > >   [0000000000427ba8] of_device_register+0x2c/0x60
> > >   [000000000076cf80] scan_one_device+0x8b8/0x924
> > >   [000000000076d000] scan_tree+0x14/0x3c
> > >   [000000000076d0c4] of_bus_driver_init+0x9c/0xa4
> > >   [0000000000416b24] init+0x168/0x360
> > >   [0000000000417578] kernel_thread+0x38/0x48
> > >   [0000000000416d34] rest_init+0x18/0x34
> > >  /fhc: Could not register of device.
> > > 
> > > 
> > > Well, 8 to be precise. (= # slots in the e4000 ?)
> > > 
> > > Any clues what this is about, and how to fix it?
> > 
> > This should be easy to fix, thanks for the report.  I'll take
> > a look.
> 
> You're missing some patches or something.  In currnet 2.6.18.2
> and also 2.6.19-rc2, the code in of_device.c reads:
> 

I'm running vanilla 2.6.18.2

# uname -a
Linux hive1 2.6.18.2 #1 SMP Sun Nov 5 12:42:01 GMT 2006 sparc64 GNU/Linux

> 	if (!parent)
> 		strcpy(op->dev.bus_id, "root");
> 	else
> 		sprintf(op->dev.bus_id, "%08x", dp->node);
> 
> 	if (of_device_register(op)) {

and the code (in arch/sparc64/kernel/of_device.c) looks like this:

    if (!parent)
        strcpy(op->dev.bus_id, "root");
    else
        strcpy(op->dev.bus_id, dp->path_component_name);

    if (of_device_register(op)) {

> 
> Therefore it should be registering devices either as "root"
> or as a unique 8 character hexidecimal number string.
> "fhc" is neither.
> 

But "fhc" is indeed the path_component_name I'd guess ;)

> Again, you're likely missing some of the recent bug fixes
> in this area.

I'll pull the latest stable tree and try that instead.

Andrew
