From: David Miller <davem@davemloft.net>
Date: Tue, 28 Mar 2017 04:52:05 +0000
Subject: Re: [PATCH v2] arch/sparc: Avoid DCTI Couples
Message-Id: <20170327.215205.258837955824882595.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1489783941-509645-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1489783941-509645-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: babu.moger@oracle.com
Cc: rob.gardner@oracle.com, khalid.aziz@oracle.com, allen.pais@oracle.com, viro@zeniv.linux.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 17 Mar 2017 14:52:21 -0600

> Avoid un-intended DCTI Couples. Use of DCTI couples is deprecated.
> Also address the "Programming Note" for optimal performance.
> 
> Here is the complete text from Oracle SPARC Architecture Specs.
> 
> 6.3.4.7 DCTI Couples
> "A delayed control transfer instruction (DCTI) in the delay slot of
> another DCTI is referred to as a “DCTI couple”. The use of DCTI couples
> is deprecated in the Oracle SPARC Architecture; no new software should
> place a DCTI in the delay slot of another DCTI, because on future Oracle
> SPARC Architecture implementations DCTI couples may execute either
> slowly or differently than the programmer assumes it will.
> 
> SPARC V8 and SPARC V9 Compatibility Note
> The SPARC V8 architecture left behavior undefined for a DCTI couple. The
> SPARC V9 architecture defined behavior in that case, but as of
> UltraSPARC Architecture 2005, use of DCTI couples was deprecated.
> Software should not expect high performance from DCTI couples, and
> performance of DCTI couples should be expected to decline further in
> future processors.
> 
> Programming Note
> As noted in TABLE 6-5 on page 115, an annulled branch-always
> (branch-always with a = 1) instruction is not architecturally a DCTI.
> However, since not all implementations make that distinction, for
> optimal performance, a DCTI should not be placed in the instruction word
> immediately following an annulled branch-always instruction (BA,A or
> BPA,A)."
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Reviewed-by: Rob Gardner <rob.gardner@oracle.com>

Applied, thanks.
