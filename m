From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Date: Mon, 13 Sep 2004 23:20:19 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20040913232019.GK30464@ruslug.rutgers.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Sep 13, 2004 at 03:49:40PM -0700, David S. Miller wrote:
> On Mon, 13 Sep 2004 18:47:13 -0400
> mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:
> 
> > So I should be able to boot a large vmlinux now ? How about compression,
> > is handling compressed kernels still an issue ? Should I be trying to
> > boot vmlimux or my own created gzip -9 vmlinux ?
> 
> It works, but you needn't do that.

Great, thanks. 

> > And is there any use to the image built as a result of `make image`? I
> > know its smaller, but what exactly goes into/out this kernel to make
> > it smaller?
> 
> The symbol table is stripped to the bare minimum.

Is the kernel fully functional like this? What's the downside to this?

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
