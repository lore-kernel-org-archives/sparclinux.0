From: "David S. Miller" <davem@redhat.com>
Date: Thu, 01 Jul 2004 04:56:40 +0000
Subject: Re: dma_get_required_mask() breaks sparc64
Message-Id: <20040630215640.70d729e1.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1088655333.2382.29.camel@ori.thedillows.org>
In-Reply-To: <1088655333.2382.29.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01 Jul 2004 00:15:33 -0400
David Dillow <dave@thedillows.org> wrote:

> Building with the latest BK (as of 2200 EST) breaks sparc64 builds. This
> may be related to the fact that I only enable SBUS and not PCI, but I
> think it is more general.
> 
> The attached patch (untested, but compiling) seems to fix the issue,
> though it may not be the proper place to add the include.

Thanks for the report, I'll take a look at this.
