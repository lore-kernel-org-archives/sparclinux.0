From: David Miller <davem@davemloft.net>
Date: Sat, 21 Oct 2006 06:37:45 +0000
Subject: Re: Building silo against 2.6.18 kernel headers
Message-Id: <20061020.233745.34759384.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061021041849.GA4720@droopy.oc.cox.net>
In-Reply-To: <20061021041849.GA4720@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 20 Oct 2006 21:18:49 -0700

> Due to some changes in the kernel headers, introduced in 2.6.18 (the 
> struct ufs_super_block was split into three different structs 
> ufs_super_block_{first,second,third}), silo no longer builds against 
> them. I came up with the patch for it (attached).

SILO should ship it's own ufs.h header file so that this will
never be an issue.  That's the real long-term solution for
this.


