From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 08 Jan 2009 20:30:03 +0000
Subject: Re: [PATCH] fix warnings in psycho_common after ull conversion
Message-Id: <200901082030.n08KU3n14435@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090108192723.GA27674@uranus.ravnborg.org>
In-Reply-To: <20090108192723.GA27674@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just FYI:

>I tried the alternative solution and made IOMMU_PAGE_SHIFT an ULL
>but that did not help.

The type of (X << Y) is independent of the type of Y.  Which means
that these (unchanged) defines:

> #define  PSYCHO_IOMMU_TAG_WRITE	 (0x1UL << 21UL)
> #define  PSYCHO_IOMMU_TAG_STREAM (0x1UL << 20UL)
> #define  PSYCHO_IOMMU_TAG_SIZE	 (0x1UL << 19UL)

have extra ULs in them.  (Harmlessly, though.)

(I think some truly ancient versions of gcc, perhaps 1.x or 2.x,
accidentally used the type of Y in computing a type for X<<Y, which
might be where this started.)

Chris
