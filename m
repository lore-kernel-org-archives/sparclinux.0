From: "John Cater" <katre50@gmail.com>
Date: Fri, 08 Feb 2008 03:10:48 +0000
Subject: Issue with linux sunvdc driver and solaris zfs partitions
Message-Id: <d105c9dd0802071910u45a1554g639ea278b023ceb@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've recently gotten a SunFire T1000 server, so I've been playing with
putting Logical Domains on it so I can turn it into a few different
ubuntu boxes.  After a lot of fiddling, I managed to get Ubuntu
installed, with no problems.

However, the virtual disk the guest domain was using was based off of
a file, not a raw filesystem.  I looked at the Sun docs, and did the
following to try and create a ZFS volume I could use for my linux box:

$ zfs create -V 10GB tank/ldom1
$ ldm add-vdiskserverdevice /dev/zvol/rdsk/tank/ldom1 ldom1@primary-vds0
$ ldm add-vdisk vdisk1 ldom1@primary-vds0 ldom1
I then started ldom1 with 'ldm start ldom1'.

All of this worked fine on the Solaris side.  However, when I tried to
boot the Ubuntu installer now, I get the following message:

[15473.014047] sunvdc.c:v1.0 (June 25, 2007)
[15473.031275] sunvdc: VD_OP_GET_VTOC returns error -48
[15473.031319] vdc_port: probe of vdc-port-0-0 failed with error -48

I tried again with two devices, one exposing a ZFS volume and another
a file, and the file still worked.

I am unable to find any docs on what error -48 might signify.

I was hoping you could help point me in the right direction.

The ubuntu 7.10 installer is using linux kernel 2.6.22-14-sparc64,
which I assume is a customized Ubuntu version of the stock 2.6.22
kernel.  I looked at the changelogs and didn't see anything glaringly
obvious that would have changed since 2.6.22 to fix this.

If you can offer me any advice, that would be great.  Thanks!

John Cater
katre50@gmail.com
