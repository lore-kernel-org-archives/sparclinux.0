From: David Miller <davem@davemloft.net>
Date: Thu, 06 Sep 2012 18:18:23 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <20120906.141823.13429356729572330.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
	<1346950551.30263.196.camel@thor.local>
In-Reply-To: <1346950551.30263.196.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: michel@daenzer.net
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

From: Michel D=E4nzer <michel@daenzer.net>
Date: Thu, 06 Sep 2012 18:55:51 +0200

> On Don, 2012-09-06 at 17:41 +0300, Meelis Roos wrote:=20
>> This is with initialyy unmodified 3.6.0-rc4-00101-g0809095 kernel in=20
>> Ultra 10 (clean, without my "Video RAM" hack that I talked in other=20
>> sparclinux posts). When I saw that Sun XVR-100 was detected fine by the =

>> kernel, I compiled radeon drm driver with modesetting enabled and tried =

>> it:
>>=20
>> [drm] radeon defaulting to kernel modesetting.
>> [drm] radeon kernel modesetting enabled.
>> PCI: Enabling device: (0000:02:02.0), cmd 82
>> [drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0908=
).
>> [drm] register mmio base: 0x10000000
>> [drm] register mmio size: 32768
>> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
>>=20
>> And here the machine hangs. Debugging printk-s reveal that it does not=20
>> find any active I/O port resources and then continues into initializing =

>> the card. Down in igp_read_bios_from_vram() it successfully ioremaps=20
>> memory region 0 (vram_base=1Ff08000000 and size@000) and tries to read=20
>> 2 bytes from there and hangs on reading bios[0].
>=20
> Is the card initialized by OpenFirmware? E.g., does it display anything
> before the kernel boots?

I think Meelis gave you every single detail you need to know to
analyze and fix this bug.

He says it crashes on reading bios[0].

If you look at the function he tells you the crash occurs in, you'll
see clearly that bios is an ioremap()'d pointer.

You cannot dereference ioremap()'d pointers, you must use the proper
accessors such as readl().
