From: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 31 Aug 2006 14:10:12 +0000
Subject: Re: generic__raw_read_trylock Considered Harmful
Message-Id: <20060831141012.GA29186@flint.arm.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20060831134254.GE4919@parisc-linux.org>
In-Reply-To: <20060831134254.GE4919@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org, takata@linux-m32r.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, linuxsh-dev@lists.sourceforge.net, wli@holomorphy.com, sparclinux@vger.kernel.org

On Thu, Aug 31, 2006 at 07:42:55AM -0600, Matthew Wilcox wrote:
> I propose we delete this from the tree, turning a rather nasty and hard
> to track down runtime failure into a simple to fix buildtime failure on
> the following architectures:

Thanks, I've just committed a fix for ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
