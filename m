From: "David S. Miller" <davem@redhat.com>
Date: Fri, 16 Apr 2004 21:31:19 +0000
Subject: Re: 2.6.5+BK compile error: binfmt_elf on sparc64
Message-Id: <20040416143119.66551b6c.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0404141432210.643-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404141432210.643-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 14 Apr 2004 14:36:01 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> Yes, the patch fixes the warnings, it compiles and runs. I don't know
> whether 0xf0000000 is the right TASK_SIZE for 32-bit binaries but it
> seems to be:
> include/asm-sparc/page.h:#define PAGE_OFFSET  0xf0000000

This seems like a fine way to deal with this warning,
patch applied.
