From: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
Date: Tue, 26 Aug 2014 02:46:52 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <53FBF51C.1090503@daenzer.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1309240010220.15075@math.ut.ee>
 <alpine.SOC.1.00.1310011134250.26098@math.ut.ee>
 <20140404.165202.33247787406066736.davem@davemloft.net>
 <20140812.233033.2016564874125097713.davem@davemloft.net>
 <alpine.SOC.1.00.1408190946280.27327@math.ut.ee>
 <alpine.SOC.1.00.1408201517210.57@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1408201517210.57@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Meelis Roos <mroos@linux.ee>, David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, oftedal@gmail.com, dri-devel@lists.freedesktop.org

On 25.08.2014 23:48, Meelis Roos wrote:
>> r100 init hangs in a different place. Original dmesg first, then my
>> instrumented dmesg (seems to get further):
>
> The instrumented dmesg had a couple of my local test changes and was
> bad now that I had ROM. Reverted them exept my readb changes (instead
> of direct dereferences of iomapped space) and redid
> logging to be more precise.
>
>> [drm] radeon kernel modesetting enabled.
>> PCI: Enabling device: (0000:02:02.0), cmd 82
>> [drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0908=
).
>> [drm] register mmio base: 0x10000000
>> [drm] register mmio size: 32768
>> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
>
> This was still the unchanged kernel hanging.
>
> Below is a new debug log to pinpoint the hang. It seems to hang in
> r100_gfx_get_rptr but not on first try.

It's most likely hanging in readl() in r100_mm_rreg() then.


--=20
Earthling Michel D=C3=A4nzer            |                  http://www.amd.c=
om
Libre software enthusiast          |                Mesa and X developer
