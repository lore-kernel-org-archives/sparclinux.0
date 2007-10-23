From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 23 Oct 2007 18:12:38 +0000
Subject: Re: LTP results on 2.6.23 sparc32
Message-Id: <1193163158.22958.66.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20071022231034.GA17612@palantir8>
In-Reply-To: <20071022231034.GA17612@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tue, 2007-10-23 at 00:10 +0100, Martin Habets wrote:
> Here's a summary of the Linux Test Project run on
> the latest sparc git tree. I'm focussing on the blocking
> tests first, but it's slow going.
> 
> Test systems:
> palantir9	SS20, 2x ROSS Hypersparc, 320MB
> palantir13	SS10, 2x SuperSparc II, 128MB
> 
> Kernel:
> 2.6.23-mph4 SMP from the sparc-2.6.git tree. Last commit:

Its impressive that the SMP kernel is even booting into userspace. Last
time I tried, it was not.

You may want to start with UP here, then move to SMP once you've cleared
those failures out.

Keep in mind that sparc (not sparc64) is an unmaintained arch.

~spot

