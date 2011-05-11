From: David Miller <davem@davemloft.net>
Date: Wed, 11 May 2011 17:10:52 +0000
Subject: Re: [PATCH]SPARC32: Fixed unaligned memory copying in function
Message-Id: <20110511.131052.330379691995448372.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1304845558.9492.14.camel@big>
In-Reply-To: <1304845558.9492.14.camel@big>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 11 May 2011 14:53:40 +0200

[ Warning, I'm testing a new email setup so if this looks strange
  or doesn't go out properly, my bad... ]

> I just wanted to add that I also got unaligned accesses in the
> checksum calculation on the SPARC32/LEON. Bad alignment is bad for
> performance of course, in my case the MNA-trap handler was erroneous
> storing incorrectly and that was the reason for me to notice it. I did
> not look at the reason for the unaligned access in the first place
> though.

I totally agree that, without question, we should fix this bug
in the 32-bit checksumming routines.  I just want to make sure
I absolutely understand the new logic before I apply the patch
:-)

>    sparc32: unaligned memory access (MNA) trap handler bug

And indeed, it's great that we've fixed this bug meanwhile too.

Thanks.
