From: Meelis Roos <mroos@linux.ee>
Date: Tue, 26 Aug 2014 07:07:48 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <alpine.LRH.2.11.1408260954250.4606@siim2.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1309240010220.15075@math.ut.ee>
 <alpine.SOC.1.00.1310011134250.26098@math.ut.ee>
 <20140404.165202.33247787406066736.davem@davemloft.net>
 <20140812.233033.2016564874125097713.davem@davemloft.net>
 <alpine.SOC.1.00.1408190946280.27327@math.ut.ee>
 <alpine.SOC.1.00.1408201517210.57@math.ut.ee> <53FBF51C.1090503@daenzer.net>
In-Reply-To: <53FBF51C.1090503@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: sparclinux@vger.kernel.org, oftedal@gmail.com, David Miller <davem@davemloft.net>, dri-devel@lists.freedesktop.org

> > > r100 init hangs in a different place. Original dmesg first, then my
> > > instrumented dmesg (seems to get further):
> >
> > The instrumented dmesg had a couple of my local test changes and was
> > bad now that I had ROM. Reverted them exept my readb changes (instead
> > of direct dereferences of iomapped space) and redid
> > logging to be more precise.
> >
> > > [drm] radeon kernel modesetting enabled.
> > > PCI: Enabling device: (0000:02:02.0), cmd 82
> > > [drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0=
908).
> > > [drm] register mmio base: 0x10000000
> > > [drm] register mmio size: 32768
> > > [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
> >
> > This was still the unchanged kernel hanging.
> >
> > Below is a new debug log to pinpoint the hang. It seems to hang in
> > r100_gfx_get_rptr but not on first try.
>=20
> It's most likely hanging in readl() in r100_mm_rreg() then.

Yes, it is doing direct readl() there. But what does this hang mean?


By the way, I get these warnings from r100. Seem to be unrelated but=20
still worth reporting IMHO:

  CC [M]  drivers/gpu/drm/radeon/r100.o
drivers/gpu/drm/radeon/r100.c: In function =A1r100_bandwidth_update=A2:
include/drm/drm_fixed.h:64:13: warning: =A1crit_point_ff.full=A2 may be use=
d uninitialized in this function [-Wuninitialized]
drivers/gpu/drm/radeon/r100.c:3149:63: note: =A1crit_point_ff.full=A2 was d=
eclared here
drivers/gpu/drm/radeon/r100.c:3573:42: warning: =A1disp_drain_rate.full=A2 =
may be used uninitialized in this function [-Wuninitialized]


--=20
Meelis Roos (mroos@linux.ee)
