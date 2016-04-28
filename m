From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 28 Apr 2016 17:22:50 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <1461864170.2307.19.camel@HansenPartnership.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2016-04-28 at 19:43 +0800, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Because some architectures (alpha, armv6, etc.) don't provide 
> hardware division, the mod operation is slow! Binary GCD algorithm 
> uses simple arithmetic operations, it replaces division with 
> arithmetic shifts, comparisons, and subtractions.
> 
> I have compiled successfully with x86_64_defconfig and 
> i386_defconfig.

What's the reason for wanting to optimize this and thus have to
maintain (and test) two separate code paths, which is a significant
expense? As far as I can see, gcd() is mosly used in finding optimal
clocks for operations, which is usually done at start of day and not
time critical.

James


