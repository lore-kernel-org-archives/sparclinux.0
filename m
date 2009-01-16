From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Jan 2009 20:48:32 +0000
Subject: Re: fhc led registration warnings
Message-Id: <20090116204832.GB27126@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 16, 2009 at 01:02:33PM +0200, Meelis Roos wrote:
> While booting todays 2.6.29-rc1+git on E3500, these warning about FHC 
> LEDs sysfs registration appeared in the logs. I sent the previous mail 
> away and decided to send this one separately, but now I see that the 
> location of platform-specific device registrations js the same where CPU 
> detection problem were, so maybe they are related afterall.
>
There were two interesting lines above these. 
[  136.436067] fhc: Board #1, Version[1] PartID[fa0] Manuf[3e] (Central)
[  136.436823] fhc: Board #3, Version[1] PartID[fa0] Manuf[3e] (JTAG Master)

> [  136.437166] WARNING: at fs/sysfs/dir.c:462 sysfs_add_one+0x44/0x60()
> [  136.437226] sysfs: duplicate filename 'sunfire-fhc-leds.0' can not be created

So it looks like we:
1) Only finds two where we found four with the older kernel
according to your other mail where you said:

===
Btw, these fhc messages appear later in boot process than before.
Before the boards were detected just after 'Booting Linux':
Booting Linux...
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
FHC(board 7): Version[1] PartID[fa0] Manuf[3e]
==
And it looks like we try to create two entires in sysfs with the same
name.

Davind did some changes in this part of the code base,
so I hope he can spot it.
I did not find anything obvious.

	Sam
