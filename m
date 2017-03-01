From: Andi Kleen <andi@firstfloor.org>
Date: Wed, 01 Mar 2017 15:19:10 +0000
Subject: Re: [PATCH v2 1/3] sparc64: NG4 memset 32 bits overflow
Message-Id: <20170301151910.GH26852@two.firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
 <1488327283-177710-2-git-send-email-pasha.tatashin@oracle.com>
 <87h93dhmir.fsf@firstfloor.org>
 <70b638b0-8171-ffce-c0c5-bdcbae3c7c46@oracle.com>
In-Reply-To: <70b638b0-8171-ffce-c0c5-bdcbae3c7c46@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-mm@kvack.org, sparclinux@vger.kernel.org

> - Even if the default maximum size is reduced the size of these
> tables should still be tunable, as it really depends on the way
> machine is used, and in it is possible that for some use patterns
> large hash tables are necessary.

I consider it very unlikely that a 8G dentry hash table ever makes
sense. I cannot even imagine a workload where you would have that
many active files. It's just a bad configuration that should be avoided.

And when the tables are small enough you don't need these hacks.

-Andi
