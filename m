From: "David S. Miller" <davem@redhat.com>
Date: Fri, 20 Aug 2004 21:05:29 +0000
Subject: Re: Buglet making vmlinux with -j
Message-Id: <20040820140529.6c013b03.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200408202156.06459.crn@netunix.com>
In-Reply-To: <200408202156.06459.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 20 Aug 2004 13:59:56 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Fri, Aug 20, 2004 at 09:56:06PM +0100, C.Newport wrote:
> > If I build a 2.4.27 kernel with -j6 to strsss test an SMP system 
> > it compiles but silently finishes before linking.
> > Is this a bug or expected behaviour ?
> 
> You're going to have to be more precise in your description for me to
> tell.

It's because of all the btfixup stuff in the sparc32
build machinery, William.

He doesn't need to give any more description, it is clear
what the issue is.
