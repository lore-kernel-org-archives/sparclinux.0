From: David Ahern <david.ahern@oracle.com>
Date: Wed, 22 Apr 2015 23:19:23 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <55382C7B.9070401@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/22/15 4:51 PM, David Miller wrote:
>
> David, are there any major M7 patches remaining for basic
> functionality?
>

I am not aware of anything for basic functionality.

Only thing left in my queue is optimized versions of the ffs / fls 
families, but that patch is v9b specific, not M7.

I'd like to put some attention on precise mode for perf counters; it 
just has not bubbled to the top.
