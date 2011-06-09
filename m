From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Thu, 09 Jun 2011 11:37:43 +0000
Subject: Re: patch for i2c_ali1535 working on SPARC
Message-Id: <4DF0B087.9090902@geomatys.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4DEC895B.30101@geomatys.fr>
In-Reply-To: <4DEC895B.30101@geomatys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Le 06/06/2011 10:01, corentin.labbe a =E9crit :
> Hello
>=20
> I have a sun blade 100 and I want to get the sensors working with
> lm_sensors, but in current state, it doesn't work.
>=20
> After some research, i have found that all smbus driver and the i2c_ali15=
35 particularly cant work.
> It assumes that ioport address are 16bits wide (address stored with an un=
signed short).
> But on SPARC arch, ioports are mapped in memory and so are stored with an=
 unsigned long.
>=20
> So I write a patch for i2c_ali1535 for supporting SPARC architecture.
> With this patch, the driver i2c_ali1535 loads and works successfully.
> # sensors
> adm1023-i2c-0-18
> Adapter: SMBus ALI1535 adapter at 0x1fe02000620
> temp1:       +31.0 C  (low  =3D -55.0 C, high =3D +127.0 C)
> temp2:       +61.6 C  (low  =3D -55.0 C, high =3D +127.0 C)
>=20
> But this patch is bad because the base address for ioport is hard-coded (=
0x1fe02000000).
> I have tried to understand how works all SPARC drivers but I cant find ho=
w to get that.
>=20
> Perhaps i can get some usefull infos with all of_* functions but i dont k=
now what exaclty means infos printed by prtconf (assigned-addresses and reg=
 specifically).
>         Node 0xf0083f44
>             .node:  f0083f44
>             assigned-addresses:  81001810.00000000.00000000.00000000.0000=
0010
>             name: 'pmu'
>             ranges:  00000000.00000000.00001800.00000000.00000000.0000010=
0.00000001.00000000.81001810.00000000.00000600.00000100.00000002.00000000.8=
1001814.00000000.00000000.00000100
>             reg:  00001800.00000000.00000000.00000000.00000000.81001810.0=
0000000.00000600.00000000.00000010
>             compatible:  70636931.3062392c.37313031.2e300070.63693130.623=
92c37.31303100.70636963.6c617373.2c303030.30303000.70636963.6c617373.2c3030=
30.3000
>             #address-cells:  00000002
>             #size-cells:  00000001
>             devsel-speed:  00000001
>             class-code:  00000000
>             latency-timer:  00000000
>             cache-line-size:  00000000
>             max-latency:  00000000
>             min-grant:  00000000
>             revision-id:  00000000
>             device-id:  00007101
>             vendor-id:  000010b9
>=20
>             Node 0xf00849c4
>                 .node:  f00849c4
>                 reg:  00000000.00000000.00000100.00000001.00000000.000001=
00
>                 #address-cells:  00000002
>                 #size-cells:  00000000
>                 interrupts:  00000001
>                 compatible: 'i2c-smbus'
>                 name: 'i2c'
>=20
>                 Node 0xf008505c
>                     .node:  f008505c
>                     compatible: 'i2c-max1617'
>                     name: 'temperature'
>                     reg:  00000000.00000030
>=20
>=20
> Best regards

Hello

Sorry, i think i must clarify, my question is:
Is there a way to figure out the I/O port offset without hard-coding it ?

I have found pci_determine_mem_io_space() in arch/sparc/kernel/pci_common.c=
 and struct iomem_resource.start but still dont know if it is a good way to=
 get it.

Thanks in advance

Best regards
