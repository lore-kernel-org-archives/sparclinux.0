From: "C.Newport" <crn@netunix.com>
Date: Thu, 30 Dec 2004 11:50:28 +0000
Subject: Re: PAGE_SIZE and native vs. emulated 32-bit SPARC ABI
Message-Id: <200412301150.28806.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041230110707.GC29332@holomorphy.com>
In-Reply-To: <20041230110707.GC29332@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 30 December 2004 11:07 am, William Lee Irwin III wrote:
> It seems that most/all 32-bit SPARC programs are written and compiled
> for emulated 32-bit on sun4u, which has an 8KB PAGE_SIZE, and returns
> 8KB for getpagesize(). This is unfortunately causing spectacular
> failures

This sounds like a bug to me. 
A 32 bit program should see the same kernel environment on 32 and 64 bit
machines. There may be a case for saying that the compiler should also
be aware of such issues when building a 32 bit model.
Also see the kernel config stuff - the page size for ramdisks defaults to 
4096.

