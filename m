From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 17 Jan 2011 17:23:07 +0000
Subject: Re: silo fails to build with e2fsprogs-1.41.14 (undefined
Message-Id: <1295284987.13721.4.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <4D2B59AC.8040203@gentoo.org>
In-Reply-To: <4D2B59AC.8040203@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2011-01-17 at 17:02 +0000, Richard Mortimer wrote:

> >> -    malloc_ptr = (char *) ((((unsigned long) malloc_ptr) + 7)&  (~7));
> >> +    malloc_ptr = align_ptr_to(malloc_ptr, 7UL);
> I think that should be 8UL because align_ptr_to does -1 to make it 7.

> >> +    malloc_ptr = align_ptr_to(malloc_ptr, 7UL);
> Ditto

That would explain the different error, this time it was 256, the
previous error was -1^32. 

I'll change the patch with the new values and see if that works. 
-- 
Tactical Nuclear Kittens
