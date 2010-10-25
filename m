From: David Miller <davem@davemloft.net>
Date: Mon, 25 Oct 2010 15:59:37 +0000
Subject: Re: [PATCH 2/3] sparc32: remove CONFIG_HAVE_PERF_EVENTS option
Message-Id: <20101025.085937.226775583.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1288021958-3130-1-git-send-email-namhyung@gmail.com>
	<1288021958-3130-2-git-send-email-namhyung@gmail.com>
In-Reply-To: <1288021958-3130-2-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: namhyung@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 26 Oct 2010 00:52:37 +0900

> Remove HAVE_PERF_EVENTS and PERF_USE_VMALLOC under config
> SPARC because they're under SPARC64 too. Supporting
> perf_event needs atomic64 operations but AFAIK sparc32
> doesn't provide them, CMIIW. ;-) Also removes redundant
> HAVE_IRQ_WORK line.
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

The generic non-hw perf event stuff builds fine on sparc32,
please don't remove this unless you have a legitimate build
failure to report and fix.

Even if sparc32 doesn't provide atomic64_t support, it very
easily could do so using include/asm-generic/atomic64.h which
implements them using spinlocks.
