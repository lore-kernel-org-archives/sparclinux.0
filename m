From: "David S. Miller" <davem@redhat.com>
Date: Fri, 27 Aug 2004 20:12:14 +0000
Subject: Re: [PATCH] export more symbols on sparc32
Message-Id: <20040827131214.2b505140.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cgo2on$h2$1@sea.gmane.org>
In-Reply-To: <cgo2on$h2$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 27 Aug 2004 12:41:07 -0700
Joshua Kwan <joshk@triplehelix.org> wrote:

> Now, re: the pci hunk, it may not be worth applying; a better solution 
> might be to turn off PCI for sparc32.. I have never seen a PCI-gifted 
> sparc32 but the config is largely an 'allmodconfig' and I decided to 
> just see what would happen.

JavaStation systems have PCI.
