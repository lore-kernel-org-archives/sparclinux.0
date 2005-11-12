From: Ferris McCormick <fmccor@gentoo.org>
Date: Sat, 12 Nov 2005 02:58:36 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <Pine.LNX.4.64.0511120246230.26359@terciopelo.krait.us>
List-Id: <sparclinux.vger.kernel.org>
References: <20051110.210234.59468958.davem@davemloft.net>
In-Reply-To: <20051110.210234.59468958.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 11 Nov 2005, David S. Miller wrote:

> From: Ferris McCormick <fmccor@gentoo.org>
> Date: Fri, 11 Nov 2005 21:35:48 +0000
>
>> I'm running it on U2(2x400) currently with 2.6.14-U2-2x400-g393b0725.
>> So far, it's doing fine, and this is on a system which has never been
>> stable with a 2.6 kernel.  With this kernel + IRQ patch, though, it's
>> stayed up through a lot of stress tests which I would have expected
>> would have killed it.
>> (But uptime is only 6 hours so far).
>
> It would be interesting to know if that exact kernel,
> but without the IRQ stacks patch, works just as well.
>
> It's nice that it's stable, but we should find out exactly
> why :-)
>
If the system is still up Monday and if no one else has reported on the U2 
(and U1) stability, I'll try to make a test using Josh Grebe's (squash's) 
crashme script against that kernel with the IRQ patch removed.  I can't 
give a good estimate of when the test will be possible because Monday 
morning the U2 will be helping with a fairly lengthy upgrade unrelated to 
the kernel.

Regards,
Ferris
- --
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (sparc, devrel)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDdVpgQa6M3+I///cRAoh6AKCHJfFYVWRISLfpB4SSRSeE3CdPbACgtxnF
FloXJHIgbtQvu2IYtXgDAoY=lxeP
-----END PGP SIGNATURE-----
