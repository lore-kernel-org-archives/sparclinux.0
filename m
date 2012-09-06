From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 06 Sep 2012 16:55:51 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <1346950551.30263.196.camel@thor.local>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

On Don, 2012-09-06 at 17:41 +0300, Meelis Roos wrote:=20
> This is with initialyy unmodified 3.6.0-rc4-00101-g0809095 kernel in=20
> Ultra 10 (clean, without my "Video RAM" hack that I talked in other=20
> sparclinux posts). When I saw that Sun XVR-100 was detected fine by the=20
> kernel, I compiled radeon drm driver with modesetting enabled and tried=20
> it:
>=20
> [drm] radeon defaulting to kernel modesetting.
> [drm] radeon kernel modesetting enabled.
> PCI: Enabling device: (0000:02:02.0), cmd 82
> [drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0908).
> [drm] register mmio base: 0x10000000
> [drm] register mmio size: 32768
> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
>=20
> And here the machine hangs. Debugging printk-s reveal that it does not=20
> find any active I/O port resources and then continues into initializing=20
> the card. Down in igp_read_bios_from_vram() it successfully ioremaps=20
> memory region 0 (vram_base=1Ff08000000 and size@000) and tries to read=20
> 2 bytes from there and hangs on reading bios[0].

Is the card initialized by OpenFirmware? E.g., does it display anything
before the kernel boots?


> With radeon.modeset=3D0, it boots [...]

Does X work with DRI enabled then?


--=20
Earthling Michel D=E4nzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer
