From: David Miller <davem@davemloft.net>
Date: Tue, 17 Oct 2006 07:19:56 +0000
Subject: Re: [PATCH] sparc32: remove '-s' boot argument
Message-Id: <20061017.001956.52167415.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061012152243.GA21924@palantir8>
In-Reply-To: <20061012152243.GA21924@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 13 Oct 2006 16:26:14 +0100

> I'm afraid my patch was not correct. Although the kernel does nothing
> with this flag, init does honour it and boots into single user mode.
> Adding the case statement back prevents the kernel from printing the
> message "Unknown boot switch (-s)" from the default case.
> 
> I did a sparc64 patch as well this time.
> 
> Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Thanks Martin.

Instead of having all of these changes going back and forth,
I'm just going to code up one changeset that does it right :)
