From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 10 Nov 2004 00:49:42 +0000
Subject: Re: sunzilog possible bug
Message-Id: <20041109164942.0f677253.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1099784090.10262.112.camel@gaston>
In-Reply-To: <1099784090.10262.112.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 07 Nov 2004 10:34:49 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I found recently a bug in pmac_zilog, which originates from sunzilog who so might
> have the same problem. The "timeout" member of the port structure was never
> initialized, causing very long pauses to happen on port close, that is pretty much
> all the time when hitting userland.
> 
> Quick untested patch (I don't have a sparc)

Looks good to me, I'll apply this to my tree.

Thanks Benjamic.
