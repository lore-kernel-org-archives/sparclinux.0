From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 05 Jun 2009 07:49:24 +0000
Subject: Re: [2.6.29.4] Blade 2000
Message-Id: <4A28CE04.1020109@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1C36B5.6040707@systella.fr>
In-Reply-To: <4A1C36B5.6040707@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
> Date: Fri, 29 May 2009 11:58:54 +0200
>=20
>> BERTRAND Jo=EBl a =E9crit :
>>>     Hello,
>>>     I have made some minor modifications in bbc_i2c driver to add en en=
try
>>>     in /proc directory. ALl mofications have been made against 2.6.29.4
>>>     but I haven't verified that this kernel was bootable.
>>>     I have built my own bbc_i2c driver as a module. 2.6.29.4 kernel han=
gs
>>>     just after qla2xxx initialization. I don't think that this driver t=
ry
>>>     to upload firmware. This firmware is built into the kernel.
>>> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
>>> # CONFIG_STANDALONE is not set
>>> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>>> CONFIG_FW_LOADER=3Dy
>>> CONFIG_FIRMWARE_IN_KERNEL=3Dy
>>> CONFIG_EXTRA_FIRMWARE=3D"ql2200_fw.bin"
>>> CONFIG_EXTRA_FIRMWARE_DIR=3D"/lib/firmware"
>>> Root rayleigh:[/lib/firmware] > ls
>>> edgeport emi62 keyspan_pda ql2100_fw.bin ql2300_fw.bin ql2400_fw.bin
>>> emi26     ess    korg         ql2200_fw.bin  ql2322_fw.bin  yamaha
>>> Root rayleigh:[/lib/firmware] >
>>> Configuration:
>>> Blade 2000, 2 GB, 2*UIII+/900, Creator3D, internal NIC + 2*3Com NIC.
>>>     Is it a known trouble ?
>> 	Nobody ? I have tried 2.6.29.1 with exactly the same bug. 2.6.28.7
>> 	worked fine.
>=20
> I wonder if there is some subtle endianness problem with the
> qlogic firmware, so we load it incorrectly into the chip and
> it hangs.

	I can do some tests this week-end. How can I help you ?

	Regards,

	JKB
