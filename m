From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 28 Dec 2004 03:27:47 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to
Message-Id: <20041227192747.5bce4dc1.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 27 Dec 2004 19:06:57 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> By and large I'd prefer to discourage userspace code from using
> kernel headers. Does this work in a significant number of other
> arches as things stand now?

Glibc includes them.  It works for sparc64 and a lot of this
is painless stuff to include.
