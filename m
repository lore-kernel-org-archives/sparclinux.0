From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Date: Fri, 16 Sep 2005 12:42:56 +0000
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
Message-Id: <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-618788828-1126872823=:5000"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
 <20050915.133026.21581824.davem@davemloft.net>
In-Reply-To: <20050915.133026.21581824.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org, davem@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-618788828-1126872823=:5000
Content-Type: TEXT/PLAIN; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-ID: <Pine.BSO.4.62.0509161417341.5000@rudy.mif.pg.gda.pl>

On Thu, 15 Sep 2005, David S. Miller wrote:

> From: Tomasz K=B3oczko <kloczek@rudy.mif.pg.gda.pl>
> Date: Thu, 15 Sep 2005 19:40:27 +0200 (CEST)
>
>> I'm just catch series of kernel messages with soft lockup detected repor=
ts
>> (in attachment).
>> It occures during store big amout of data on NFS volume.
>>
>> As NIC I use now Sun Swift gigabit eth (cassini driver). Probably this is
>> NFS related because I'm just browse yesterday logs and simillar was also
>> on Sun Happy Meal.
>
> Interesting.  Can you reproduce this with SLAB poisioning disabled?
> That debugging feature is extremely expensive, although it shouldn't
> make the CPU stop scheduling processes for more than 10 seconds.
>=20
> I wonder if the NFS daemon code needs to have some limits put on
> how much cpu it consumes handling requests before it gives up the
> cpu.  Perhaps, it has such throttling already, I don't know.

But this not case NFS server but NSF client. During this lookups I observe =

rpciod takes 90-99% time of single processor. Load is between 10 and 20.

> I'll also try to see if there can be some kind of sparc64 specific
> issue which would cause this.
>
> Where did you get that Cassini driver btw?  It's not upstream,
> although if it exists it should be.

It is avalaible on Sun pages (Copyright by Sun by it is GPLed):

http://www.sun.com/download/index.jsp?cat=3DHardware%20Drivers&tab=3D3

Few days ago I'm talk about this driver with spot on #aurora channel and=20
it was included during prepare next kernel package.

But continue ..

Yesterday before testing NFS I was trying utilize NIC is using only=20
ftp/http/rcync/scp and all works correctly (without reporting lookups).=20
~23:00 CET after reported series of lookups system hangs completly. After=20
restart to now I see in dmesg some known messages:

[root@boss]# dmesg | sort | uniq -c | sort -n | tail -n 2
      87 svc: bad direction 268435456, dropping request   <=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
     285 hw tcp v4 csum failed

Also I have question about second (hw tcp v4 csum failed):

[root@boss]# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:03:BA:18:41:F9
           inet addr:153.19.33.230  Bcast:153.19.33.255  Mask:255.255.255.0
           inet6 addr: fe80::203:baff:fe18:41f9/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:2361199 errors:0 dropped:0 overruns:0 frame:0
           TX packets:4060978 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:352428791 (336.1 Mb)  TX bytes:4884521951 (4658.2 Mb)
           Interrupt:192

As you see in both errors is "0". Is this correct reporting broken packets =

in kernel messages instead in RX errors ?

kloczek
--=20
-----------------------------------------------------------
*Ludzie nie maj=B1 problem=F3w, tylko sobie sami je stwarzaj=B1*
-----------------------------------------------------------
Tomasz K=B3oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.p=
l*
--0-618788828-1126872823=:5000--
