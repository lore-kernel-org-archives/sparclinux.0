From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:32:28 +0000
Subject: Re: [PATCH] sparc64: Add 64K page size support
Message-Id: <20170223.113228.1861707884493232179.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1486413269-99237-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1486413269-99237-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, sfr@canb.auug.org.au, paul.gortmaker@windriver.com, thomas.tai@oracle.com, chris.hyser@oracle.com, khalid.aziz@oracle.com, atish.patra@oracle.com, mhocko@suse.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon,  6 Feb 2017 12:33:26 -0800

> This patch depends on:
> [v6] sparc64: Multi-page size support
> 
> - Testing
> 
> Tested on Sonoma by running stream benchmark instance which allocated
> 48G worth of 64K pages.
> 
> boot params: default_hugepageszdK hugepageszdK hugepages10720
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

Also applied, thank you.
