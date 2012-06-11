From: David Miller <davem@davemloft.net>
Date: Mon, 11 Jun 2012 21:40:59 +0000
Subject: Re: [PATCH]: Remove redundant #ifdef CONFIG_SPARC64 check
Message-Id: <20120611.144059.2233235969165491243.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4FD65F3F.3040409@uwaterloo.ca>
In-Reply-To: <4FD65F3F.3040409@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sarah Nadi <snadi@uwaterloo.ca>
Date: Mon, 11 Jun 2012 17:12:31 -0400

> From: Sarah Nadi<snadi@uwaterloo.ca>
> 
> Summary: Unnecessary #ifdef check in arch/sparc/kernel/jump_label.c
> 
> Problem description: The #ifdef CONFIG_SPARC64 is unnecessary since
> the file is only compiled when CONFIG_SPARC64 is selected. Leaving it
> in makes the
> #ifdef block always selected while the #else block is never
> #selected. Suggested patch to remove unneccesary check below.

This is there so that sparc 32-bit support is easy to add for someone
so inclined, do not remove this.
