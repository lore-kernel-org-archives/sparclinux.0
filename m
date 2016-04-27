From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 27 Apr 2016 10:09:20 +0000
Subject: Re: kernel boot broken since 4.5 on t5220 ( niagara2 ) machine
Message-Id: <20160427100920.GA25192@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <57207083.1000703@alcatel-lucent.com>
In-Reply-To: <57207083.1000703@alcatel-lucent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 27, 2016 at 09:55:47AM +0200, Joerg Abraham wrote:
> Hi,
> 
> since kernel version 4.5 my t5220 does not boot anymore, small logs
> attached...
> 
> bisecting the problem points to commit:
> 
> 1a40b95374f680625318ab61d81958e949e0afe3
> 
> or
> 
> 1a40b95 (sparc: Fix system call tracing register handling.)

Meelis Roos reported issues with the same commit.
See the thread "RED State Exception in 4.5 on E420R"

	Sam
