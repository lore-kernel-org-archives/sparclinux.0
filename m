From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2016 17:34:43 +0000
Subject: Re: [PATCH v4] sparc64: Multi-page size support
Message-Id: <20161227.123443.298519048128182523.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1481652247-12751-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1481652247-12751-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, julian.calaby@gmail.com, hughd@google.com, adam.buchbinder@gmail.com, minchan@kernel.org, sfr@canb.auug.org.au, paul.gortmaker@windriver.com, thomas.tai@oracle.com, chris.hyser@oracle.com, atish.patra@oracle.com, mhocko@suse.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue, 13 Dec 2016 10:03:18 -0800

> +static unsigned int sun4u_huge_tte_to_shift(pte_t entry)
> +{
> +	unsigned long tte_szbits = pte_val(entry) & _PAGE_SZALL_4V;

Actually this should be _PAGE_SZALL_4U.
