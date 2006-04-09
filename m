From: Bob Breuer <breuerr@mc.net>
Date: Sun, 09 Apr 2006 15:05:23 +0000
Subject: Re: Building a small sparc32 kernel
Message-Id: <443922B3.2080204@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060404151927.GC2358@cassis>
In-Reply-To: <20060404151927.GC2358@cassis>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Ludovic Court=E8s wrote:
> So, I now have a 2.6.14 SMP kernel I can boot from.  On my SS20, it
> doesn't even get to the point of spawning `init'.  I get a number of the
> following messages at boot time:
>=20
>   esp0: Resetting scsi bus
>   esp0: SCSI bus reset interrupt
>   esp0: DMA error a4400302

Are you using multiple drives?  I've seen this problem before when using
multiple drives, even with a 2.6 UP kernel, but I've not had a problem
when only actively using one drive.

> And finally, I get spinlock debugging messages followed by a stack trace
> telling that something went wrong ("BUG: spinlock lockup on CPU#2",
> etc.), and nothing more.  I guess I'm going to have to capture the
> console output via a serial line in order to provide you with meaningful
> data.

Try configuring the kernel with spinlock debugging turned off.

> The machine has two SuperSPARC 390Z50.  In your original message you
> mentioned that support for SuperSPARC II was relatively stable, so maybe
> this just means that support for this older SuperSPARC flavor is not yet
> in such a good shape?  ;-)

I think you're almost there.  I don't see any reason why a pair of older
SuperSPARCs wouldn't work, but I don't have any to test against.

Bob
