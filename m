From: "David S. Miller" <davem@redhat.com>
Date: Sun, 22 Feb 2004 22:00:04 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222140004.685ead87.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 22 Feb 2004 13:51:16 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> I had to run elftoaout myself to prep the thing for tftpboot; I'm not
> sure how likely that is to fail/etc. I did get the following warning:
> 
> $ elftoaout vmlinux-263 
> PT 0 Entry: Loadable to 0x400000[0x3ba110] from 0x0[0x370d58] align 0x100000
> PT 1 Entry: unknown
> 
> I'm not sure how to pick apart the a.out stuff to see if it did
> something wrong with the STACK bits in the phdr. 2.4 doesn't have
> a STACK phdr so I suspect I may be getting hit here, among many
> other places.

Oh man, not another fucking variable to debug in this thing.

Is it absolutely impossible for you to get a basic debian woody install on
this thing so you can boot kernels off the partition instead of purely net
booting? :(

Ben Collins and I may have messed up net booting when we added SILO+kernel
support for larger images, but it could also be this STACK phdr thing too.
