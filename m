From: "David S. Miller" <davem@redhat.com>
Date: Tue, 10 Aug 2004 00:28:12 +0000
Subject: Re: /dev/random lacks entropy on sparc64
Message-Id: <20040809172812.5524b362.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1092092360.7938.50.camel@duncow>
In-Reply-To: <1092092360.7938.50.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 10 Aug 2004 01:06:10 +0100
Richard Mortimer <richm@oldelvet.org.uk> wrote:

> >   Also, you forgot to shift down the
> > high bits before xor'ing it into 'num'.
> > 
> I didn't think that I did :-)

Indeed, you're right :-)

> The srlx would have done the shift and srl clears out the npt bit.

FWIW, we never set npt under Linux.
