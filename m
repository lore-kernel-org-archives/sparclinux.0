From: Jason Wever <weeve@gentoo.org>
Date: Tue, 21 Sep 2004 12:01:51 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <Pine.LNX.4.61.0409210559130.28580@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 20 Sep 2004, David S. Miller wrote:

> On Mon, 20 Sep 2004 18:40:39 -0700
> Matt R Hall <mhcomputing@gmail.com> wrote:
>
>> I filed a report about this in kernel.org's bugzilla and it has not
>> received any comments.
>
> Because the sparc64 kernel maintainer, me, doesn't look at
> kernel.org's bugzilla ever. :-)
>
> Can you make sure 2.6.9-rc2 has the same problem?

I haven't tried anything > 2.6.8.1 yet, but at last look, anything > 2.6.6 
on a Blade 100 would cause lockups under high disk activity possibly in 
combination with high CPU load (in my cases, typically both were high at 
the time of lockup).

I've definitely seen this on 2.6 SMP on the Ultra 2 as well.  I'll try to 
test 2.6.9-rc2 on both machines tonight and see if I can still replicate.

- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUBgxdKvgdVioq28RAjndAJ4gJ3Pol6tweg0+D5LjQWKNOHL0rACfctWX
c7lnf22iSeGb7qYM2gJ9Eic=6ydb
-----END PGP SIGNATURE-----
