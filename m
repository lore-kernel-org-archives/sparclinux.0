From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 03 May 2004 14:51:54 +0000
Subject: Re: Debian 3.01, kernel 2.6 compile error.
Message-Id: <20040503145154.GB20865@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <S263600AbUECFmn/20040503054243Z+38@vger.kernel.org>
In-Reply-To: <S263600AbUECFmn/20040503054243Z+38@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 03, 2004 at 01:42:36AM -0400, Jester 2.0 wrote:

> I have a SMP Ultra2 running woody with gcc (GCC) 3.3.3.  When compiling
> 2.6.5, I receive the following error.

> init/main.c:70: #error Sorry, your GCC is too old. It builds incorrect
> kernels.

gcc doesn't matter; check sparc64-linux-gcc -v.  You'll probably want
to check the debian archives for the solution.

-- 
Keith M Wesolowski
