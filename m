From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Thu, 10 Aug 2017 21:45:41 +0000
Subject: Re: [PATCH V2] vDSO for SPARC
Message-Id: <f404e823-7007-e83d-22b5-46c2a13f96d6@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499268125-877874-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1499268125-877874-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 08/09/2017 10:21 PM, David Miller wrote:
> I want to apply this patch, but you will first need to respin it
> against sparc-next, f.e. sparc64_init_timers() doesn't exist in any of
> my trees any more but this patch tries to make changes there.

Thanks! I have sent the updated patch. One of the recent
changeset "sparc64: initialize time early" has removed the function.
I have modified my patch accordingly, re-compiled and re-tested it.

Thanks,
Nagarathnam.
>
> Thank you.

