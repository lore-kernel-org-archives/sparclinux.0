From: "David S. Miller" <davem@redhat.com>
Date: Sun, 22 Feb 2004 21:57:52 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222135752.5d94f6d5.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 22 Feb 2004 13:51:16 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> The way I captured the
> output as early as I did before was with this patch:

Try '-d' on the kernel command line instead, you're not the only person who has
needed this. :-)
