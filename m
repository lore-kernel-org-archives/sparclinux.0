From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 23 Feb 2004 00:34:50 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040223003450.GO703@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

At some point in the past, davem wrote:
>> Ben Collins and I may have messed up net booting when we added SILO+kernel
>> support for larger images, but it could also be this STACK phdr thing too.

On Sun, Feb 22, 2004 at 06:57:12PM -0500, Ben Collins wrote:
> My big kernel testing worked with net booting, but I didn't use
> elftoaout, I booted the elf image directly.

OpenBoot 3.2.30 doesn't seem to netboot ELF directly; how did you do it?


-- wli
