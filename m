From: David Miller <davem@davemloft.net>
Date: Thu, 11 Jun 2009 10:38:04 +0000
Subject: Re: [2.6.29.4] Blade 2000
Message-Id: <20090611.033804.183382674.davem@davemloft.net>
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

I just did a scan over the driver changes for qla2xxx from 2.6.28
and 2.6.29 and they were very extensive and complicated.

What we need to do to narrow this down is do a GIT bisect.  I hope
that you have a GIT tree handy and can do this?

Luckily it's pretty easy to only bisect through the qla2xxx changes.

Once you have a tree checked out, start like this:

bash$ git bisect start v2.6.29 v2.6.28 -- drivers/scsi/qla2xxx/

Configure and build that kernel, see if it shows the bug.

If the bug is there go into the GIT tree and say:

bash$ git bisect bad

else if the bug is not there say:

bash$ git bisect good

Rebuild and retest.  Repeat this process of testing and then
running "git bisect good" or "git bisect bad" until the guilty
changeset is found.  At most you'll need to do this 6 times.

Post the result here.

We'll find a way to fix this, thanks!
