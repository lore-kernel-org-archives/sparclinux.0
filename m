From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 07 Dec 2004 07:47:26 +0000
Subject: Re: mmap breakage
Message-Id: <20041206234726.05c43ed1.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 7 Dec 2004 01:31:02 -0500 (EST)
Jurij Smakov <jurij@wooyd.org> wrote:

> However, that's somehow different from running '/lib/ld-linux.so.2 ./a.out'
> (ldd actually does it). Once you invoke ld-linux.so.2 as an executable, 
> it's placement is controlled by ELF_ET_DYN_BASE, which is 0x08000000 for 
> ELF32 binaries by default.

What needs to execute ld-linux.so.2 directly in order to run
and has a huge data section? :-)  Is it some part of the GLIBC
build, perhaps during locale generation?
