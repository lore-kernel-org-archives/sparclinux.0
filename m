From: mroos@linux.ee
Date: Mon, 23 Sep 2013 13:48:32 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <alpine.SOC.1.00.1309231638330.9952@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
	<1346950551.30263.196.camel@thor.local>
	<20120906.141823.13429356729572330.davem@davemloft.net>
	<CAPM=9ty87-kP1QJjgJKQUVkJxg8yN6ZQ5qy+pVYRnrDoa_VqBQ@mail.gmail.com>
In-Reply-To: <CAPM=9ty87-kP1QJjgJKQUVkJxg8yN6ZQ5qy+pVYRnrDoa_VqBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dave Airlie <airlied@gmail.com>
Cc: sparclinux@vger.kernel.org, michel@daenzer.net, David Miller <davem@davemloft.net>, dri-devel@lists.freedesktop.org

Resurrecting an old thread...

> On Fri, Sep 7, 2012 at 4:18 AM, David Miller <davem@davemloft.net> wrote:
> > From: Michel D=E4nzer <michel@daenzer.net>
> > Date: Thu, 06 Sep 2012 18:55:51 +0200
> >
> >> On Don, 2012-09-06 at 17:41 +0300, Meelis Roos wrote:
> >>> This is with initialyy unmodified 3.6.0-rc4-00101-g0809095 kernel in
> >>> Ultra 10 (clean, without my "Video RAM" hack that I talked in other
> >>> sparclinux posts). When I saw that Sun XVR-100 was detected fine by t=
he
> >>> kernel, I compiled radeon drm driver with modesetting enabled and tri=
ed
> >>> it:
> >>>
> >>> [drm] radeon defaulting to kernel modesetting.
> >>> [drm] radeon kernel modesetting enabled.
> >>> PCI: Enabling device: (0000:02:02.0), cmd 82
> >>> [drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0=
908).
> >>> [drm] register mmio base: 0x10000000
> >>> [drm] register mmio size: 32768
> >>> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
> >>>
> >>> And here the machine hangs. Debugging printk-s reveal that it does not
> >>> find any active I/O port resources and then continues into initializi=
ng
> >>> the card. Down in igp_read_bios_from_vram() it successfully ioremaps
> >>> memory region 0 (vram_base=1Ff08000000 and size@000) and tries to read
> >>> 2 bytes from there and hangs on reading bios[0].
> >>
> >> Is the card initialized by OpenFirmware? E.g., does it display anything
> >> before the kernel boots?
> >
> > I think Meelis gave you every single detail you need to know to
> > analyze and fix this bug.
> >
> > He says it crashes on reading bios[0].
> >
> > If you look at the function he tells you the crash occurs in, you'll
> > see clearly that bios is an ioremap()'d pointer.
> >
> > You cannot dereference ioremap()'d pointers, you must use the proper
> > accessors such as readl().
>=20
> we should just skip the igp reading function on not-x86, since IGP on
> not x86 makes no sense.
>=20
> the other option is to readl out the whole bios from vram instead.

I made several changes.

1. In igp_read_bios_from_vram():

+#ifndef CONFIG_X86
+       /* IGP only exists on X86 (32- and 64-bit) */
+       return false;
+#endif

This gets me further.

2. Since "bios" is __iomem pointer, changed its dereferences to=20
readb(bios) and readb(bios+1). Maybe relevant, maybe not.

3. Next it got stuck in radeon_read_bios() trying to do
kmemdup(bios, size, GFP_KERNEL);

This I changed to mydup for test:

+static void *mydup(uint8_t __iomem *src, size_t len, gfp_t gfp)
+{
+       unsigned char *p;
+       int i;
+
+       p =3D kmalloc(len, gfp);
+       if (p) {
+               for (i=3D0; i<len; i++) {
+                       p[i] =3D readb(src+i);
+               }
+       }
+       return p;
+}

And this copying crashes Adaptec scsi driver in different ways.

Investigating this, I found that it makes BAR 6 of the PCI radeon and=20
gets bios=000001ff00000000 assigned. There is also some "Unable to find=20
PCI I/O BAR" before - seesm that firmware does not map this ROM...
To make things worse, the 2 first bytes at 000001ff00000000 actually do=20
contain the ROM marker, so it goes on to copying.

[drm] radeon kernel modesetting enabled.
PCI: Enabling device: (0000:02:02.0), cmd 82
[drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0908).
[drm] register mmio base: 0x000001FF10000000
[drm] register mmio size: 32768
[drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
[drm] radeon_read_bios 1
radeon 0000:02:02.0: BAR 6: assigned [mem 0x1ff00000000-0x1ff0001ffff]
[drm] radeon_read_bios: found ROM signature at 000001ff00000000
[drm] radeon_read_bios 7: bios=000001ff00000000, sizeF592

However, this is where aic7xxx is mapped - /proc/iomem contains this=20
(yes, the machine has ffb graphics and 2 ATI magc64 graphics heads too):

1fc00400000-1fc0040000f : ffb dac
1fc00600000-1fc00600983 : ffb fbc
1ff00000000-1ffffffffff : /pci@1f,0
  1ff00002000-1ff00002fff : aic7xxx
  1ff000a0000-1ff000bffff : Video RAM area
  1ff000c0000-1ff000c7fff : Video ROM
  1ff000f0000-1ff000fffff : System ROM
  1ff11000000-1ff11ffffff : atyfb
  1ffc0000000-1ffdfffffff : IOMMU
  1ffe0000000-1ffe000701f : sunhme
  1ffe1000000-1ffe1ffffff : atyfb
  1fff1000000-1fff1001fff : eeprom
  1fff1200000-1fff120000f : cs4231
  1fff13062f8-1fff13062ff : su
  1fff13083f8-1fff13083ff : su
  1fff1400000-1fff140003f : sab
  1fff1400040-1fff140007f : sab
  1fff1702000-1fff170200f : cs4231_pdma
  1fff1704000-1fff170400f : cs4231_cdma
  1fff1724000-1fff1724003 : power
  1fff1726000-1fff1726003 : auxio


Where do I go from here?

--=20
Meelis Roos (mroos@linux.ee)
