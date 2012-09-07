From: Dave Airlie <airlied@gmail.com>
Date: Fri, 07 Sep 2012 07:18:15 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <CAPM=9ty87-kP1QJjgJKQUVkJxg8yN6ZQ5qy+pVYRnrDoa_VqBQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
	<1346950551.30263.196.camel@thor.local>
	<20120906.141823.13429356729572330.davem@davemloft.net>
In-Reply-To: <20120906.141823.13429356729572330.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: michel@daenzer.net, sparclinux@vger.kernel.org, mroos@linux.ee, dri-devel@lists.freedesktop.org

On Fri, Sep 7, 2012 at 4:18 AM, David Miller <davem@davemloft.net> wrote:
> From: Michel D=E4nzer <michel@daenzer.net>
> Date: Thu, 06 Sep 2012 18:55:51 +0200
>
>> On Don, 2012-09-06 at 17:41 +0300, Meelis Roos wrote:
>>> This is with initialyy unmodified 3.6.0-rc4-00101-g0809095 kernel in
>>> Ultra 10 (clean, without my "Video RAM" hack that I talked in other
>>> sparclinux posts). When I saw that Sun XVR-100 was detected fine by the
>>> kernel, I compiled radeon drm driver with modesetting enabled and tried
>>> it:
>>>
>>> [drm] radeon defaulting to kernel modesetting.
>>> [drm] radeon kernel modesetting enabled.
>>> PCI: Enabling device: (0000:02:02.0), cmd 82
>>> [drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x090=
8).
>>> [drm] register mmio base: 0x10000000
>>> [drm] register mmio size: 32768
>>> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
>>>
>>> And here the machine hangs. Debugging printk-s reveal that it does not
>>> find any active I/O port resources and then continues into initializing
>>> the card. Down in igp_read_bios_from_vram() it successfully ioremaps
>>> memory region 0 (vram_base=1Ff08000000 and size@000) and tries to read
>>> 2 bytes from there and hangs on reading bios[0].
>>
>> Is the card initialized by OpenFirmware? E.g., does it display anything
>> before the kernel boots?
>
> I think Meelis gave you every single detail you need to know to
> analyze and fix this bug.
>
> He says it crashes on reading bios[0].
>
> If you look at the function he tells you the crash occurs in, you'll
> see clearly that bios is an ioremap()'d pointer.
>
> You cannot dereference ioremap()'d pointers, you must use the proper
> accessors such as readl().

we should just skip the igp reading function on not-x86, since IGP on
not x86 makes no sense.

the other option is to readl out the whole bios from vram instead.

Dave.
