From: Jason Wever <weeve@gentoo.org>
Date: Tue, 06 Mar 2007 15:22:57 +0000
Subject: Re: [Systems] Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <Pine.LNX.4.64.0703060819070.17089@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
In-Reply-To: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 5 Mar 2007, Corey Shields wrote:

> On 3/5/07, Michael Marineau <mike@marineau.org> wrote:
>>  Built the kernel with gcc 4.1.1 and I got the oops in just a few
>>  minutes, trying a second time now and it is lasting longer this time
>>  around.
>
> Why not try and recreate this on bender (Gentoo's T2000)?  Weeve?

We're currently building release material on it but I'll schedule some 
time to try and see if Gustavo and I can replicate this.

We've been running bender with gcc-3.4.6 compiled kernels (currently 
running 2.6.20-gentoo) and we haven't encountered this issue (yet).

Cheers,
- -- 
Jason Wever
Gentoo/Sparc Team Co-Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF7YdVdKvgdVioq28RAm7WAKC6tJ/o0Yg+URqXSpIP2XdXuIuf2QCeKmqA
Y25gg0Eje2VQa5VbczN0upg=9Ptj
-----END PGP SIGNATURE-----
