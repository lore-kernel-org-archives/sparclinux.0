From: Meelis Roos <mroos@linux.ee>
Date: Fri, 19 Aug 2005 18:12:07 +0000
Subject: Re: current_thread_info_reg undefined
Message-Id: <Pine.SOC.4.61.0508192111180.16598@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The empty symbol warnings atleast are just a bug with
> scripts/mod/modpost.c (the patch fabbione sent you awhile back Dave, for
> STT_SPARC_REGISTER changes in glibc's elf.h).

Yes, the modules in question (at least some I tried) load fine.

-- 
Meelis Roos (mroos@linux.ee)
