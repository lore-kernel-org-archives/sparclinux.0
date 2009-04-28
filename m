From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 28 Apr 2009 18:01:51 +0000
Subject: Re: [PATCH] of: make of_(un)register_platform_driver common code.
Message-Id: <20090428110151.9fc6ee3f.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090428135821.8530.85153.stgit@localhost.localdomain>
In-Reply-To: <20090428135821.8530.85153.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: monstr@monstr.eu, linuxppc-dev@ozlabs.org, rpurdie@linux.intel.com, smaclennan@pikatech.com, sparclinux@vger.kernel.org, davem@davemloft.net, john.williams@petalogix.com

On Tue, 28 Apr 2009 07:58:26 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> Some drivers using of_register_platform_driver() wrapper break on sparc
> because the wrapper isn't in the header file.  This patch moves it from
> Microblaze and PowerPC implementations and makes it common code.

Thanks.  I'll plan to merge this into mainline later in the week.
