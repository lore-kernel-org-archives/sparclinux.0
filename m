From: Meelis Roos <mroos@linux.ee>
Date: Sun, 31 Aug 2014 05:59:44 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <alpine.SOC.1.00.1408310858490.23472@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1309240010220.15075@math.ut.ee>
 <alpine.SOC.1.00.1310011134250.26098@math.ut.ee>
 <20140404.165202.33247787406066736.davem@davemloft.net>
 <20140812.233033.2016564874125097713.davem@davemloft.net>
 <alpine.SOC.1.00.1408190946280.27327@math.ut.ee>
 <alpine.SOC.1.00.1408201517210.57@math.ut.ee> <53FBF51C.1090503@daenzer.net>
 <alpine.LRH.2.11.1408260954250.4606@siim2.ut.ee>
 <53FD416C.3060005@daenzer.net>
 <CALMQjD_asRUcW8r7v-b5oMUJtdVWiHuYsQnfpiiCgz7UC31QBA@mail.gmail.com>
In-Reply-To: <CALMQjD_asRUcW8r7v-b5oMUJtdVWiHuYsQnfpiiCgz7UC31QBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kjetil Oftedal <oftedal@gmail.com>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel@daenzer.net>, David Miller <davem@davemloft.net>, dri-devel@lists.freedesktop.org

> >>>> The instrumented dmesg had a couple of my local test changes and was
> >>>> bad now that I had ROM. Reverted them exept my readb changes (instead
> >>>> of direct dereferences of iomapped space) and redid
> >>>> logging to be more precise.
> >>>>
> >>>>> [drm] radeon kernel modesetting enabled.
> >>>>> PCI: Enabling device: (0000:02:02.0), cmd 82
> >>>>> [drm] initializing kernel modesetting (RV100 0x1002:0x5159
> >>>>> 0x1002:0x0908).
> >>>>> [drm] register mmio base: 0x10000000
> >>>>> [drm] register mmio size: 32768
> >>>>> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
> >>>>
> >>>>
> >>>> This was still the unchanged kernel hanging.
> >>>>
> >>>> Below is a new debug log to pinpoint the hang. It seems to hang in
> >>>> r100_gfx_get_rptr but not on first try.
> >>>
> >>>
> >>> It's most likely hanging in readl() in r100_mm_rreg() then.
> >>
> >> Yes, it is doing direct readl() there. But what does this hang mean?
> >
> > I'm not sure if the read can hang because of the GPU, or if indicates a more
> > fundamental PCI issue. Dave?
[...]
> Just a short question regarding the test setup.
> Is the video card a Sun XVR-100 or is it a vanilla ATI RV100 ?
> (If it is a vanilla RV100 there might be some kind of initialization issue
> as the video ROM is not executed during boot?)

It,s SUNW,XVR-100 with F-code ROM.

-- 
Meelis Roos (mroos@linux.ee)
