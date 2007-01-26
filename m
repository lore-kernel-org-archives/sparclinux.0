From: David Miller <davem@davemloft.net>
Date: Fri, 26 Jan 2007 08:39:53 +0000
Subject: Re: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <20070126.003953.08324074.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Vince Weaver <vince@deater.net>
Date: Thu, 25 Jan 2007 22:21:00 -0500 (EST)

>=20
> >> Note, this patch is pretty straight forward, but I've only compile
> >> tested it.  I'm about to test boot it myself right now.
> >
> > FWIW, it works fine for me :)
>=20
> Unfortunately it didn't seem to fix things.  It ran a lot longer this=20
> time, but eventually stopped with
>=20
> [  597.730241] VMW: fault_code=3D4 address=FF564000 regs->tpcp179660
> [  597.730266] kernel BUG at arch/sparc64/mm/fault.c:417!

That eliminates one theory.

I'll think about this some more, but could you do me a favor
and test something?  Revert my patch, and change your debugging
printk to print out not just fault_code and address, but also
get_thread_fault_code() and current_thread_info()->fault_address.

I want to see if they are changing after being read for some
reason.

Thanks!
