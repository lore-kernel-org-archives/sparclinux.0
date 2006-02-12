From: Ben Collins <bcollins@ubuntu.com>
Date: Sun, 12 Feb 2006 13:14:59 +0000
Subject: Re: Silo 1.4.10
Message-Id: <1139750099.15398.63.camel@grayson>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2006-02-10 at 19:32 -0500, Joe Ciccone wrote:
> I have been working on a patch for silo that would enable me to build it
> in a pure64 bit enviornment. The patch is of my current working tree.
> The .b files build properly with this patch, It creates a static
> libext2fs that I put together myself and then uses that instead of the
> system libext2fs library which is only available in 64bit in this setup.
(cut)

What's the deal with all the system headers you pulled in? Those things
should be in the userspace toolchain, and not in the SILO package
itself. If you are having issues with 64-bit vs. 32-bit asm headers,
please check how most of the sparc dists are handling that (dummy
headers in /usr/include/asm that point to asm-sparc{,64} depending on
__arch64__ being defined).

Aside from that it looks ok. Please clean it up, and I can include it
for the next SILO release.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux

