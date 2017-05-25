From: David Miller <davem@davemloft.net>
Date: Thu, 25 May 2017 03:45:04 +0000
Subject: Re: [PATCH] sparc64: Add 16GB hugepage support
Message-Id: <20170524.234504.246686489551587317.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1495672233-116815-1-git-send-email-nitin.m.gupta@oracle.com>
        <20170525033442.GB877@windriver.com>
In-Reply-To: <20170525033442.GB877@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paul.gortmaker@windriver.com
Cc: nitin.m.gupta@oracle.com, mike.kravetz@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, mhocko@suse.com, mingo@kernel.org, babu.moger@oracle.com, bob.picco@oracle.com, thomas.tai@oracle.com, pasha.tatashin@oracle.com, atish.patra@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 24 May 2017 23:34:42 -0400

> [[PATCH] sparc64: Add 16GB hugepage support] On 24/05/2017 (Wed 17:29) Nitin Gupta wrote:
> 
>> Orabug: 25362942
>> 
>> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> 
> If this wasn't an accidental git send-email misfire, then there should
> be a long log indicating the use case, the perforamnce increase, the
> testing that was done, etc. etc. 
> 
> Normally I'd not notice but since I was Cc'd I figured it was worth a
> mention -- for example the vendor ID above doesn't mean a thing to
> all the rest of us, hence why I suspect it was a git send-email misfire;
> sadly, I think we've all accidentally done that at least once....

Agreed.

No commit message whatsoever is basically unacceptable for something
like this.
