From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 21 Dec 2004 07:58:12 +0000
Subject: Re: [4/3] fix initrd memcpy
Message-Id: <20041220235812.6ba77b91.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221045627.GC771@holomorphy.com>
In-Reply-To: <20041221045627.GC771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 20 Dec 2004 23:00:25 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Mon, Dec 20, 2004 at 10:39:01PM -0800, William Lee Irwin III wrote:
> > This looks tremendously cleaner. I'll look for an ack to see if there
> > are actively participating users lingering about with toolchains that
> > do something unintelligible out of paranoia and then send an analogue
> > of this upstream.
> 
> tentative sparc32 analogue (not booted it yet):

Won't work, you have to fixup the memcpy.S code to return
the original destination pointer.

And you can't use the SETUP_RETL et al. stuff already there
since %g6 is used for the current thread pointer.
