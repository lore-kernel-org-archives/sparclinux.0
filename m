From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 05 Jan 2007 17:45:48 +0000
Subject: Re: [2.6.19.1] ESP regression ?
Message-Id: <1168019148.3161.107.camel@dhcp-32-109.ord.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <459E1EC7.7050300@systella.fr>
In-Reply-To: <459E1EC7.7050300@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, 2007-01-05 at 10:47 +0100, BERTRAND Jo=C3=ABl wrote:
> 	Hello,
>=20
> 	Some trouble again with ESP DMA and the 2.6.19 kernel ? With very high=20
> disk load (raid reconstruction or apt-get dist-upgrade), I can seen ESP=20
> DMA error on a SS20 workstation. This trouble has been fixed in 2.6.18.=20
> Is there any chance to fix this with the last 2.6.20-rc ?
>=20
> 	Test config :
> - dual SS-II/75 MHz
> - 448 MB
> - 8MB VSIMM
> - 2 36 GB internal SCSI disks
> - 2.6.19.1 kernel

For what it is worth, I'm not actually able to get esp.ko (Aurora builds
esp as a module) working at all on any sparc32 systems (immediate
testing on ss4 and ss20). Several of the Aurora folks have been helping
me try to track down the failure, and here is what we know so far:

2.6.16 works properly on the ss4:
http://beer.tclug.org/jima/text/tmi-2.6.16-1.2241sp7.1-dmesg.txt

We see the disk on the esp controller at target three, and life is good.

2.6.18.1 does not work properly on the ss4:
http://beer.tclug.org/jima/text/tmi-2.6.18-1.2798.al3.3.txt

The esp.ko module loads, but it doesn't see the disk on the esp
controller at target three.

We then tested on an Ultra 2 to see if that hardware (which has multiple
esp controllers in it) would detect devices correctly, and it does:
http://beer.tclug.org/jima/text/badger-2.6.18-1.2798.al3.1smp-dmesg.txt

I also tested 2.6.20-rc1-git5 on the sparc32s, but it also fails to see
any of the attached devices (disk on the ss4, disk and cdrom on the
ss20).

At this point, I built 2.6.16 and 2.6.18.1 kernels with all the DEBUG_
defines enabled, in the hopes of exposing the differences in behavior.

Here is the 2.6.16 debugging output from the ss4:
http://beer.tclug.org/jima/text/tmi-2.6.16-1.2241sp7.2.txt

Here is the 2.6.18.1 debugging output from the ss4:
http://beer.tclug.org/jima/text/tmi-2.6.18-1.2798.al3.4.txt

The differences are rather staggering, the 2.6.16 kernel seems to call
esp_queue multiple times upon discovering the disk on target 3, but the
2.6.18.1 kernel only calls it once.

Comparing the output on the ss4:

On 2.6.16, we see:
<SLCTNORM>I[0:0](=20
<CLUELESS>esp_do_data:=20
<DATAIN>newphase
<DATAIN> hmuch<36> DMA|TI --> do_intr_end )
I[0:0](esp_work_bus: esp_do_data_finale: trans_z(36), bytes_sent(36),
<CLUELESS>!bogus_data, to new phase

At the same point in 2.6.18.1, we see:
<SLCTNORM>I[0:0](
<CLUELESS>esp_do_data:=20
<DATAIN>newphase
<DATAIN> hmuch<252> DMA|TI --> do_intr_end )
I[0:0](esp_work_bus: esp_do_data_finale: trans_sz(252), bytes_sent(18),
<CLUELESS>!bogus_data, to new phase

Note the difference in trans_sz, bytes_sent, hmuch... not sure if that
is relevant, or just noise.

After this, both kernels output:
<STATUS>esp_do_status: ack msg, got something, got both, status=3D 0 msg0, =
and was COMMAND_COMPLETE
<FREEING>F<03,00>)

But while the 2.6.16 kernel continues on target 3, recalling esp_queue,
and finding the disk on target 3:

esp_queue: target=3D3 lun=3D0 N<03,00>
esp: Selecting device for first time. target=3D3 lun=3D0
<SLCTNORM>I[0:0](<CLUELESS>esp_do_data: <DATAIN>newphase<DATAIN> hmuch<144>=
 DMA|TI --> do_intr_end
)I[0:0](esp_work_bus: esp_do_data_finale: trans_sz(144), bytes_sent(144), <=
CLUELESS>!bogus_data, to new phase
<STATUS>esp_do_status: ack msg, got something, got both, status=3D 0 msg=3D=
 0, and was COMMAND_COMPLETE
<FREEING>F<03,00>)<5>  Vendor: SEAGATE   Model: ST34573WC         Rev: 6244
  Type:   Direct-Access                      ANSI SCSI revision: 02
.....

The 2.6.18.1 kernel stops and moves on to target 4+:
esp_queue: target=3D4 lun=3D0 N<04,00>
esp: Selecting device for first time. target=3D4 lun=3D0
<SLCTNORM>I[0:0](esp: selection failure, maybe nobody there?
esp: target 4 lun 0
)esp_queue: target=3D5 lun=3D0 N<05,00>
esp: Selecting device for first time. target=3D5 lun=3D0
<SLCTNORM>I[0:0](esp: selection failure, maybe nobody there?
esp: target 5 lun 0
)esp_queue: target=3D6 lun=3D0 N<06,00>
esp: Selecting device for first time. target=3D6 lun=3D0
<SLCTNORM>I[0:0](esp: selection failure, maybe nobody there?
esp: target 6 lun 0
)

I'm not sure why this is failing, looking at git, the changes to esp to
port it to the new SBUS layer are the most significant differences:
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;hA1aa5540536feace62c97478a8ea5dab7469377

But, I'm not sure why this would break sparc32 and not sparc64, and
reverting it really isn't the way to go here.

I've also got the debugging output from esp.ko on 2.6.18.1 on the Ultra
2:
http://beer.tclug.org/jima/text/badger-2.6.18-1.2798.al3.4smp.txt

It's worth noting that the trans_sz, bytes_sent and hmuch values here
match the values from the working 2.6.16 kernel on the ss4.

All kernels were built with the same toolchain:
gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)

Dave, any assistance you can offer here would be greatly appreciated, as
this is pretty much a showstopper for the next Aurora release (broken
scsi).

~spot

