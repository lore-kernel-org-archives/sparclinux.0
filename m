From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Date: Mon, 13 Sep 2004 22:47:13 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20040913224713.GJ30464@ruslug.rutgers.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Sep 13, 2004 at 03:38:45PM -0700, David S. Miller wrote:
> On Mon, 13 Sep 2004 18:21:02 -0400
> mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:
> 
> > I also would like an explanation as
> > to this 2.6 MB kernel size limitation.
> 
> It was a bootloader limitation which is fixed in current
> SILO bootloader versions.

Thanks Dave,

So I should be able to boot a large vmlinux now ? How about compression,
is handling compressed kernels still an issue ? Should I be trying to
boot vmlimux or my own created gzip -9 vmlinux ?

Also why is the compressed kernel not made at `make` time and not put
in:

arch/sparc64/boot/

?

And is there any use to the image built as a result of `make image`? I
know its smaller, but what exactly goes into/out this kernel to make
it smaller?

	Luis

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
