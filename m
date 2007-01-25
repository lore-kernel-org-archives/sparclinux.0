From: David Miller <davem@davemloft.net>
Date: Thu, 25 Jan 2007 22:02:41 +0000
Subject: Re: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <20070125.140241.41701224.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Vince Weaver <vince@deater.net>
Date: Wed, 24 Jan 2007 22:00:12 -0500 (EST)

> I've reproduced it, here are the results (the bug is still at line 413,=20
> my debug code pushed it down a bit):
>=20
>=20
> [  263.773194] VMW: fault_code=3D4 address=FF0cc000 regs->tpcp131660

Thanks for the info Vince, I'll look more closely at this.
