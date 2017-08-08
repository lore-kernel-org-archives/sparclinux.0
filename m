From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 08 Aug 2017 12:49:55 +0000
Subject: Re: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
Message-Id: <a777718a-00b5-fb3a-75d6-03cc7ad181d9@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
 <20170808090743.GA12887@arm.com>
 <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
 <20170808123042.GG13355@arm.com>
In-Reply-To: <20170808123042.GG13355@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Will,

 > Damn, I actually prefer the flag :)
 >
 > But actually, if you look at our implementation of vmemmap_populate, 
then we
 > have our own version of vmemmap_populate_basepages that terminates at the
 > pmd level anyway if ARM64_SWAPPER_USES_SECTION_MAPS. If there's 
resistance
 > to do this in the core code, then I'd be inclined to replace our
 > vmemmap_populate implementation in the arm64 code with a single 
version that
 > can terminate at either the PMD or the PTE level, and do zeroing if
 > required. We're already special-casing it, so we don't really lose 
anything
 > imo.

Another approach is to create a new mapping interface for kasan only. As 
what Ard Biesheuvel wrote:

 > KASAN uses vmemmap_populate as a convenience: kasan has nothing to do
 > with vmemmap, but the function already existed and happened to do what
 > KASAN requires.
 >
 > Given that that will no longer be the case, it would be far better to
 > stop using vmemmap_populate altogether, and clone it into a KASAN
 > specific version (with an appropriate name) with the zeroing folded
 > into it.

I agree with this statement, but I think it should not be part of this 
project.

Pasha
