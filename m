From: David Miller <davem@davemloft.net>
Date: Mon, 23 Aug 2010 19:22:31 +0000
Subject: Re: bootcup crash in prom tree building with specific PCI card
Message-Id: <20100823.122231.57459008.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 23 Aug 2010 13:44:07 +0300 (EEST)

> Usually (no problematic card or adaptec scsi in place of problematic=20
> card) cnt=3D2. With problematic card in place, cnt=3D3 from beginning and=
=20
> for a lot of prom nodes and then, yes, the corruption occurs:
>=20
> build_one_prop before getproperty: cnt=3D3, node=F009908c, name=3D'driver=
,aapl,macosx,powerpc', value=FFfff8001fed6340, length1931
> build_one_prop after getproperty: len1931, cnt2a4ee00e101ada6
>=20
> Will look at it again tomorrow, enough for now.
> Seems that the length on the resource itself might be the culprit?

That enormous length is the problem, it's writing nearly 32K of garbage
past the end of the PROM call buffer.

Thanks for fetching this information, I'll see if I can figure out
the problem using that.
