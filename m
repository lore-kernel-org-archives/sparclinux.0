From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 13 Sep 2004 22:49:40 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20040913154940.72542a65.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 13 Sep 2004 18:47:13 -0400
mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:

> So I should be able to boot a large vmlinux now ? How about compression,
> is handling compressed kernels still an issue ? Should I be trying to
> boot vmlimux or my own created gzip -9 vmlinux ?

It works, but you needn't do that.

> And is there any use to the image built as a result of `make image`? I
> know its smaller, but what exactly goes into/out this kernel to make
> it smaller?

The symbol table is stripped to the bare minimum.
