From: Ed L Cashin <ecashin@uga.edu>
Date: Thu, 22 Jan 2004 02:15:58 +0000
Subject: Re: TLB miss handler code
Message-Id: <87n08gaftt.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Wed, 21 Jan 2004 18:14:05 -0500 (EST)
> Nawab Ali <alin@ececs.uc.edu> wrote:
>
>> Does it mean I'll have to muck around with the
>> arch/sparc64/kernel/{itlb,dtlb}_*.S files if I have to log(create a
>> tracefile) of all addresses that result in a TLB miss.
>
> That's exactly correct.
>
> In fact, you must not even change the number of instructions in these
> routines because they fit _PRECISELY_ into the sparc v9 trap table
> slots they are in.  You would have to branch to some routine somewhere
> else in the kernel in order to add even one extra instruction of code.

Is it just that simple?  Nawab Ali could, e.g., copy a section "S" of
the trap handler code to a different part of the kernel and replace S
with a jump to the new location.  It would be a lot slower, I
suppose. 

Then, with S in the regular kernel, he could add whatever he wanted,
including jumps to C functions that he writes himself.  That way he
could write his own stuff in C with minimal modifications to the asm.

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

