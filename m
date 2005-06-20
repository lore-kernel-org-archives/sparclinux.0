From: Jason Wever <weeve@gentoo.org>
Date: Mon, 20 Jun 2005 02:27:12 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <20050619202712.473d77bc@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Sun__19_Jun_2005_20_27_12_-0600_Dpr1HNnxglnZNAsm"
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

--Signature_Sun__19_Jun_2005_20_27_12_-0600_Dpr1HNnxglnZNAsm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Jun 2005 19:20:34 -0700 (PDT)
"David S. Miller" <davem@davemloft.net> wrote:

> 64-bit or 32-bit userland binaries?

32 bit userland binaries.  Currently we don't have a working 64 bit
environment that is suggested for general use.
=20
> He could be hitting the kmalloc() limit via the netfilter
> 32-bit userland compat code in:
>=20
>        arch/sparc64/kernel/sys_sparc32.c:do_netfilter_replace()
>=20
> You have to make sure you replicate the netfilter commands
> his system is running, in order to determine where the limit
> is actually coming from.

I used a C program[1] written by Gustavo Zacarias to replicate here and
I'll post a follow-up once I get a response from the user.

[1] - http://dev.gentoo.org/~gustavoz/source/iptables_test.c

Thanks,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature_Sun__19_Jun_2005_20_27_12_-0600_Dpr1HNnxglnZNAsm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCtimAdKvgdVioq28RApWuAJ0XWITdczwLNw7xPYA0zn8Ugb2OYwCfewWl
fQou3dABY67AQNaDW+KBzns=
=JLG0
-----END PGP SIGNATURE-----

--Signature_Sun__19_Jun_2005_20_27_12_-0600_Dpr1HNnxglnZNAsm--
