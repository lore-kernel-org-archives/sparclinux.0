From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 06 Jan 2014 20:39:37 +0000
Subject: Re: [PATCH] sparc: fix kgdb build failure due to context tracking
Message-Id: <52CB1489.20901@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1389037863-8866-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1389037863-8866-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 14-01-06 03:31 PM, David Miller wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Mon, 6 Jan 2014 14:51:03 -0500
> 
>> The following allmodconfig build failure is seen:
> 
> Not in Linus's tree, it's already fixed there.

Sorry for the dup; was testing the init.h cleanups on
the weekend's rc7 tag and didn't notice the fix was in
after that...
