From: Nawab Ali <alin@ececs.uc.edu>
Date: Wed, 21 Jan 2004 23:14:05 +0000
Subject: Re: TLB miss handler code
Message-Id: <Pine.GSO.4.43.0401211805010.18713-100000@gatekeeper.ececs.uc.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 21 Jan 2004, Ed L Cashin wrote:

> "David S. Miller" <davem@redhat.com> writes:
>
> OK.  Thanks much for the response.  It is a lot more concrete now.
>
> I think Nawab Ali (the OP) has his work cut out for him, though.
> Logging the pte on every TLB miss sounds tricky at best, given that
> these fast handlers will service most misses.

Does it mean I'll have to muck around with the
arch/sparc64/kernel/{itlb,dtlb}_*.S files if I have to log(create a
tracefile) of all addresses that result in a TLB miss. My understanding
of sparc asm is not that great and I was wondering if there is any other way.

Thanx for all the help guys.

-nawab

> --
> --Ed L Cashin            |   PGP public key:
>   ecashin@uga.edu        |   http://noserose.net/e/pgp/
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

==
Ask not what Mozilla can do for you...
---------------------------------------------------------
  Nawab Ali.			Graduate Student
  3238 Bishop Street #2.	www.ececs.uc.edu/~alin
  Cincinnati. OH - 45220.	Email: alin@ececs.uc.edu
---------------------------------------------------------

