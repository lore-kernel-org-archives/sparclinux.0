From: David Miller <davem@davemloft.net>
Date: Thu, 04 Jan 2018 01:57:03 +0000
Subject: Re: Separate kernel and userspace address spaces on Linux SPARC?
Message-Id: <20180103.205703.191862491334201468.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <9ce7f029-6894-5f69-0984-84a871b12979@physik.fu-berlin.de>
In-Reply-To: <9ce7f029-6894-5f69-0984-84a871b12979@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 3 Jan 2018 23:53:58 +0100

> While I have found literature that this applies to Solaris, I couldn't
> find any direct mentions of Linux on SPARC.
> 
> Does anyone of the SPARC kernel people know what the situation on Linux
> SPARC is?

The kernel and userspace live in entirely separate MMU TLB contexts on
Linux just like on Solaris.

So as far as I know it should be fine.
