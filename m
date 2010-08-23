From: Meelis Roos <mroos@linux.ee>
Date: Mon, 23 Aug 2010 10:44:07 +0000
Subject: Re: bootcup crash in prom tree building with specific PCI card
Message-Id: <alpine.SOC.1.00.1008231053160.14284@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> So, something overwrites the 'lmb' datastructures in the kernel as we
> pull in the device tree.
>=20
> The symbol 'lmb' sits shortly after p1275buf, which is where we store
> arguments and return values for all prom calls.
>=20
> What you could do is annotate arch/sparc/kernel/prom_common.c, function
> build_one_prop() with printouts of the value of lmb.memory.cnt
>=20
> A good spot would be around the prom_firstprop() and prom_nextprop()
> invocations.

Usually (no problematic card or adaptec scsi in place of problematic=20
card) cnt=3D2. With problematic card in place, cnt=3D3 from beginning and=20
for a lot of prom nodes and then, yes, the corruption occurs:

build_one_prop before getproperty: cnt=3D3, node=F009908c, name=3D'driver,a=
apl,macosx,powerpc', value=FFfff8001fed6340, length1931
build_one_prop after getproperty: len1931, cnt2a4ee00e101ada6

Will look at it again tomorrow, enough for now.
Seems that the length on the resource itself might be the culprit?

--=20
Meelis Roos (mroos@linux.ee)
