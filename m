From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 08:28:34 +0000
Subject: Re: [4/3] fix initrd memcpy
Message-Id: <20041221082834.GH771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221045627.GC771@holomorphy.com>
In-Reply-To: <20041221045627.GC771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 20 Dec 2004 23:00:25 -0800 William Lee Irwin III wrote:
>> tentative sparc32 analogue (not booted it yet):

On Mon, Dec 20, 2004 at 11:58:12PM -0800, David S. Miller wrote:
> Won't work, you have to fixup the memcpy.S code to return
> 
> And you can't use the SETUP_RETL et al. stuff already there
> since %g6 is used for the current thread pointer.

Amazingly, the kernel runs anyway, but I'll do that.


-- wli
