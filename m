From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 15 Feb 2005 18:09:04 +0000
Subject: Re: prom_getproperty cleanups
Message-Id: <20050215100904.2894fbb3.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4206F1AB.8080206@mc.net>
In-Reply-To: <4206F1AB.8080206@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 06 Feb 2005 22:42:19 -0600
Bob Breuer <breuerr@mc.net> wrote:

> Since I brought the subject up, I felt compelled to put some effort
> toward the cleanup.  I have appended the cleanups for the asm-sparc
> and arch/sparc directories.
> 
> I noticed that Art Haas sent a patch for tree.c.  I left my version
> in as an alternative and you can pick whichever one looks better.

I put in Art's fix already, yes.

Can I ask you to do two things please?

1) Add include/linux/compiler.h to oplib.h, that is needed for the
   __must_check declaration.

2) Please include your patch as an attachment.  Something in your
   mailer adds spaces to the beginning of lines of your patches
   so it always rejects when I try to apply.

Thanks.
