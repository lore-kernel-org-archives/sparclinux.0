From: David Miller <davem@davemloft.net>
Date: Tue, 20 Jun 2017 03:51:04 +0000
Subject: Re: [PATCH v3 1/4] sparc64: Add 16GB hugepage support
Message-Id: <20170619.235104.349838763068474531.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497923621-96708-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1497923621-96708-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, mhocko@suse.com, mingo@kernel.org, hughd@google.com, bob.picco@oracle.com, pasha.tatashin@oracle.com, steven.sistare@oracle.com, paul.gortmaker@windriver.com, thomas.tai@oracle.com, atish.patra@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


You need to provide a proper "[PATCH xxx 0/N] " header posting
explaining what the series is doing at a high level, how it is
doing it, and why it is doing it that way.

A patch series is a collection of related patches attempting to
achieve a specific high level end goal.

If, instead, these are just scattered unrelated changes, they do not
belong in a patch series and instead should be submitted individually.

Otherwise, if they belong together, you have to explain what that
grouping and purpose is in your header posting.

Thanks.
