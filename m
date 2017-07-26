From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 23:41:57 +0000
Subject: Re: Reproducer for sparc64 kernel lock-up bug
Message-Id: <20170726.164157.920854855224958220.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a1bac634-7b19-3238-1a39-6c8484b32bf5@physik.fu-berlin.de>
In-Reply-To: <a1bac634-7b19-3238-1a39-6c8484b32bf5@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 21 Jul 2017 16:28:01 +0200

> When running the attached, statically linked binary on a recent
> kernel, the kernel locks up with:

Thanks a lot, as soon as I sort through the RCU stall bug I'll take
a close look at this!
