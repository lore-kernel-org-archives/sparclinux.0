From: David Miller <davem@davemloft.net>
Date: Thu, 04 Jun 2009 22:39:06 +0000
Subject: Re: [2.6.29.4] Blade 2000
Message-Id: <20090604.153906.246161080.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1C36B5.6040707@systella.fr>
In-Reply-To: <4A1C36B5.6040707@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
Date: Fri, 29 May 2009 11:58:54 +0200

> BERTRAND Jo=EBl a =E9crit :
>>     Hello,
>>     I have made some minor modifications in bbc_i2c driver to add en ent=
ry
>>     in /proc directory. ALl mofications have been made against 2.6.29.4
>>     but I haven't verified that this kernel was bootable.
>>     I have built my own bbc_i2c driver as a module. 2.6.29.4 kernel hangs
>>     just after qla2xxx initialization. I don't think that this driver try
>>     to upload firmware. This firmware is built into the kernel.
>> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
>> # CONFIG_STANDALONE is not set
>> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>> CONFIG_FW_LOADER=3Dy
>> CONFIG_FIRMWARE_IN_KERNEL=3Dy
>> CONFIG_EXTRA_FIRMWARE=3D"ql2200_fw.bin"
>> CONFIG_EXTRA_FIRMWARE_DIR=3D"/lib/firmware"
>> Root rayleigh:[/lib/firmware] > ls
>> edgeport emi62 keyspan_pda ql2100_fw.bin ql2300_fw.bin ql2400_fw.bin
>> emi26     ess    korg         ql2200_fw.bin  ql2322_fw.bin  yamaha
>> Root rayleigh:[/lib/firmware] >
>> Configuration:
>> Blade 2000, 2 GB, 2*UIII+/900, Creator3D, internal NIC + 2*3Com NIC.
>>     Is it a known trouble ?
>=20
> 	Nobody ? I have tried 2.6.29.1 with exactly the same bug. 2.6.28.7
> 	worked fine.

I wonder if there is some subtle endianness problem with the
qlogic firmware, so we load it incorrectly into the chip and
it hangs.
