From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 13 Sep 2004 23:32:15 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20040913163215.4823d1d9.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 13 Sep 2004 19:20:19 -0400
mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:

> > > And is there any use to the image built as a result of `make image`? I
> > > know its smaller, but what exactly goes into/out this kernel to make
> > > it smaller?
> > 
> > The symbol table is stripped to the bare minimum.
> 
> Is the kernel fully functional like this?

Yes, fully.

> What's the downside to this?

No symbols means it's harder to examine the kernel image
using tools like 'gdb' and 'nm', but System.map still contains
the full symbol table information so even this point is moot.
