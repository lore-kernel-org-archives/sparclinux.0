From: Ben Collins <bcollins@debian.org>
Date: Fri, 19 Aug 2005 11:31:29 +0000
Subject: Re: current_thread_info_reg undefined
Message-Id: <20050819113129.GA3711@swissdisk.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The warnings are actually longer (were before too):
> *** Warning: "" [drivers/net/ppp_deflate.ko] undefined!
> *** Warning: "" [drivers/net/ppp_deflate.ko] undefined!
> *** Warning: "" [drivers/net/ppp_deflate.ko] undefined!
> *** Warning: "current_thread_info_reg" [drivers/net/ppp_deflate.ko] undefined!

The empty symbol warnings atleast are just a bug with
scripts/mod/modpost.c (the patch fabbione sent you awhile back Dave, for
STT_SPARC_REGISTER changes in glibc's elf.h).

I think the current_thread_info_reg went away with that patch aswell. If
it didn't, I have a fix for that one aswell.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
