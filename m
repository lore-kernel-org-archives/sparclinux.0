From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 26 Jan 2005 08:26:10 +0000
Subject: Re: FPU context switching fix for SMP
Message-Id: <20050126082610.GK10843@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <41f753cabb795@wp.pl>
In-Reply-To: <41f753cabb795@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 26, 2005 at 09:24:42AM +0100, Krzysztof Helt wrote:
> Here is a patch for FPU context switching in SMP.
> A copy_thread() function clears PF_USEDFPU flag for a new thread,
> but it does not clear the PSR_EF bit. Thus, a first FPU exception
> called from the child thread is not handled properly. I made the
> patch after PPC and MIPS architectures - both clear a similar bit
> in copy_thread.
> This bug does not exist in the UP kernel, probably because it
> does not rely on PF_USEDFPU flag.
> The patch below should be applied for both 2.4 and 2.6 branches.
> I tested it with a test-fenv program from  glibc testsuite. The
> test fails the same test cases in both SMP and UP with  the patch
> applied. Without the patch, the test on SMP kernel failes in
> almost two times more testcases.

Are you sure a bugfix merits a copyright attribution? It's atypical
elsewhere...


-- wli
