From: Ben Collins <bcollins@debian.org>
Date: Tue, 02 Mar 2004 14:32:13 +0000
Subject: Re: Slab corruption in 2.6.4-rc1 on sparc64 (sunblade 100)
Message-Id: <20040302143213.GX1078@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1078237230.4360.19.camel@zorak>
In-Reply-To: <1078237230.4360.19.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> ohci1394: $Rev: 1131 $ Ben Collins <bcollins@debian.org>
> ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[10,7dc]  MMIO=3D[1ff00420=
000-1ff004207ff]  Max Packet=3D[2048]
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0003bafffe0ce3c0]
> Slab corruption: start=FFfff800279d0200, len%6
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<0000000000000000>](0x0)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 20 20 20 30 09 20 20 20
> Prev obj: start=FFfff800279d00e8, len%6
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<0000000000000000>](0x0)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Next obj: start=FFfff800279d0318, len%6
> Redzone: 0x170fc2a5/0x170fc2a5.
> Last user: [<000000000049faec>](d_alloc+0xc/0x1a0)
> 000: 00 00 00 00 5a 5a 5a 5a 00 00 00 00 00 00 00 10
> 010: 00 00 00 00 00 00 00 00 ff ff f8 00 27 9d 03 30

Damn, looks like I have to take the blame for this one. Slab corruption
usually means that someone used malloc'd memory after they free'd it.

Is this reproducible? If so, can you check the latest -bk for 2.6.4 and
see if that fixes it?

We should take this to private since it's nothing to do with sparc.

--=20
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
