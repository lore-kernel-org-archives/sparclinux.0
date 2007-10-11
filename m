From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2007 22:37:24 +0000
Subject: Re: sun4v_data_access_exception on new 2.6.23
Message-Id: <20071011.153724.102567170.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <470E6F28.2010709@systella.fr>
In-Reply-To: <470E6F28.2010709@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Thu, 11 Oct 2007 20:44:56 +0200

> 	Hello,
>=20
> 	I have built a 2.6.23 kernel on a T1000 server. I have seen this
> message on system console :

Looking at the trace some more, I'm %99.99999 sure you're using
gcc-4.2.x to build this and that compiler is known to miscompile SMP
sparc64 kernels.

gcc-4.1.x would never inline __flush_tsb_one() into flush_tsb_user(),
yet as is evident in your backtraces this is exactly what has
happened, therefore you must be using gcc-4.2.x or another non-4.1.x
compiler to build this.

Please rebuild with gcc-4.1.x, I guarentee the crash will go away.
