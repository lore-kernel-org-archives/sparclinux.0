From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 30 Dec 2004 12:13:25 +0000
Subject: Re: PAGE_SIZE and native vs. emulated 32-bit SPARC ABI
Message-Id: <20041230121325.GD29332@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041230110707.GC29332@holomorphy.com>
In-Reply-To: <20041230110707.GC29332@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 30 December 2004 11:07 am, William Lee Irwin III wrote:
>> It seems that most/all 32-bit SPARC programs are written and compiled
>> for emulated 32-bit on sun4u, which has an 8KB PAGE_SIZE, and returns
>> 8KB for getpagesize(). This is unfortunately causing spectacular
>> failures

On Thu, Dec 30, 2004 at 11:50:28AM +0000, C.Newport wrote:
> This sounds like a bug to me. 
> A 32 bit program should see the same kernel environment on 32 and 64 bit
> machines. There may be a case for saying that the compiler should also
> be aware of such issues when building a 32 bit model.
> Also see the kernel config stuff - the page size for ramdisks defaults to 
> 4096.

IMHO this is ABI emulation QOI. I personally just use the things for
ABI torture tests, and affected programs are somewhat uncommon. I think
dealing with this would involve personality handling in sparc32, since
it by and large is stuck bearing the burden of being compatible with
common usage on more modern 32-bit environments and not vice-versa,
which may very well be impossible.


-- wli
