From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 06 Dec 2004 04:30:53 +0000
Subject: Re: mmap breakage
Message-Id: <Pine.LNX.4.61.0412052314550.5504@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 4 Dec 2004, Richard Mortimer wrote:

> I guess that this isn't really what you want to hear but it does 
> describe why the behaviour exists. I don't have any magic suggestions as
> to how to fix it - sorry.
>
> Richard

Hi,

Thanks for the input. I have forwarded the question to debian-glibc [0], 
asking whether they consider it glibc or kernel problem. So far I have 
received response from Daniel Jacobowitz [1]:

> ld-linux ought to check.  In this particular case, it doesn't.  But if
> it did check, the only thing it could do would be to print an error
> message and quit.  The executable _must_ be mapped at the linked
> address (since it isn't position independent).  ld can't move itself.
> The kernel picked where to load ld; it would be nice if it picked
> somewhere more useful than 0x08000000 on your architecture.  On i386,
> it picks:
>
> 80000000-80016000 r-xp 00000000 09:00 11993980   /lib/ld-2.3.2.so
> 80016000-80017000 rw-p 00015000 09:00 11993980   /lib/ld-2.3.2.so
> 80017000-8006e000 rw-p 80017000 00:00 0 
> 
> which gives you up to 2GB for the executable.

So now the question is why ld-linux.so.2 on sparc64 is mapped at 
0x08000000 instead of something higher, like 0x80000000 on i386? This
actually limits the size of an executable plus all the shared libraries 
required by it (if I understand it correctly) to 128MB. Can this limit be 
easily modified, or are there some special architectural considerations, 
preventing that?

[0] http://lists.debian.org/debian-glibc/2004/12/msg00057.html
[1] http://lists.debian.org/debian-glibc/2004/12/msg00060.html

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
