From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 07 Aug 2004 21:41:17 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <200408072341.17721.arnd@arndb.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-02=_9xUFBrbRPHm/0mK"
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de> <200408072013.01168.arnd@arndb.de> <Pine.GSO.4.58.0408072234290.23642@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0408072234290.23642@waterleaf.sonytel.be>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com, "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>


--Boundary-02=_9xUFBrbRPHm/0mK
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Samstag, 7. August 2004 22:36, Geert Uytterhoeven wrote:
> I've been `fixing up' many of them lately. Please give it a try.
> Anyway, probably all additional clean ups you do for s390 are useful for =
m68k
> as well ;-)

Yes, most devices drivers that rely on ISA or PCI attachment now
appear to be gone.

However, I just tried and found that out of the 23 driver submenus, only
"Generic Driver Options", "Block devices", "SCSI device support",
"Multi-device support", "Networking support" and "Character devices"
make any sense at all. All others depend on some hardware that has
never been attached to an s390 box.=20

We could of course build some subsystems like MTD, ISDN or FB, but
there is still little point without any low-level drivers.

	Arnd <><

--Boundary-02=_9xUFBrbRPHm/0mK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBFUx95t5GS2LDRf4RArfdAJsF/YxSdaEVkYBM6TVKvjS5zkpPdgCggUdl
bMlel72lryEHUERf1SzD0Os=
=eFKu
-----END PGP SIGNATURE-----

--Boundary-02=_9xUFBrbRPHm/0mK--
