From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 14 Feb 2005 16:13:22 +0000
Subject: Re: size-differences of long(userspace) / long(kernel)
Message-Id: <20050214081322.487e152e.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


See arch/sparc64/kernel/ioctl32.c, we translate all of the
structures on the way in and out of userspace when 64-bit
kernel runs 32-bit applications.
