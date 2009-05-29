From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 29 May 2009 09:58:54 +0000
Subject: Re: [2.6.29.4] Blade 2000
Message-Id: <4A1FB1DE.4020006@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1C36B5.6040707@systella.fr>
In-Reply-To: <4A1C36B5.6040707@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl a =E9crit :
>     Hello,
>=20
>     I have made some minor modifications in bbc_i2c driver to add en=20
> entry in /proc directory. ALl mofications have been made against=20
> 2.6.29.4 but I haven't verified that this kernel was bootable.
>=20
>     I have built my own bbc_i2c driver as a module. 2.6.29.4 kernel=20
> hangs just after qla2xxx initialization. I don't think that this driver=20
> try to upload firmware. This firmware is built into the kernel.
>=20
> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> # CONFIG_STANDALONE is not set
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> CONFIG_FW_LOADER=3Dy
> CONFIG_FIRMWARE_IN_KERNEL=3Dy
> CONFIG_EXTRA_FIRMWARE=3D"ql2200_fw.bin"
> CONFIG_EXTRA_FIRMWARE_DIR=3D"/lib/firmware"
>=20
> Root rayleigh:[/lib/firmware] > ls
> edgeport  emi62  keyspan_pda  ql2100_fw.bin  ql2300_fw.bin  ql2400_fw.bin
> emi26     ess    korg         ql2200_fw.bin  ql2322_fw.bin  yamaha
> Root rayleigh:[/lib/firmware] >
>=20
> Configuration:
>=20
> Blade 2000, 2 GB, 2*UIII+/900, Creator3D, internal NIC + 2*3Com NIC.
>=20
>     Is it a known trouble ?

	Nobody ? I have tried 2.6.29.1 with exactly the same bug. 2.6.28.7=20
worked fine.

	Regards,

	JKB
