From: David Miller <davem@davemloft.net>
Date: Fri, 10 Mar 2017 23:33:16 +0000
Subject: Re: [PATCH] arch/sparc: Avoid DCTI Couples
Message-Id: <20170310.153316.617706828550364653.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1489186023-429936-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1489186023-429936-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: babu.moger@oracle.com
Cc: rob.gardner@oracle.com, khalid.aziz@oracle.com, allen.pais@oracle.com, viro@zeniv.linux.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 10 Mar 2017 15:47:03 -0700

> Avoid un-intended DCTI Couples. Use of DCTI couples is deprecated.
> Refer UltraSPARC Architecture 2005(Section 6.3.4.7 - DCTI Couples).
> http://www.oracle.com/technetwork/systems/opensparc/1537734

An annulled branch-always has no delay slot.

These code sequences are intentional to keep code size down.

I'm not applying this.
