From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 25 Mar 2005 22:56:12 +0000
Subject: Re: running 2.6.* on sparc with Creator 3D and ATY Mach64
Message-Id: <20050325145612.5efbcb60.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87vf7f7nws.fsf@video.uic.vsu.ru>
In-Reply-To: <87vf7f7nws.fsf@video.uic.vsu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 25 Mar 2005 23:14:58 +0300
Vladimir Volovich <vvv@vsu.ru> wrote:

> Thanks for your answer; it is strange that when running kernel 2.4.27,
> i have no problems with running X (and also the framebuffer console
> works perfectly too).
> 
> Is this a limitation introduced into 2.6.* kernels? Is it going to be
> resolved?

It's a bug in the X server in that it doesn't probe the PCI
bus correctly when running on a 2.6.x kernel on sparc64.  The
directory naming under /proc/bus/pci got changed in order to
support PCI domains correctly.

The changes are known, someone just has to do the work to backport
things into the current X sources debian uses.

There is a thread about this recently, check the archives.  It was
about 2 weeks ago, there was even a reference to the patch.
